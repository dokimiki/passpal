import 'package:dio/dio.dart';

class ManaboSystemNewsRemoteDs {
  final Dio _dio;
  
  const ManaboSystemNewsRemoteDs(this._dio);
  
  /// MaNaBoシステムお知らせを取得
  Future<String> fetchSystemNews() async {
    final response = await _dio.post(
      '/',
      data: 'action=glexa_ajax_news_list',
      options: Options(
        contentType: 'application/x-www-form-urlencoded',
      ),
    );
    return response.data as String;
  }
}
