import 'package:dio/dio.dart';

/// Cubics時間割データソース
abstract class CubicsTimetableRemoteDataSource {
  /// 教室情報を取得
  Future<String> fetchRoomsHtml();
}

class CubicsTimetableRemoteDataSourceImpl
    implements CubicsTimetableRemoteDataSource {
  const CubicsTimetableRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<String> fetchRoomsHtml() async {
    const path = '/unias/UnSSOLoginControl2';
    final response = await _dio.get(
      path,
      queryParameters: {
        'REQ_ACTION_DO': '/ARF010.do',
        'REQ_PRFR_MNU_ID': 'MNUIDSTD0103',
      },
    );

    if (response.statusCode == 200) {
      return response.data as String;
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        message: 'Failed to fetch rooms: ${response.statusCode}',
      );
    }
  }
}
