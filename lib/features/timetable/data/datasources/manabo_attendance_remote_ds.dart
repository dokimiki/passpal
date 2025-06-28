import 'package:dio/dio.dart';

/// MaNaBo出席データソース
abstract class ManaboAttendanceRemoteDataSource {
  /// 出席状態確認
  Future<Map<String, dynamic>> checkAttendanceState(int classId);

  /// 出席フォーム情報取得
  Future<String> fetchAttendanceForm(int classId);

  /// 出席登録
  Future<Map<String, dynamic>> submitAttendance({
    required int classId,
    required String entryId,
    required String uniqid,
    String? password,
  });
}

class ManaboAttendanceRemoteDataSourceImpl
    implements ManaboAttendanceRemoteDataSource {
  const ManaboAttendanceRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<Map<String, dynamic>> checkAttendanceState(int classId) async {
    final response = await _dio.post(
      '/',
      data: {
        'class_id': classId.toString(),
        'is_ajax': '1',
        'action': 'glexa_modal_entry_form',
      },
      options: Options(contentType: 'application/x-www-form-urlencoded'),
    );

    if (response.statusCode == 200) {
      return response.data as Map<String, dynamic>;
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        message: 'Failed to check attendance state: ${response.statusCode}',
      );
    }
  }

  @override
  Future<String> fetchAttendanceForm(int classId) async {
    final response = await _dio.get(
      '/',
      queryParameters: {
        'class_id': classId.toString(),
        'action': 'glexa_modal_entry_form',
        '_': DateTime.now().millisecondsSinceEpoch.toString(),
      },
    );

    if (response.statusCode == 200) {
      return response.data as String;
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        message: 'Failed to fetch attendance form: ${response.statusCode}',
      );
    }
  }

  @override
  Future<Map<String, dynamic>> submitAttendance({
    required int classId,
    required String entryId,
    required String uniqid,
    String? password,
  }) async {
    final queryParams = {
      'action': 'glexa_modal_entry_form_accept',
      'class_id': classId.toString(),
      'directory_id': '0',
      'entry_id': entryId,
      'uniqid': uniqid,
      '_': DateTime.now().millisecondsSinceEpoch.toString(),
    };

    if (password != null) {
      queryParams['code'] = password;
    }

    final response = await _dio.get('/', queryParameters: queryParams);

    if (response.statusCode == 200) {
      return response.data as Map<String, dynamic>;
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        message: 'Failed to submit attendance: ${response.statusCode}',
      );
    }
  }
}
