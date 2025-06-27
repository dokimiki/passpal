import 'package:dio/dio.dart';
import '../error/app_exception.dart';

/// Interceptor that detects maintenance mode responses
class MaintenanceInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (_isMaintenanceResponse(err)) {
      final maintenanceException = MaintenanceException(
        message: _extractMaintenanceMessage(err),
        estimatedEndTime: _extractEstimatedEndTime(err),
      );

      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: maintenanceException,
          type: DioExceptionType.badResponse,
          response: err.response,
        ),
      );
      return;
    }

    handler.next(err);
  }

  bool _isMaintenanceResponse(DioException error) {
    final response = error.response;
    if (response == null || response.statusCode != 503) {
      return false;
    }

    final responseData = response.data?.toString().toLowerCase() ?? '';

    // Check for maintenance indicators in the response
    const maintenanceKeywords = [
      'maintenance',
      'メンテナンス',
      'システムメンテナンス',
      'under maintenance',
      'service unavailable',
      'temporarily unavailable',
    ];

    return maintenanceKeywords.any(
      (keyword) => responseData.contains(keyword.toLowerCase()),
    );
  }

  String _extractMaintenanceMessage(DioException error) {
    final response = error.response;
    if (response == null) {
      return 'システムメンテナンス中です';
    }

    final responseData = response.data?.toString() ?? '';

    // Try to extract a more specific message from the response
    // This is a simple implementation - could be enhanced with HTML parsing
    if (responseData.contains('メンテナンス')) {
      return 'システムメンテナンス中です。しばらく時間をおいてから再度お試しください。';
    } else if (responseData.contains('maintenance')) {
      return 'System is under maintenance. Please try again later.';
    }

    return 'サービスが一時的に利用できません';
  }

  DateTime? _extractEstimatedEndTime(DioException error) {
    // TODO: Implement parsing of estimated end time from response
    // This would require parsing HTML/JSON response for maintenance schedules
    return null;
  }
}
