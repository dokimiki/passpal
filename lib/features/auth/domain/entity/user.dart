import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'user.g.dart';

/// キャンパス種別を表す列挙型
enum Campus { toyota, nagoya, unknown }

/// 認証済みユーザーを表すイミュータブルなエンティティ
@immutable
@JsonSerializable()
class User extends Equatable {
  const User({
    required this.uid,
    required this.studentId,
    required this.displayName,
    required this.email,
    required this.campus,
    required this.created,
    this.photoUrl,
  });

  /// ユーザーの一意識別子
  final String uid;

  /// 学籍番号
  final String studentId;

  /// 表示名
  final String displayName;

  /// メールアドレス
  final String email;

  /// キャンパス
  final Campus campus;

  /// アカウント作成日時
  final DateTime created;

  /// プロフィール画像URL（任意）
  final String? photoUrl;

  /// JSONからUserインスタンスを生成
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// UserをJSONに変換
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [
    uid,
    studentId,
    displayName,
    email,
    campus,
    created,
    photoUrl,
  ];

  @override
  String toString() =>
      'User(uid: $uid, studentId: $studentId, displayName: $displayName)';
}
