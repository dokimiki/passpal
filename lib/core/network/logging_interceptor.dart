import 'dart:developer' as dev;
import 'package:dio/dio.dart';
import 'package:dio_curl_interceptor/dio_curl_interceptor.dart';
import 'package:flutter/foundation.dart';

/// Interceptor that logs HTTP requests as cURL commands in debug mode
class LoggingInterceptor extends Interceptor {
  LoggingInterceptor() : _curlInterceptor = kDebugMode ? CurlInterceptor() : null;

  final CurlInterceptor? _curlInterceptor;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      dev.log(
        'HTTP Request: ${options.method} ${options.uri}',
        name: 'NetworkClient',
      );
      
      // Log headers (excluding sensitive ones)
      if (options.headers.isNotEmpty) {
        final sanitizedHeaders = Map<String, dynamic>.from(options.headers);
        _sanitizeHeaders(sanitizedHeaders);
        dev.log(
          'Headers: $sanitizedHeaders',
          name: 'NetworkClient',
        );
      }
      
      // Use cURL interceptor for detailed logging
      _curlInterceptor?.onRequest(options, handler);
    } else {
      handler.next(options);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      dev.log(
        'HTTP Response: ${response.statusCode} ${response.requestOptions.uri}',
        name: 'NetworkClient',
      );
      
      // Log response size if available
      final contentLength = response.headers.value('content-length');
      if (contentLength != null) {
        dev.log(
          'Response size: $contentLength bytes',
          name: 'NetworkClient',
        );
      }
      
      _curlInterceptor?.onResponse(response, handler);
    } else {
      handler.next(response);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      dev.log(
        'HTTP Error: ${err.type} ${err.requestOptions.uri}',
        name: 'NetworkClient',
        error: err.message,
        stackTrace: err.stackTrace,
      );
      
      if (err.response != null) {
        dev.log(
          'Error Response: ${err.response!.statusCode} ${err.response!.statusMessage}',
          name: 'NetworkClient',
        );
      }
      
      _curlInterceptor?.onError(err, handler);
    } else {
      handler.next(err);
    }
  }

  void _sanitizeHeaders(Map<String, dynamic> headers) {
    const sensitiveHeaders = {
      'authorization',
      'cookie',
      'set-cookie',
      'x-api-key',
      'x-auth-token',
    };

    for (final key in headers.keys.toList()) {
      if (sensitiveHeaders.contains(key.toLowerCase())) {
        headers[key] = '[REDACTED]';
      }
    }
  }
}
