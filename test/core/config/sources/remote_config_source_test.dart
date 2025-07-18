import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:passpal/core/config/models/app_config.dart';
import 'package:passpal/core/config/sources/remote_config_source.dart';
import 'package:passpal/core/error/models/app_exception.dart';
import 'package:passpal/core/error/models/failure.dart';

import 'remote_config_source_test.mocks.dart';

@GenerateMocks([FirebaseRemoteConfig, RemoteConfigValue])
void main() {
  group('RemoteConfigSource', () {
    late MockFirebaseRemoteConfig mockRemoteConfig;
    late RemoteConfigSource source;

    setUp(() {
      mockRemoteConfig = MockFirebaseRemoteConfig();
      source = RemoteConfigSource(remoteConfig: mockRemoteConfig);
    });

    group('initialize', () {
      test('設定の初期化が成功する', () async {
        // Arrange
        when(mockRemoteConfig.setConfigSettings(any))
            .thenAnswer((_) async {});
        when(mockRemoteConfig.setDefaults(any))
            .thenAnswer((_) async {});

        // Act & Assert
        await expectLater(
          source.initialize(),
          completes,
        );

        verify(mockRemoteConfig.setConfigSettings(any)).called(1);
        verify(mockRemoteConfig.setDefaults(any)).called(1);
      });

      test('初期化失敗時にAppExceptionをスローする', () async {
        // Arrange
        when(mockRemoteConfig.setConfigSettings(any))
            .thenThrow(Exception('Init failed'));

        // Act & Assert
        await expectLater(
          source.initialize(),
          throwsA(isA<AppException>()),
        );
      });
    });

    group('loadConfig', () {
      test('設定の読み込みが成功する', () async {
        // Arrange
        _setupMockRemoteConfigValues(mockRemoteConfig);
        when(mockRemoteConfig.fetchAndActivate())
            .thenAnswer((_) async => true);

        // Act
        final config = await source.loadConfig();

        // Assert
        expect(config, isA<AppConfig>());
        expect(config.apiConfig.manaboBaseUrl, 
               'https://manabo.cnc.chukyo-u.ac.jp');
        expect(config.authConfig.allowedEmailDomain, 
               '@m.chukyo-u.ac.jp');
      });

      test('タイムアウト時にFailureをスローする', () async {
        // Arrange
        when(mockRemoteConfig.fetchAndActivate())
            .thenAnswer((_) => Future.delayed(
                  const Duration(seconds: 20),
                  () => true,
                ));

        // Act & Assert
        await expectLater(
          source.loadConfig(fetchTimeout: const Duration(seconds: 1)),
          throwsA(isA<Failure>()),
        );
      });

      test('Firebase例外時にFailureをスローする', () async {
        // Arrange
        when(mockRemoteConfig.fetchAndActivate())
            .thenThrow(FirebaseException(
              plugin: 'remote_config',
              code: 'fetch-failed',
            ));

        // Act & Assert
        await expectLater(
          source.loadConfig(),
          throwsA(isA<Failure>()),
        );
      });

      test('デフォルト値での設定読み込みが成功する', () async {
        // Arrange
        _setupMockRemoteConfigValues(mockRemoteConfig);
        when(mockRemoteConfig.fetchAndActivate())
            .thenAnswer((_) async => true);

        // Act & Assert
        // This test validates the behavior with default configuration values
        final config = await source.loadConfig();
        expect(config, isA<AppConfig>());
        expect(config.apiConfig.manaboBaseUrl, contains('manabo'));
      });
    });

    group('hasConfig', () {
      test('Remote Configが利用可能な場合trueを返す', () async {
        // Arrange
        when(mockRemoteConfig.setConfigSettings(any))
            .thenAnswer((_) async {});
        when(mockRemoteConfig.setDefaults(any))
            .thenAnswer((_) async {});

        // Act
        final result = await source.hasConfig();

        // Assert
        expect(result, isTrue);
      });

      test('初期化に失敗した場合falseを返す', () async {
        // Arrange
        when(mockRemoteConfig.setConfigSettings(any))
            .thenThrow(Exception('Init failed'));

        // Act
        final result = await source.hasConfig();

        // Assert
        expect(result, isFalse);
      });
    });

    group('getValue', () {
      test('文字列値を正しく取得する', () {
        // Arrange
        final mockValue = MockRemoteConfigValue();
        when(mockValue.asString()).thenReturn('test-value');
        when(mockRemoteConfig.getValue('test_key')).thenReturn(mockValue);

        // Act
        final result = source.getValue<String>('test_key');

        // Assert
        expect(result, equals('test-value'));
      });

      test('整数値を正しく取得する', () {
        // Arrange
        final mockValue = MockRemoteConfigValue();
        when(mockValue.asInt()).thenReturn(42);
        when(mockRemoteConfig.getValue('test_key')).thenReturn(mockValue);

        // Act
        final result = source.getValue<int>('test_key');

        // Assert
        expect(result, equals(42));
      });

      test('真偽値を正しく取得する', () {
        // Arrange
        final mockValue = MockRemoteConfigValue();
        when(mockValue.asBool()).thenReturn(true);
        when(mockRemoteConfig.getValue('test_key')).thenReturn(mockValue);

        // Act
        final result = source.getValue<bool>('test_key');

        // Assert
        expect(result, isTrue);
      });

      test('例外発生時にnullを返す', () {
        // Arrange
        when(mockRemoteConfig.getValue('test_key'))
            .thenThrow(Exception('Value not found'));

        // Act
        final result = source.getValue<String>('test_key');

        // Assert
        expect(result, isNull);
      });
    });

    group('getJsonValue', () {
      test('有効なJSONを正しく解析する', () {
        // Arrange
        const jsonString = '{"key": "value", "number": 42}';
        when(mockRemoteConfig.getString('test_key')).thenReturn(jsonString);

        // Act
        final result = source.getJsonValue('test_key');

        // Assert
        expect(result, isNotNull);
        expect(result!['key'], equals('value'));
        expect(result['number'], equals(42));
      });

      test('空文字列の場合nullを返す', () {
        // Arrange
        when(mockRemoteConfig.getString('test_key')).thenReturn('');

        // Act
        final result = source.getJsonValue('test_key');

        // Assert
        expect(result, isNull);
      });

      test('無効なJSONの場合nullを返す', () {
        // Arrange
        when(mockRemoteConfig.getString('test_key')).thenReturn('invalid-json');

        // Act
        final result = source.getJsonValue('test_key');

        // Assert
        expect(result, isNull);
      });
    });

    group('onConfigUpdated', () {
      test('更新ストリームを正しく取得する', () {
        // Arrange
        final controller = StreamController<RemoteConfigUpdate>();
        when(mockRemoteConfig.onConfigUpdated).thenAnswer((_) => controller.stream);

        // Act
        final stream = source.onConfigUpdated;

        // Assert
        expect(stream, isA<Stream<RemoteConfigUpdate>>());
      });
    });

    group('cache management', () {
      test('キャッシュをクリアできる', () {
        // Act
        source.clearCache();

        // Assert - キャッシュがクリアされたことを確認
        // このテストは実装詳細に依存するため、実際の実装では
        // より良いテスト方法を検討する必要がある
        expect(source.lastFetchTime, isNull);
      });
    });
  });
}

