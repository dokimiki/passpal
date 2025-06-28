import 'package:dio/dio.dart';

/// MaNaBo時間割データソース
abstract class ManaboTimetableRemoteDataSource {
  /// 時間割HTMLを取得
  Future<String> fetchTimetableHtml(int archiveId);

  /// 利用可能学期一覧を取得
  Future<String> fetchAvailableTermsHtml();
}

class ManaboTimetableRemoteDataSourceImpl
    implements ManaboTimetableRemoteDataSource {
  const ManaboTimetableRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<String> fetchTimetableHtml(int archiveId) async {
    final response = await _dio.post(
      '/',
      data: {
        'action': 'glexa_ajax_timetable_view',
        'archive_id': archiveId.toString(),
      },
      options: Options(contentType: 'application/x-www-form-urlencoded'),
    );

    if (response.statusCode == 200) {
      return response.data as String;
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        message: 'Failed to fetch timetable: ${response.statusCode}',
      );
    }
  }

  @override
  Future<String> fetchAvailableTermsHtml() async {
    final response = await _dio.get('/');

    if (response.statusCode == 200) {
      return response.data as String;
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        message: 'Failed to fetch available terms: ${response.statusCode}',
      );
    }
  }
}
