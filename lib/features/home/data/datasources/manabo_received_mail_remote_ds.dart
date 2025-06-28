import 'package:dio/dio.dart';

class ManaboReceivedMailRemoteDs {
  final Dio _dio;

  const ManaboReceivedMailRemoteDs(this._dio);

  /// MaNaBo受信メール一覧を取得
  Future<String> fetchReceivedMail({int page = 1}) async {
    final response = await _dio.post(
      '/',
      data: 'p=$page&action=glexa_ajax_mail_receive_list',
      options: Options(contentType: 'application/x-www-form-urlencoded'),
    );
    return response.data as String;
  }
}
