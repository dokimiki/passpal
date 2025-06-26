import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import '../error/app_exception.dart';

/// Interceptor that checks network connectivity before making requests
class ConnectivityInterceptor extends Interceptor {
  ConnectivityInterceptor(this._connectivity);

  final Connectivity _connectivity;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final connectivityResults = await _connectivity.checkConnectivity();
      
      // Check if any connection is available
      if (connectivityResults.contains(ConnectivityResult.none)) {
        handler.reject(
          DioException(
            requestOptions: options,
            error: const NetworkFailure.offline(
              message: 'No internet connection available',
            ),
            type: DioExceptionType.connectionError,
          ),
        );
        return;
      }

      handler.next(options);
    } catch (e) {
      // If connectivity check fails, allow the request to proceed
      // The actual network error will be caught by the request itself
      handler.next(options);
    }
  }
}
