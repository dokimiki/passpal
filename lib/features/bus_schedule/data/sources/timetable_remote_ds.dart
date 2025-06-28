import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'timetable_remote_ds.g.dart';

/// Remote data source for timetable data
class TimetableRemoteDataSource {
  const TimetableRemoteDataSource(this._client);

  final Dio _client;

  /// Fetch timetable data from the API
  Future<Map<String, dynamic>> fetchTimetable() async {
    try {
      final response = await _client.get('/app/api/timetable');

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Invalid response format from timetable API');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }
}

@riverpod
TimetableRemoteDataSource timetableRemoteDataSource(Ref ref) {
  // Create a simple Dio client for timetable API
  final client = Dio(
    BaseOptions(baseUrl: 'https://link.lanet.sist.chukyo-u.ac.jp'),
  );
  return TimetableRemoteDataSource(client);
}
