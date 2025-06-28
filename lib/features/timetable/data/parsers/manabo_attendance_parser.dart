import 'package:html/parser.dart' as html;
import '../models/attendance_dto.dart';

/// MaNaBo出席関連HTMLパーサー
class ManaboAttendanceParser {
  /// 出席フォーム情報を解析
  static AttendanceFormDto? parseAttendanceForm(String htmlContent) {
    final document = html.parse(htmlContent);

    // entryIdとuniqidを取得
    String? entryId;
    String? uniqid;
    bool requiresPassword = false;

    // hiddenフィールドから取得
    final hiddenInputs = document.querySelectorAll('input[type="hidden"]');
    for (final input in hiddenInputs) {
      final name = input.attributes['name'];
      final value = input.attributes['value'];

      if (name == 'entry_id' && value != null) {
        entryId = value;
      } else if (name == 'uniqid' && value != null) {
        uniqid = value;
      }
    }

    // パスワード入力フィールドの存在確認
    final passwordInput = document.querySelector(
      'input[name="code"], input[type="password"]',
    );
    requiresPassword = passwordInput != null;

    if (entryId != null && uniqid != null) {
      return AttendanceFormDto(
        entryId: entryId,
        uniqid: uniqid,
        requiresPassword: requiresPassword,
      );
    }

    return null;
  }

  /// 出席登録結果をJSONから解析
  static ManaboAttendanceResponseDto parseAttendanceResponse(
    Map<String, dynamic> json,
  ) {
    return ManaboAttendanceResponseDto.fromJson(json);
  }

  /// 出席確認結果をJSONから解析
  static ManaboAttendanceResponseDto parseAttendanceCheck(
    Map<String, dynamic> json,
  ) {
    return ManaboAttendanceResponseDto.fromJson(json);
  }

  /// URLからパラメータを抽出
  static Map<String, String> extractUrlParams(String url) {
    final uri = Uri.parse(url);
    final params = <String, String>{};

    uri.queryParameters.forEach((key, value) {
      params[key] = value;
    });

    return params;
  }

  /// フォームアクションURLを解析
  static String? extractFormAction(String htmlContent) {
    final document = html.parse(htmlContent);
    final form = document.querySelector('form');
    return form?.attributes['action'];
  }
}
