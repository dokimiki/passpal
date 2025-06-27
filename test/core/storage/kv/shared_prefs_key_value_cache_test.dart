import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:passpal/core/storage/kv/shared_prefs_key_value_cache.dart';
import 'package:passpal/core/storage/errors/storage_exception.dart';

import 'shared_prefs_key_value_cache_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SharedPreferences>()])
void main() {
  group('SharedPrefsKeyValueCache', () {
    late MockSharedPreferences mockPrefs;
    late SharedPrefsKeyValueCache cache;

    setUp(() {
      mockPrefs = MockSharedPreferences();
      cache = SharedPrefsKeyValueCache(mockPrefs);
    });

    tearDown(() async {
      await cache.dispose();
    });

    group('putJson', () {
      test('should save JSON data and notify stream', () async {
        const key = 'test_key';
        final data = {'name': 'test', 'value': 42};

        when(mockPrefs.getString(key)).thenReturn(null);
        when(mockPrefs.setString(key, any)).thenAnswer((_) async => true);

        // ストリームを監視
        final stream = cache.watchJson(key);
        final streamData = <Map<String, dynamic>?>[];
        final subscription = stream.listen(streamData.add);

        // 初期値を待つ
        await Future.delayed(const Duration(milliseconds: 50));

        // データを保存
        await cache.putJson(key, data);

        // 少し待ってからチェック
        await Future.delayed(const Duration(milliseconds: 10));

        // JSON文字列として保存されることを確認
        verify(
          mockPrefs.setString(key, '{"name":"test","value":42}'),
        ).called(1);

        // ストリームに通知されることを確認（初期値null + 新しいデータ）
        expect(streamData.length, greaterThanOrEqualTo(2));
        expect(streamData.last, equals(data));

        await subscription.cancel();
      });

      test('should throw KvIoException when save fails', () async {
        const key = 'test_key';
        final data = {'name': 'test'};

        when(mockPrefs.setString(key, any)).thenThrow(Exception('Prefs error'));

        await expectLater(
          () => cache.putJson(key, data),
          throwsA(
            isA<KvIoException>()
                .having((e) => e.operation, 'operation', 'putJson')
                .having(
                  (e) => e.message,
                  'message',
                  contains('Failed to save JSON data'),
                ),
          ),
        );
      });
    });

    group('watchJson', () {
      test('should return null for non-existent key', () async {
        const key = 'non_existent';

        when(mockPrefs.getString(key)).thenReturn(null);

        final stream = cache.watchJson(key);

        await expectLater(stream.first, completion(isNull));
      });

      test('should return existing JSON data', () async {
        const key = 'existing_key';
        const jsonString = '{"name":"test","value":42}';
        final expectedData = {'name': 'test', 'value': 42};

        when(mockPrefs.getString(key)).thenReturn(jsonString);

        final stream = cache.watchJson(key);

        await expectLater(stream.first, completion(equals(expectedData)));
      });

      test('should emit error for invalid JSON', () async {
        const key = 'invalid_json_key';
        const invalidJson = 'invalid json';

        when(mockPrefs.getString(key)).thenReturn(invalidJson);

        final stream = cache.watchJson(key);

        await expectLater(
          stream.first,
          throwsA(
            isA<DeserializeException>()
                .having((e) => e.key, 'key', key)
                .having(
                  (e) => e.message,
                  'message',
                  contains('Failed to deserialize JSON data'),
                ),
          ),
        );
      });

      test('should reuse stream controller for same key', () async {
        const key = 'same_key';

        when(mockPrefs.getString(key)).thenReturn(null);

        final stream1 = cache.watchJson(key);
        final stream2 = cache.watchJson(key);

        // broadcast streamなので、同じcontrollerのstreamだが、異なるsubscription
        expect(stream1, equals(stream2));
      });
    });

    group('remove', () {
      test('should remove data and notify stream', () async {
        const key = 'test_key';

        when(mockPrefs.getString(key)).thenReturn(null);
        when(mockPrefs.remove(key)).thenAnswer((_) async => true);

        // ストリームを監視
        final stream = cache.watchJson(key);
        final streamData = <Map<String, dynamic>?>[];
        final subscription = stream.listen(streamData.add);

        // 初期値を待つ
        await Future.delayed(const Duration(milliseconds: 50));

        // データを削除
        await cache.remove(key);

        // 少し待ってからチェック
        await Future.delayed(const Duration(milliseconds: 10));

        verify(mockPrefs.remove(key)).called(1);

        // ストリームにnullが通知されることを確認
        expect(streamData.length, greaterThanOrEqualTo(1));
        expect(streamData.last, isNull);

        await subscription.cancel();
      });

      test('should throw KvIoException when remove fails', () async {
        const key = 'test_key';

        when(mockPrefs.remove(key)).thenThrow(Exception('Prefs error'));

        await expectLater(
          () => cache.remove(key),
          throwsA(
            isA<KvIoException>()
                .having((e) => e.operation, 'operation', 'remove')
                .having(
                  (e) => e.message,
                  'message',
                  contains('Failed to remove data'),
                ),
          ),
        );
      });
    });
  });
}
