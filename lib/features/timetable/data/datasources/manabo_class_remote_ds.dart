import 'package:dio/dio.dart';

/// MaNaBo授業情報データソース
abstract class ManaboClassRemoteDataSource {
  /// 授業ディレクトリ取得
  Future<String> fetchDirectory(int classId, {int directoryId = 0});

  /// 授業お知らせ取得
  Future<String> fetchNews(int classId, {int directoryId = 0});

  /// シラバス取得
  Future<String> fetchSyllabus(int classId);

  /// 授業コンテンツ取得
  Future<String> fetchContent(int classId, int directoryId);

  /// クイズ結果取得
  Future<String> fetchQuizResult({
    required int pluginId,
    required int classId,
    required int id,
    required int directoryId,
    required int attendId,
    int result = 0,
    int page = 0,
  });
}

class ManaboClassRemoteDataSourceImpl implements ManaboClassRemoteDataSource {
  const ManaboClassRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<String> fetchDirectory(int classId, {int directoryId = 0}) async {
    final response = await _dio.post(
      '/',
      data: {
        'class_id': classId.toString(),
        'directory_id': directoryId.toString(),
        'action': 'glexa_ajax_class_directory_list',
      },
      options: Options(contentType: 'application/x-www-form-urlencoded'),
    );

    if (response.statusCode == 200) {
      return response.data as String;
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        message: 'Failed to fetch directory: ${response.statusCode}',
      );
    }
  }

  @override
  Future<String> fetchNews(int classId, {int directoryId = 0}) async {
    final response = await _dio.post(
      '/',
      data: {
        'class_id': classId.toString(),
        'directory_id': directoryId.toString(),
        'action': 'glexa_ajax_class_news_list',
      },
      options: Options(contentType: 'application/x-www-form-urlencoded'),
    );

    if (response.statusCode == 200) {
      return response.data as String;
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        message: 'Failed to fetch news: ${response.statusCode}',
      );
    }
  }

  @override
  Future<String> fetchSyllabus(int classId) async {
    final response = await _dio.post(
      '/',
      data: {
        'class_id': classId.toString(),
        'action': 'addon_syllabus_api_top',
      },
      options: Options(contentType: 'application/x-www-form-urlencoded'),
    );

    if (response.statusCode == 200) {
      return response.data as String;
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        message: 'Failed to fetch syllabus: ${response.statusCode}',
      );
    }
  }

  @override
  Future<String> fetchContent(int classId, int directoryId) async {
    final response = await _dio.post(
      '/',
      data: {
        'class_id': classId.toString(),
        'directory_id': directoryId.toString(),
        'action': 'glexa_ajax_class_content_list',
      },
      options: Options(contentType: 'application/x-www-form-urlencoded'),
    );

    if (response.statusCode == 200) {
      return response.data as String;
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        message: 'Failed to fetch content: ${response.statusCode}',
      );
    }
  }

  @override
  Future<String> fetchQuizResult({
    required int pluginId,
    required int classId,
    required int id,
    required int directoryId,
    required int attendId,
    int result = 0,
    int page = 0,
  }) async {
    final response = await _dio.get(
      '/',
      queryParameters: {
        'plugin_id': pluginId.toString(),
        'classId': classId.toString(),
        'id': id.toString(),
        'directory_id': directoryId.toString(),
        'attend_id': attendId.toString(),
        'result': result.toString(),
        'p': page.toString(),
        'action': 'plugin_quiz_ajax_result_list',
        '_': DateTime.now().millisecondsSinceEpoch.toString(),
      },
    );

    if (response.statusCode == 200) {
      return response.data as String;
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        message: 'Failed to fetch quiz result: ${response.statusCode}',
      );
    }
  }
}
