/// ユーザーの認証情報を表現するモデル
class Credentials {
  const Credentials({
    required this.username,
    required this.password,
    this.sessionCookie,
    this.expiresAt,
  });

  final String username;
  final String password;
  final String? sessionCookie;
  final DateTime? expiresAt;

  factory Credentials.fromJson(Map<String, dynamic> json) {
    return Credentials(
      username: json['username'] as String,
      password: json['password'] as String,
      sessionCookie: json['sessionCookie'] as String?,
      expiresAt: json['expiresAt'] != null 
        ? DateTime.parse(json['expiresAt'] as String)
        : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'sessionCookie': sessionCookie,
      'expiresAt': expiresAt?.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Credentials &&
        other.username == username &&
        other.password == password &&
        other.sessionCookie == sessionCookie &&
        other.expiresAt == expiresAt;
  }

  @override
  int get hashCode {
    return Object.hash(username, password, sessionCookie, expiresAt);
  }

  @override
  String toString() {
    return 'Credentials(username: $username, sessionCookie: ${sessionCookie != null ? '[REDACTED]' : 'null'}, expiresAt: $expiresAt)';
  }
}
