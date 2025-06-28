import 'package:dio/dio.dart';

class AlboNewsRemoteDs {
  final Dio _dio;

  const AlboNewsRemoteDs(this._dio);

  /// ALBOお知らせを取得
  Future<String> fetchAlboNews() async {
    // TODO: 実際のURLパスを設定する必要があります
    // _list.csvの情報では具体的なパスが不明なため、プレースホルダーとして設定
    final response = await _dio.get('/uniprove_pt/portal/_ns:YXJ...');
    return response.data as String;
  }
}
