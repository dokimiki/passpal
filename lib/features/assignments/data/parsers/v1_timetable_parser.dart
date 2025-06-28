import 'package:html/parser.dart' as html;
import 'package:html/dom.dart';
import '../dtos/class_dto.dart';

/// Parser for MaNaBo timetable HTML (version 1)
class V1TimetableParser {
  /// Parse timetable HTML to extract class information
  List<ClassDto> parseTimetable(String htmlContent) {
    List<ClassDto> classes = [];

    try {
      final document = html.parse(htmlContent);

      // Find all timetable class links
      final classElements = document.querySelectorAll('.timetable-icon a');

      for (final element in classElements) {
        final classInfo = _parseClassElement(element);
        if (classInfo != null) {
          classes.add(classInfo);
        }
      }

      // If no classes found with HTML parsing, try regex as fallback
      if (classes.isEmpty) {
        classes = _parseWithRegex(htmlContent);
      }
    } catch (e) {
      // Fallback to regex parsing if HTML parsing fails
      classes = _parseWithRegex(htmlContent);
    }

    return classes;
  }

  ClassDto? _parseClassElement(Element element) {
    try {
      final href = element.attributes['href'];
      if (href == null) return null;

      // Extract class ID from href (/class/85146/)
      final classIdMatch = RegExp(r'/class/(\d+)/').firstMatch(href);
      if (classIdMatch == null) return null;

      final classId = classIdMatch.group(1)!;

      // Get class name from <b> tag
      final nameElement = element.querySelector('b');
      final name = nameElement?.text.trim() ?? '';
      if (name.isEmpty) return null;

      // Get instructor name (text after <br> tag)
      // First, get all text nodes after the <b> tag
      String instructor = '';
      final nodes = element.nodes;
      bool foundBrTag = false;

      for (final node in nodes) {
        if (node.nodeType == Node.ELEMENT_NODE) {
          final elem = node as Element;
          if (elem.localName == 'br') {
            foundBrTag = true;
          }
        } else if (node.nodeType == Node.TEXT_NODE && foundBrTag) {
          instructor += node.text ?? '';
        }
      }

      instructor = instructor.trim();

      return ClassDto(
        classId: classId,
        name: name,
        instructor: instructor,
        url: href,
      );
    } catch (e) {
      return null;
    }
  }

  List<ClassDto> _parseWithRegex(String htmlContent) {
    final classes = <ClassDto>[];

    // Regex to find class links with basic information
    final classPattern = RegExp(
      r'<a[^>]*href="(/class/(\d+)/)"[^>]*>.*?<b>([^<]+)</b>.*?<br>([^<]*)</a>',
      multiLine: true,
      dotAll: true,
    );

    final matches = classPattern.allMatches(htmlContent);

    for (final match in matches) {
      try {
        final url = match.group(1) ?? '';
        final classId = match.group(2) ?? '';
        final name = match.group(3)?.trim() ?? '';
        final instructor = match.group(4)?.trim() ?? '';

        if (classId.isNotEmpty && name.isNotEmpty) {
          classes.add(
            ClassDto(
              classId: classId,
              name: name,
              instructor: instructor,
              url: url,
            ),
          );
        }
      } catch (e) {
        // Skip invalid entries
        continue;
      }
    }

    return classes;
  }
}
