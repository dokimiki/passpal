import 'package:dio/dio.dart';

class ManaboMailViewRemoteDs {
  final Dio _dio;
  
  const ManaboMailViewRemoteDs(this._dio);
  
  /// MaNaBoメール詳細を取得
  Future<String> fetchMailView(String mailId) async {
    final response = await _dio.get(
      '/',
      queryParameters: {
        'mail_id': mailId,
        'action': 'glexa_modal_mail_view',
        '_': DateTime.now().millisecondsSinceEpoch,
      },
    );
    return response.data as String;
  }
}