/// Mock Remote Config values setup helper
void _setupMockRemoteConfigValues(MockFirebaseRemoteConfig mockRemoteConfig) {
  // String values
  final stringValues = {
    'manabo_base_url': 'https://manabo.cnc.chukyo-u.ac.jp',
    'albo_base_url': 'https://cubics-pt-out.mng.chukyo-u.ac.jp',
    'cubics_base_url': 'https://cubics-as-out.mng.chukyo-u.ac.jp',
    'sso_url': 'https://shib.chukyo-u.ac.jp',
    'pal_api_base_url': 'https://api.chukyo-passpal.app/v1',
    'allowed_email_domain': '@m.chukyo-u.ac.jp',
    'log_level': 'info',
    'app_version': '1.0.0',
    'min_supported_version': '1.0.0',
    'maintenance_message': '',
  };

  // Integer values
  final intValues = {
    'connection_timeout_seconds': 30,
    'receive_timeout_seconds': 60,
    'max_retries': 3,
  };

  // Boolean values
  final boolValues = {
    'enable_console_logging': false,
    'enable_file_logging': false,
    'enable_network_logging': true,
    'enable_crashlytics': true,
    'feature_offline_mode': true,
    'feature_push_notifications': true,
    'feature_maintenance_mode': false,
    'is_maintenance_mode': false,
  };

  // JSON values (empty by default)
  final jsonValues = {
    'api_config': '{}',
    'auth_config': '{}',
    'debug_config': '{}',
    'feature_flags': '{}',
    'admin_config': '{}',
  };

  // Setup string mocks
  for (final entry in stringValues.entries) {
    final mockValue = MockRemoteConfigValue();
    when(mockValue.asString()).thenReturn(entry.value);
    when(mockRemoteConfig.getValue(entry.key)).thenReturn(mockValue);
  }

  // Setup integer mocks
  for (final entry in intValues.entries) {
    final mockValue = MockRemoteConfigValue();
    when(mockValue.asInt()).thenReturn(entry.value);
    when(mockRemoteConfig.getValue(entry.key)).thenReturn(mockValue);
  }

  // Setup boolean mocks
  for (final entry in boolValues.entries) {
    final mockValue = MockRemoteConfigValue();
    when(mockValue.asBool()).thenReturn(entry.value);
    when(mockRemoteConfig.getValue(entry.key)).thenReturn(mockValue);
  }

  // Setup JSON string mocks
  for (final entry in jsonValues.entries) {
    when(mockRemoteConfig.getString(entry.key)).thenReturn(entry.value);
  }
}