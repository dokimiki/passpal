import 'package:dio/dio.dart';

/// Remote data source for MaNaBo assignments
class ManaboAssignmentsRemoteDs {
  final Dio _client;

  const ManaboAssignmentsRemoteDs(this._client);

  /// Fetch timetable HTML for a specific term
  Future<String> fetchTimetable(String term) async {
    final response = await _client.post(
      '/',
      data: {'action': 'glexa_ajax_timetable_view', 'term': term},
      options: Options(contentType: 'application/x-www-form-urlencoded'),
    );

    return response.data as String;
  }

  /// Fetch class directory HTML
  Future<String> fetchClassDirectory(String classId, String directoryId) async {
    final response = await _client.post(
      '/',
      data: {
        'action': 'glexa_ajax_class_directory_list',
        'class_id': classId,
        'directory_id': directoryId,
      },
      options: Options(contentType: 'application/x-www-form-urlencoded'),
    );

    return response.data as String;
  }

  /// Fetch class content HTML
  Future<String> fetchClassContent(String classId, String directoryId) async {
    final response = await _client.post(
      '/',
      data: {
        'action': 'glexa_ajax_class_content_list',
        'class_id': classId,
        'directory_id': directoryId,
      },
      options: Options(contentType: 'application/x-www-form-urlencoded'),
    );

    return response.data as String;
  }

  /// Fetch quiz result HTML/JSON
  Future<String> fetchQuizResult(Map<String, String> queryParams) async {
    final response = await _client.get(
      '/',
      queryParameters: {
        'action': 'plugin_quiz_ajax_result_list',
        ...queryParams,
      },
    );

    return response.data as String;
  }
}
