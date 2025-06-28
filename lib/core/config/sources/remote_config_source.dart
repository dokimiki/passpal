import 'dart:async';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:passpal/core/config/sources/config_source.dart';
import 'package:passpal/core/config/exceptions/config_exception.dart';

/// Firebase Remote Configからの設定を提供するソース
class RemoteConfigSource implements ConfigSource {
  RemoteConfigSource(this._remoteConfig);

  final FirebaseRemoteConfig _remoteConfig;
  final StreamController<String> _configChangeController =
      StreamController<String>.broadcast();
  final Map<String, _CacheEntry> _cache = {};
  late StreamSubscription _configSubscription;

  static const Duration _cacheDuration = Duration(minutes: 15);

  @override
  String get sourceName => 'RemoteConfig';

  @override
  Future<void> initialize() async {
    try {
      // Remote Configの初期設定
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(minutes: 1),
        ),
      );

      // 初回フェッチとアクティベート
      await _remoteConfig.fetchAndActivate();

      // 設定変更の監視
      _configSubscription = _remoteConfig.onConfigUpdated.listen((event) {
        _configChangeController.add('config_updated');
        _clearCache();
      });
    } catch (e) {
      throw ConfigSourceException(
        message: 'Failed to initialize Remote Config: $e',
        source: sourceName,
        stack: StackTrace.current,
      );
    }
  }

  @override
  Future<String?> getString(String key) async {
    return _getCachedValue<String>(key, () {
      final value = _remoteConfig.getString(key);
      return value.isNotEmpty ? value : null;
    });
  }

  @override
  Future<bool?> getBool(String key) async {
    return _getCachedValue<bool>(key, () {
      try {
        return _remoteConfig.getBool(key);
      } catch (e) {
        return null;
      }
    });
  }

  @override
  Future<int?> getInt(String key) async {
    return _getCachedValue<int>(key, () {
      try {
        return _remoteConfig.getInt(key);
      } catch (e) {
        return null;
      }
    });
  }

  @override
  Future<double?> getDouble(String key) async {
    return _getCachedValue<double>(key, () {
      try {
        return _remoteConfig.getDouble(key);
      } catch (e) {
        return null;
      }
    });
  }

  @override
  Stream<String> get onConfigChanged => _configChangeController.stream;

  @override
  Future<void> dispose() async {
    await _configSubscription.cancel();
    await _configChangeController.close();
  }

  /// キャッシュ付きで値を取得
  Future<T?> _getCachedValue<T>(String key, T? Function() getValue) async {
    final cacheEntry = _cache[key];

    if (cacheEntry != null && !cacheEntry.isExpired) {
      return cacheEntry.value as T?;
    }

    try {
      await _fetchIfNeeded();
      final value = getValue();
      if (value != null) {
        _cache[key] = _CacheEntry(value, DateTime.now().add(_cacheDuration));
      }
      return value;
    } catch (e) {
      // キャッシュされた値がある場合はそれを返す
      return (cacheEntry?.value as T?);
    }
  }

  /// 必要に応じてRemote Configをフェッチ
  Future<void> _fetchIfNeeded() async {
    try {
      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      // フェッチ失敗時はキャッシュされた値を使用
    }
  }

  /// キャッシュをクリア
  void _clearCache() {
    _cache.clear();
  }
}

/// Remote Configのキャッシュエントリ
class _CacheEntry {
  _CacheEntry(this.value, this.expiry);

  final dynamic value;
  final DateTime expiry;

  bool get isExpired => DateTime.now().isAfter(expiry);
}
