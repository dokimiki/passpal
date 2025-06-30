import 'package:test/test.dart';
import 'dart:io';
import '../../../../../lib/features/assignments/data/parsers/v1_timetable_parser.dart';
import '../../../../../lib/features/assignments/data/dtos/class_dto.dart';

void main() {
  group('V1TimetableParser', () {
    late V1TimetableParser parser;

    setUp(() {
      parser = V1TimetableParser();
    });

    test('should parse test fixture HTML correctly', () async {
      // Read the test fixture
      final file = File('test/fixtures/data/manabo_timetable.html');
      final htmlContent = await file.readAsString();

      print('Test fixture HTML length: ${htmlContent.length}');

      // Parse the HTML
      final classes = parser.parseTimetable(htmlContent);

      // The test fixture should contain several classes
      expect(classes.length, greaterThan(0));

      // Print results for debugging
      print('Test fixture parsing results:');
      for (final cls in classes) {
        print('- ${cls.name} (ID: ${cls.classId})');
      }
    });

    test('should parse simple HTML correctly', () {
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
      // Test regex parsing directly with minimal valid structure
      const htmlContent =
          '''<a href="/class/85146/"><b>テストクラス</b><br>テスト講師</a>''';

      final parser = V1TimetableParser();

      // Force the usage of regex parsing by testing with content that doesn't have
      // the expected .timetable-icon class structure
      final result = parser.parseTimetable(htmlContent);

      // Since the HTML doesn't have .timetable-icon class, HTML parsing will return empty
      // and should fall back to regex parsing
      expect(result, hasLength(1));
      expect(result[0].classId, equals('85146'));
      expect(result[0].name, equals('テストクラス'));
      expect(result[0].instructor, equals('テスト講師'));
    });
  });
}
