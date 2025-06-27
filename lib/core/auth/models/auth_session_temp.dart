import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_session_temp.freezed.dart';
part 'auth_session_temp.g.dart';

/// 認証済みセッション情報
@freezed
abstract class AuthSessionTemp with _$AuthSessionTemp {
  const factory AuthSessionTemp({
    required String username,
    required Map<String, String> cookies,
    String? firebaseIdToken,
    required DateTime expiresAt,
    required DateTime lastRefreshed,
  }) = _AuthSessionTemp;

  factory AuthSessionTemp.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionTempFromJson(json);
}
