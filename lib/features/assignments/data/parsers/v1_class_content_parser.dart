import 'package:html/parser.dart' as html;
import 'package:html/dom.dart';
import '../dtos/assignment_dto.dart';

/// Parser for MaNaBo class content HTML (version 1)
class V1ClassContentParser {
  /// Parse class content HTML to extract assignment information
  List<AssignmentDto> parseContent(String htmlContent, String classId) {
    final assignments = <AssignmentDto>[];

    try {
      final document = html.parse(htmlContent);

      // Find all content rows that represent assignments
      final contentRows = document.querySelectorAll('tr[content_id]');

      for (final row in contentRows) {
        final assignment = _parseContentRow(row, classId);
        if (assignment != null) {
          assignments.add(assignment);
        }
      }
    } catch (e) {
      // Fallback to regex parsing if HTML parsing fails
      return _parseWithRegex(htmlContent, classId);
    }

    return assignments;
  }

  AssignmentDto? _parseContentRow(Element row, String classId) {
    try {
      final contentId = row.attributes['content_id'];
      if (contentId == null) return null;

      // Get plugin information
      final pluginImg = row.querySelector('.plugin-icon');
      String pluginKey = 'other';

      if (pluginImg != null) {
        final src = pluginImg.attributes['src'] ?? '';
        if (src.contains('/quiz/')) {
          pluginKey = 'quiz';
        } else if (src.contains('/report/')) {
          pluginKey = 'report';
        }
      }

      // Get title from content link
      final titleElement = row.querySelector('.a-content-open');
      final title = titleElement?.text.trim() ?? '';
      if (title.isEmpty) return null;

      // Get content URL
      final contentLink = row.querySelector('a[href*="/content/"]');
      final contentUrl = contentLink?.attributes['href'];

      // Get result URL
      final resultLink = row.querySelector('a[href*="/result/"]');
      final resultUrl = resultLink?.attributes['href'];

      // Try to extract due date (this might vary by content type)
      DateTime? dueAt;
      final dueDateElement = row.querySelector('.due-date, .deadline');
      if (dueDateElement != null) {
        dueAt = _parseDateString(dueDateElement.text);
      }

      return AssignmentDto(
        contentId: contentId,
        classId: classId,
        title: title,
        pluginKey: pluginKey,
        contentUrl: contentUrl,
        resultUrl: resultUrl,
        dueAt: dueAt,
      );
    } catch (e) {
      return null;
    }
  }

  List<AssignmentDto> _parseWithRegex(String htmlContent, String classId) {
    final assignments = <AssignmentDto>[];

    // Regex to find quiz/assignment content
    final contentPattern = RegExp(
      r'content_id="(\d+)"[^>]*>.*?class="a-content-open"[^>]*>([^<]+)</a>',
      multiLine: true,
      dotAll: true,
    );

    final matches = contentPattern.allMatches(htmlContent);

    for (final match in matches) {
      try {
        final contentId = match.group(1) ?? '';
        final title = match.group(2)?.trim() ?? '';

        if (contentId.isNotEmpty && title.isNotEmpty) {
          // Determine plugin type from surrounding context
          final contextStart = (match.start - 500).clamp(0, htmlContent.length);
          final contextEnd = (match.end + 500).clamp(0, htmlContent.length);
          final context = htmlContent.substring(contextStart, contextEnd);

          String pluginKey = 'other';
          if (context.contains('/quiz/')) {
            pluginKey = 'quiz';
          } else if (context.contains('/report/')) {
            pluginKey = 'report';
          }

          assignments.add(
            AssignmentDto(
              contentId: contentId,
              classId: classId,
              title: title,
              pluginKey: pluginKey,
            ),
          );
        }
      } catch (e) {
        continue;
      }
    }

    return assignments;
  }

  DateTime? _parseDateString(String dateText) {
    try {
      // Parse various date formats that might appear in MaNaBo
      final cleanText = dateText.trim();

      // Try to find date patterns like "2025年6月30日" or "2025/06/30"
      final datePatterns = [
        RegExp(r'(\d{4})年(\d{1,2})月(\d{1,2})日'),
        RegExp(r'(\d{4})/(\d{1,2})/(\d{1,2})'),
        RegExp(r'(\d{4})-(\d{1,2})-(\d{1,2})'),
      ];

      for (final pattern in datePatterns) {
        final match = pattern.firstMatch(cleanText);
        if (match != null) {
          final year = int.parse(match.group(1)!);
          final month = int.parse(match.group(2)!);
          final day = int.parse(match.group(3)!);
          return DateTime(year, month, day);
        }
      }
    } catch (e) {
      // Return null if parsing fails
    }

    return null;
  }
}
