import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'holidays_remote_ds.g.dart';

/// Remote data source for Japanese holidays
class HolidaysRemoteDataSource {
  const HolidaysRemoteDataSource(this._client);

  final Dio _client;

  /// Fetch Japanese holidays from the API
  Future<Map<String, dynamic>> fetchHolidays() async {
    try {
      final response = await _client.get(
        'https://holidays-jp.github.io/api/v1/date.json',
      );

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Invalid response format from holidays API');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }
}

@riverpod
HolidaysRemoteDataSource holidaysRemoteDataSource(Ref ref) {
  // Create a simple Dio client for external API
  final client = Dio();
  return HolidaysRemoteDataSource(client);
}
