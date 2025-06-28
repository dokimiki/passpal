import 'package:html/parser.dart' as html;
import 'package:html/dom.dart';

/// Result information from quiz parsing
class QuizResultInfo {
  final int? score;
  final int? maxScore;
  final bool isSubmitted;
  final DateTime? submittedAt;

  const QuizResultInfo({
    this.score,
    this.maxScore,
    this.isSubmitted = false,
    this.submittedAt,
  });
}

/// Parser for MaNaBo quiz result HTML (version 1)
class V1QuizResultParser {
  /// Parse quiz result HTML to extract score and submission information
  QuizResultInfo parseResult(String htmlContent) {
    try {
      final document = html.parse(htmlContent);

      // Parse score from the display
      final scoreInfo = _parseScoreDisplay(document);

      // Check if quiz is submitted
      final isSubmitted = _checkSubmissionStatus(document);

      return QuizResultInfo(
        score: scoreInfo['score'],
        maxScore: scoreInfo['maxScore'],
        isSubmitted: isSubmitted,
      );
    } catch (e) {
      // Fallback to regex parsing
      return _parseWithRegex(htmlContent);
    }
  }

  Map<String, int?> _parseScoreDisplay(Document document) {
    int? score;
    int? maxScore;

    // Look for score display pattern like "40 / 100"
    final scoreElements = document.querySelectorAll('.text-center');

    for (final element in scoreElements) {
      final text = element.text.trim();
      final scorePattern = RegExp(r'(\d+)\s*/\s*(\d+)');
      final match = scorePattern.firstMatch(text);

      if (match != null) {
        score = int.tryParse(match.group(1)!);
        maxScore = int.tryParse(match.group(2)!);
        break;
      }
    }

    // Also check for span with Red class (score display)
    final redScoreElement = document.querySelector('.Red');
    if (redScoreElement != null && score == null) {
      final scoreText = redScoreElement.text.trim();
      score = int.tryParse(scoreText);
    }

    return {'score': score, 'maxScore': maxScore};
  }

  bool _checkSubmissionStatus(Document document) {
    // Check for various indicators of submission
    final indicators = [
      '.result-table',
      '.grade-table',
      'table-default-grade',
      '.submission-info',
    ];

    for (final indicator in indicators) {
      if (document.querySelector(indicator) != null) {
        return true;
      }
    }

    // Check for text content that indicates submission
    final bodyText = document.body?.text ?? '';
    final submissionKeywords = ['提出済み', '採点済み', '結果', '得点'];

    for (final keyword in submissionKeywords) {
      if (bodyText.contains(keyword)) {
        return true;
      }
    }

    return false;
  }

  QuizResultInfo _parseWithRegex(String htmlContent) {
    int? score;
    int? maxScore;
    bool isSubmitted = false;

    // Look for score pattern in HTML
    final scorePattern = RegExp(r'(\d+)\s*/\s*(\d+)');
    final scoreMatch = scorePattern.firstMatch(htmlContent);

    if (scoreMatch != null) {
      score = int.tryParse(scoreMatch.group(1)!);
      maxScore = int.tryParse(scoreMatch.group(2)!);
      isSubmitted = true;
    }

    // Check for submission indicators
    final submissionIndicators = ['提出済み', '採点済み', 'result', 'grade'];

    for (final indicator in submissionIndicators) {
      if (htmlContent.contains(indicator)) {
        isSubmitted = true;
        break;
      }
    }

    return QuizResultInfo(
      score: score,
      maxScore: maxScore,
      isSubmitted: isSubmitted,
    );
  }
}
