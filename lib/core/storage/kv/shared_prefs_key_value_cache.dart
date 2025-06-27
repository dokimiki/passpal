import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:passpal/core/storage/kv/key_value_cache.dart';
import 'package:passpal/core/storage/errors/storage_exception.dart';

/// SharedPreferencesを使用したKeyValueCacheの実装
class SharedPrefsKeyValueCache implements KeyValueCache {
  SharedPrefsKeyValueCache(this._prefs);

  final SharedPreferences _prefs;
  final Map<String, StreamController<Map<String, dynamic>?>> _controllers = {};

  @override
  Future<void> putJson(String key, Map<String, dynamic> value) async {
    try {
      final jsonString = jsonEncode(value);
      await _prefs.setString(key, jsonString);

      // ストリームに変更を通知
      final controller = _controllers[key];
      if (controller != null && !controller.isClosed) {
        controller.add(value);
      }
    } catch (e) {
      throw KvIoException(
        operation: 'putJson',
        message: 'Failed to save JSON data with key: $key',
        cause: e,
      );
    }
  }

  @override
  Stream<Map<String, dynamic>?> watchJson(String key) {
    // 既存のcontrollerがあれば再利用
    if (_controllers.containsKey(key)) {
      final controller = _controllers[key]!;
      if (!controller.isClosed) {
        return controller.stream;
      }
    }

    // 新しいStreamControllerを作成
    final controller = StreamController<Map<String, dynamic>?>.broadcast(
      onCancel: () {
        // 最後のリスナーがキャンセルされた時にcontrollerを削除
        _controllers.remove(key);
      },
    );
    _controllers[key] = controller;

    // 初期値を非同期で取得して送信
    Timer.run(() => _loadInitialValue(key, controller));

    return controller.stream;
  }

  Future<void> _loadInitialValue(
    String key,
    StreamController<Map<String, dynamic>?> controller,
  ) async {
    try {
      final jsonString = _prefs.getString(key);
      if (jsonString != null) {
        final json = jsonDecode(jsonString) as Map<String, dynamic>;
        if (!controller.isClosed) {
          controller.add(json);
        }
      } else {
        if (!controller.isClosed) {
          controller.add(null);
        }
      }
    } catch (e) {
      if (!controller.isClosed) {
        controller.addError(
          DeserializeException(
            key: key,
            message: 'Failed to deserialize JSON data',
            cause: e,
          ),
        );
      }
    }
  }

  @override
  Future<void> remove(String key) async {
    try {
      await _prefs.remove(key);

      // ストリームに削除を通知
      final controller = _controllers[key];
      if (controller != null && !controller.isClosed) {
        controller.add(null);
      }
    } catch (e) {
      throw KvIoException(
        operation: 'remove',
        message: 'Failed to remove data with key: $key',
        cause: e,
      );
    }
  }

  /// 全てのStreamControllerを閉じる（テスト用）
  Future<void> dispose() async {
    final controllers = List<StreamController<Map<String, dynamic>?>>.from(
      _controllers.values,
    );
    _controllers.clear();

    for (final controller in controllers) {
      if (!controller.isClosed) {
        await controller.close();
      }
    }
  }
}
