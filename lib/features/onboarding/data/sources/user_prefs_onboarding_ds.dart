import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:passpal/features/onboarding/data/models/onboarding_status.dart';

/// Data source for onboarding preferences using SharedPreferences directly
class UserPrefsOnboardingDataSource {
  const UserPrefsOnboardingDataSource(this._prefs);

  final SharedPreferences _prefs;

  static const String _onboardingKey = 'pref.onboarding.status';

  /// Read the current onboarding status from preferences
  Future<OnboardingStatus> read() async {
    final jsonString = _prefs.getString(_onboardingKey);
    if (jsonString != null) {
      try {
        final json = jsonDecode(jsonString) as Map<String, dynamic>;
        return OnboardingStatus.fromJson(json);
      } catch (e) {
        // パースエラーの場合はデフォルト値を返す
        return const OnboardingStatus();
      }
    }
    return const OnboardingStatus();
  }

  /// Save the onboarding status to preferences
  Future<void> save(OnboardingStatus status) async {
    final jsonString = jsonEncode(status.toJson());
    await _prefs.setString(_onboardingKey, jsonString);
  }

  /// Clear the onboarding status (for testing/debugging)
  Future<void> clear() async {
    await _prefs.remove(_onboardingKey);
  }
}
