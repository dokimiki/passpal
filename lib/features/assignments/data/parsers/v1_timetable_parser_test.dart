import 'package:test/test.dart';
import 'package:passpal/features/assignments/data/parsers/v1_timetable_parser.dart';

void main() {
  group('V1TimetableParser', () {
    late V1TimetableParser parser;

    setUp(() {
      parser = V1TimetableParser();
    });

    test('should parse timetable HTML correctly', () {
      const htmlContent = '''
        <div class="timetable-icon">
          <a href="/class/85146/">
            <b>コンピュータネットワーク</b>
            <br>鈴木　常彦
          </a>
        </div>
        <div class="timetable-icon">
          <a href="/class/85131/">
            <b>アルゴリズムとデータ構造２</b>
            <br>土屋　孝文
          </a>
        </div>
      ''';

      final result = parser.parseTimetable(htmlContent);

      expect(result, hasLength(2));
      expect(result[0].classId, equals('85146'));
      expect(result[0].name, equals('コンピュータネットワーク'));
      expect(result[0].instructor, equals('鈴木　常彦'));
      expect(result[1].classId, equals('85131'));
      expect(result[1].name, equals('アルゴリズムとデータ構造２'));
      expect(result[1].instructor, equals('土屋　孝文'));
    });

    test('should handle empty HTML gracefully', () {
      const htmlContent = '<div>No classes found</div>';

      final result = parser.parseTimetable(htmlContent);

      expect(result, isEmpty);
    });

    test('should fall back to regex parsing on HTML parse failure', () {
      const htmlContent = '''
        <a href="/class/85146/"><b>テストクラス</b><br>テスト講師</a>
      ''';

      final result = parser.parseTimetable(htmlContent);

      expect(result, hasLength(1));
      expect(result[0].classId, equals('85146'));
      expect(result[0].name, equals('テストクラス'));
      expect(result[0].instructor, equals('テスト講師'));
    });
  });
}
