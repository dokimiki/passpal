// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mail_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MailBody {

 String get mailId; String get title; String get senderName; DateTime get receivedAt; String get bodyHtml; String? get senderThumbnailUrl; String? get replyToMailId;
/// Create a copy of MailBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MailBodyCopyWith<MailBody> get copyWith => _$MailBodyCopyWithImpl<MailBody>(this as MailBody, _$identity);

  /// Serializes this MailBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MailBody&&(identical(other.mailId, mailId) || other.mailId == mailId)&&(identical(other.title, title) || other.title == title)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.bodyHtml, bodyHtml) || other.bodyHtml == bodyHtml)&&(identical(other.senderThumbnailUrl, senderThumbnailUrl) || other.senderThumbnailUrl == senderThumbnailUrl)&&(identical(other.replyToMailId, replyToMailId) || other.replyToMailId == replyToMailId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mailId,title,senderName,receivedAt,bodyHtml,senderThumbnailUrl,replyToMailId);

@override
String toString() {
  return 'MailBody(mailId: $mailId, title: $title, senderName: $senderName, receivedAt: $receivedAt, bodyHtml: $bodyHtml, senderThumbnailUrl: $senderThumbnailUrl, replyToMailId: $replyToMailId)';
}


}

/// @nodoc
abstract mixin class $MailBodyCopyWith<$Res>  {
  factory $MailBodyCopyWith(MailBody value, $Res Function(MailBody) _then) = _$MailBodyCopyWithImpl;
@useResult
$Res call({
 String mailId, String title, String senderName, DateTime receivedAt, String bodyHtml, String? senderThumbnailUrl, String? replyToMailId
});




}
/// @nodoc
class _$MailBodyCopyWithImpl<$Res>
    implements $MailBodyCopyWith<$Res> {
  _$MailBodyCopyWithImpl(this._self, this._then);

  final MailBody _self;
  final $Res Function(MailBody) _then;

/// Create a copy of MailBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mailId = null,Object? title = null,Object? senderName = null,Object? receivedAt = null,Object? bodyHtml = null,Object? senderThumbnailUrl = freezed,Object? replyToMailId = freezed,}) {
  return _then(_self.copyWith(
mailId: null == mailId ? _self.mailId : mailId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime,bodyHtml: null == bodyHtml ? _self.bodyHtml : bodyHtml // ignore: cast_nullable_to_non_nullable
as String,senderThumbnailUrl: freezed == senderThumbnailUrl ? _self.senderThumbnailUrl : senderThumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,replyToMailId: freezed == replyToMailId ? _self.replyToMailId : replyToMailId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _MailBody implements MailBody {
  const _MailBody({required this.mailId, required this.title, required this.senderName, required this.receivedAt, required this.bodyHtml, this.senderThumbnailUrl, this.replyToMailId});
  factory _MailBody.fromJson(Map<String, dynamic> json) => _$MailBodyFromJson(json);

@override final  String mailId;
@override final  String title;
@override final  String senderName;
@override final  DateTime receivedAt;
@override final  String bodyHtml;
@override final  String? senderThumbnailUrl;
@override final  String? replyToMailId;

/// Create a copy of MailBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MailBodyCopyWith<_MailBody> get copyWith => __$MailBodyCopyWithImpl<_MailBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MailBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MailBody&&(identical(other.mailId, mailId) || other.mailId == mailId)&&(identical(other.title, title) || other.title == title)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.bodyHtml, bodyHtml) || other.bodyHtml == bodyHtml)&&(identical(other.senderThumbnailUrl, senderThumbnailUrl) || other.senderThumbnailUrl == senderThumbnailUrl)&&(identical(other.replyToMailId, replyToMailId) || other.replyToMailId == replyToMailId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mailId,title,senderName,receivedAt,bodyHtml,senderThumbnailUrl,replyToMailId);

@override
String toString() {
  return 'MailBody(mailId: $mailId, title: $title, senderName: $senderName, receivedAt: $receivedAt, bodyHtml: $bodyHtml, senderThumbnailUrl: $senderThumbnailUrl, replyToMailId: $replyToMailId)';
}


}

/// @nodoc
abstract mixin class _$MailBodyCopyWith<$Res> implements $MailBodyCopyWith<$Res> {
  factory _$MailBodyCopyWith(_MailBody value, $Res Function(_MailBody) _then) = __$MailBodyCopyWithImpl;
@override @useResult
$Res call({
 String mailId, String title, String senderName, DateTime receivedAt, String bodyHtml, String? senderThumbnailUrl, String? replyToMailId
});




}
/// @nodoc
class __$MailBodyCopyWithImpl<$Res>
    implements _$MailBodyCopyWith<$Res> {
  __$MailBodyCopyWithImpl(this._self, this._then);

  final _MailBody _self;
  final $Res Function(_MailBody) _then;

/// Create a copy of MailBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mailId = null,Object? title = null,Object? senderName = null,Object? receivedAt = null,Object? bodyHtml = null,Object? senderThumbnailUrl = freezed,Object? replyToMailId = freezed,}) {
  return _then(_MailBody(
mailId: null == mailId ? _self.mailId : mailId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime,bodyHtml: null == bodyHtml ? _self.bodyHtml : bodyHtml // ignore: cast_nullable_to_non_nullable
as String,senderThumbnailUrl: freezed == senderThumbnailUrl ? _self.senderThumbnailUrl : senderThumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,replyToMailId: freezed == replyToMailId ? _self.replyToMailId : replyToMailId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
