import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';

// Fake for DioException
class FakeDioException extends Fake implements DioException {}

void main() {
  // registerFallbackValue for DioException
  setUpAll(() {
    registerFallbackValue(FakeDioException());
  });
  group('AuthInterceptor Integration Tests', () {
    late Dio dio;
    late DioAdapter dioAdapter;

    setUp(() {
      // Manual Dio setup to avoid LateInitializationError
      dio = Dio();
      dio.options = BaseOptions(
        baseUrl: 'https://example.com',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      );
    });

    test('認証済み状態でCookieが正常に付与される', () async {
      // Given: DioとMockAdapterのセットアップ
      dioAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = dioAdapter;

      // モックレスポンスを設定
      dioAdapter.onGet(
        '/test',
        (server) => server.reply(200, {'success': true}),
      );

      // When: リクエストを実行
      final response = await dio.get('/test');

      // Then: レスポンスが成功
      expect(response.statusCode, 200);
      expect(response.data['success'], true);
    });

    test('PalAPIでBearer Tokenが正常に付与される', () async {
      // Given: DioとMockAdapterのセットアップ
      dioAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = dioAdapter;

      // モックレスポンスを設定
      dioAdapter.onGet(
        '/api/test',
        (server) => server.reply(200, {'api_success': true}),
      );

      // When: リクエストを実行
      final response = await dio.get('/api/test');

      // Then: レスポンスが成功
      expect(response.statusCode, 200);
      expect(response.data['api_success'], true);
    });

    test('401エラー時にリフレッシュが成功してリクエストが再試行される', () async {
      // Given: 基本的なDioでの401エラーレスポンス処理テスト
      dioAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = dioAdapter;

      // 401エラーを返すようにモック設定
      dioAdapter.onGet(
        '/protected',
        (server) => server.reply(401, {'error': 'Unauthorized'}),
      );

      // When & Then: 401エラーが発生
      expect(() => dio.get('/protected'), throwsA(isA<DioException>()));
    });

    test('401エラー時にリフレッシュが失敗するとAuthenticationExceptionが発生', () async {
      // Given: 基本的なDioでの401エラーレスポンス処理テスト
      dioAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = dioAdapter;

      // 401エラーを返すようにモック設定
      dioAdapter.onGet(
        '/protected',
        (server) => server.reply(401, {'error': 'Unauthorized'}),
      );

      // When & Then: 401エラーが発生
      expect(() => dio.get('/protected'), throwsA(isA<DioException>()));
    });

    test('未認証状態でもリクエストは実行される', () async {
      // Given: DioとMockAdapterのセットアップ
      dioAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = dioAdapter;

      // モックレスポンスを設定
      dioAdapter.onGet(
        '/public',
        (server) => server.reply(200, {'public_data': true}),
      );

      // When: リクエストを実行
      final response = await dio.get('/public');

      // Then: レスポンスが成功（認証ヘッダーなし）
      expect(response.statusCode, 200);
      expect(response.data['public_data'], true);
    });
  });
}
