import 'package:flutter/material.dart';

/// ユーザー設定の永続化を行うインターフェース
abstract interface class UserPrefs {
  /// テーマモードの取得
  ThemeMode get theme;

  /// テーマモードの設定
  Future<void> setTheme(ThemeMode mode);

  /// キャンパスの取得
  String? get campus;

  /// キャンパスの設定
  Future<void> setCampus(String value);

  /// 通知設定の取得
  bool get notificationsEnabled;

  /// 通知設定の変更
  Future<void> setNotificationsEnabled(bool enabled);
}
