/// Data model for error page
class ErrorPageData {
  const ErrorPageData({
    this.title,
    this.message,
    this.exception,
    this.stackTrace,
  });

  final String? title;
  final String? message;
  final Object? exception;
  final StackTrace? stackTrace;

  /// Get the display title, with default fallback
  String get displayTitle => title ?? 'エラーが発生しました';

  /// Get the display message, with default fallback
  String get displayMessage {
    if (message != null) return message!;
    if (exception != null) return exception.toString();
    return '予期しないエラーが発生しました。しばらく経ってから再度お試しください。';
  }
}
