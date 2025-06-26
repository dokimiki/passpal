import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:passpal/core/storage/secure/credential_storage.dart';
import 'package:passpal/core/storage/secure/flutter_secure_storage_credential_storage.dart';
import 'package:passpal/core/storage/kv/key_value_cache.dart';
import 'package:passpal/core/storage/kv/shared_prefs_key_value_cache.dart';
import 'package:passpal/core/storage/cache_policy/cache_policy.dart';
import 'package:passpal/core/storage/cache_policy/default_cache_policy.dart';
import 'package:passpal/core/storage/prefs/user_prefs.dart';
import 'package:passpal/core/storage/prefs/shared_prefs_user_prefs.dart';

/// SharedPreferencesインスタンスのProvider
/// 初期化時にオーバーライドされる必要がある
final sharedPrefsProvider = Provider<SharedPreferences>((_) {
  throw UnimplementedError(
    'SharedPreferencesProvider must be overridden with actual instance',
  );
});

/// 認証情報の暗号化保存を提供するProvider
final credentialStorageProvider = Provider<CredentialStorage>((_) {
  return const FlutterSecureStorageCredentialStorage();
});

/// JSONデータのキャッシュを提供するProvider
final keyValueCacheProvider = Provider<KeyValueCache>((ref) {
  final prefs = ref.watch(sharedPrefsProvider);
  return SharedPrefsKeyValueCache(prefs);
});

/// キャッシュポリシー（TTL判定）を提供するProvider
final cachePolicyProvider = Provider<CachePolicy>((_) {
  return const DefaultCachePolicy();
});

/// ユーザー設定を提供するProvider
final userPrefsProvider = Provider<UserPrefs>((ref) {
  final prefs = ref.watch(sharedPrefsProvider);
  return SharedPrefsUserPrefs(prefs);
});
