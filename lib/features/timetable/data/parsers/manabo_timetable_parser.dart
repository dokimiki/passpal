import 'package:html/parser.dart' as html;
import 'package:html/dom.dart';
import '../models/timetable_dto.dart';

/// MaNaBo時間割HTMLパーサー
class ManaboTimetableParser {
  /// HTMLから時間割スロットリストを解析
  static List<ManaboSlotDto> parseTimeTable(String htmlContent) {
    final document = html.parse(htmlContent);
    final slots = <ManaboSlotDto>[];

    // 時間割テーブルを探す
    final tables = document.querySelectorAll(
      'table.calendar-table, table.timetable',
    );
    if (tables.isEmpty) return slots;

    final table = tables.first;
    final rows = table.querySelectorAll('tr');

    for (int rowIndex = 1; rowIndex < rows.length; rowIndex++) {
      final row = rows[rowIndex];
      final cells = row.querySelectorAll('td');

      for (int cellIndex = 1; cellIndex < cells.length; cellIndex++) {
        final cell = cells[cellIndex];
        final courseDiv = cell.querySelector('.course-info, .class-item');

        if (courseDiv != null && courseDiv.text.trim().isNotEmpty) {
          final slot = _parseCourseCell(
            courseDiv,
            weekday: cellIndex, // 1=月、2=火...
            period: rowIndex, // 1限、2限...
          );
          if (slot != null) {
            slots.add(slot);
          }
        }
      }
    }

    return slots;
  }

  /// 授業セルの詳細解析
  static ManaboSlotDto? _parseCourseCell(
    Element courseDiv, {
    required int weekday,
    required int period,
  }) {
    final text = courseDiv.text.trim();
    if (text.isEmpty) return null;

    // MaNaBoクラスIDを取得（onclick属性やdata属性から）
    int? manaboClassId;
    final onclickAttr = courseDiv.attributes['onclick'];
    if (onclickAttr != null) {
      final classIdMatch = RegExp(r'class_id[=:](\d+)').firstMatch(onclickAttr);
      if (classIdMatch != null) {
        manaboClassId = int.tryParse(classIdMatch.group(1)!);
      }
    }

    // テキストから授業名、教員名、教室を抽出
    final lines = text
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    String? courseName;
    String? teacher;
    String? room;
    String? courseCode;

    if (lines.isNotEmpty) {
      courseName = lines[0];

      // 2行目以降から教員名や教室を探す
      for (int i = 1; i < lines.length; i++) {
        final line = lines[i];

        // 教員名パターン（先生、教授など）
        if (line.contains('先生') || line.contains('教授') || line.contains('講師')) {
          teacher = line;
        }
        // 教室パターン（数字-数字形式など）
        else if (RegExp(r'\d+-\d+|[A-Z]\d+').hasMatch(line)) {
          room = line;
        }
        // 授業コードパターン
        else if (RegExp(r'^[A-Z]{2}\d{4}$').hasMatch(line)) {
          courseCode = line;
        }
      }
    }

    return ManaboSlotDto(
      weekday: weekday,
      period: period,
      courseName: courseName,
      teacher: teacher,
      room: room,
      manaboClassId: manaboClassId,
      courseCode: courseCode,
    );
  }

  /// 利用可能な学期一覧を解析
  static List<Map<String, dynamic>> parseAvailableTerms(String htmlContent) {
    final document = html.parse(htmlContent);
    final terms = <Map<String, dynamic>>[];

    // タブリストから学期情報を取得
    final tabLinks = document.querySelectorAll(
      '.a-load-timetable, a[archive_id]',
    );

    for (final link in tabLinks) {
      final archiveId = link.attributes['archive_id'];
      final termText = link.text.trim();

      if (archiveId != null && termText.isNotEmpty) {
        final archiveIdInt = int.tryParse(archiveId);
        if (archiveIdInt != null) {
          terms.add({'archiveId': archiveIdInt, 'displayName': termText});
        }
      }
    }

    return terms;
  }
}
