import 'dart:math';
import 'package:dio/dio.dart';

/// Interceptor that retries failed requests with exponential backoff
class RetryInterceptor extends Interceptor {
  RetryInterceptor({
    this.maxRetries = 3,
    this.baseDelay = const Duration(milliseconds: 500),
    this.backoffFactor = 2.0,
    this.jitterPercent = 30,
  });

  final int maxRetries;
  final Duration baseDelay;
  final double backoffFactor;
  final int jitterPercent; // ±30%

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final extra = err.requestOptions.extra;
    final retryCount = extra['retry_count'] as int? ?? 0;

    // Check if we should retry
    if (!_shouldRetry(err, retryCount)) {
      handler.next(err);
      return;
    }

    // Calculate delay with exponential backoff and jitter
    final delay = _calculateDelay(retryCount);
    await Future.delayed(delay);

    // Increment retry count
    final newOptions = err.requestOptions.copyWith(
      extra: {...extra, 'retry_count': retryCount + 1},
    );

    try {
      final response = await Dio().fetch(newOptions);
      handler.resolve(response);
    } catch (e) {
      if (e is DioException) {
        handler.next(e);
      } else {
        handler.next(
          DioException(
            requestOptions: newOptions,
            error: e,
            type: DioExceptionType.unknown,
          ),
        );
      }
    }
  }

  bool _shouldRetry(DioException error, int retryCount) {
    // Don't retry if we've exceeded max retries
    if (retryCount >= maxRetries) {
      return false;
    }

    // Don't retry non-idempotent methods unless explicitly allowed
    if (!_isIdempotentMethod(error.requestOptions.method)) {
      return false;
    }

    // Only retry on specific error types
    return switch (error.type) {
      DioExceptionType.connectionTimeout => true,
      DioExceptionType.sendTimeout => true,
      DioExceptionType.receiveTimeout => true,
      DioExceptionType.connectionError => true,
      DioExceptionType.badResponse => _shouldRetryStatusCode(
        error.response?.statusCode,
      ),
      _ => false,
    };
  }

  bool _isIdempotentMethod(String method) {
    const idempotentMethods = {'GET', 'HEAD', 'PUT', 'DELETE', 'OPTIONS'};
    return idempotentMethods.contains(method.toUpperCase());
  }

  bool _shouldRetryStatusCode(int? statusCode) {
    if (statusCode == null) return false;

    // Retry on 5xx server errors, but not on 4xx client errors
    return statusCode >= 500 && statusCode < 600;
  }

  Duration _calculateDelay(int retryCount) {
    // Exponential backoff: baseDelay * (backoffFactor ^ retryCount)
    final exponentialDelay =
        baseDelay.inMilliseconds * pow(backoffFactor, retryCount);

    // Add jitter: ±jitterPercent%
    final random = Random();
    final jitterRange = exponentialDelay * jitterPercent / 100;
    final jitter = (random.nextDouble() - 0.5) * 2 * jitterRange;

    final totalDelayMs = (exponentialDelay + jitter).round().clamp(
      0,
      30000,
    ); // Max 30s

    return Duration(milliseconds: totalDelayMs);
  }
}
