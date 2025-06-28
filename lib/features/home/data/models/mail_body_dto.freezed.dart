// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mail_body_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MailBodyDto {

 String get mailId; String get title; String get senderName; DateTime get receivedAt; String get bodyHtml; String? get senderThumbnailUrl; String? get replyToMailId;
/// Create a copy of MailBodyDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MailBodyDtoCopyWith<MailBodyDto> get copyWith => _$MailBodyDtoCopyWithImpl<MailBodyDto>(this as MailBodyDto, _$identity);

  /// Serializes this MailBodyDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MailBodyDto&&(identical(other.mailId, mailId) || other.mailId == mailId)&&(identical(other.title, title) || other.title == title)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.bodyHtml, bodyHtml) || other.bodyHtml == bodyHtml)&&(identical(other.senderThumbnailUrl, senderThumbnailUrl) || other.senderThumbnailUrl == senderThumbnailUrl)&&(identical(other.replyToMailId, replyToMailId) || other.replyToMailId == replyToMailId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mailId,title,senderName,receivedAt,bodyHtml,senderThumbnailUrl,replyToMailId);

@override
String toString() {
  return 'MailBodyDto(mailId: $mailId, title: $title, senderName: $senderName, receivedAt: $receivedAt, bodyHtml: $bodyHtml, senderThumbnailUrl: $senderThumbnailUrl, replyToMailId: $replyToMailId)';
}


}

/// @nodoc
abstract mixin class $MailBodyDtoCopyWith<$Res>  {
  factory $MailBodyDtoCopyWith(MailBodyDto value, $Res Function(MailBodyDto) _then) = _$MailBodyDtoCopyWithImpl;
@useResult
$Res call({
 String mailId, String title, String senderName, DateTime receivedAt, String bodyHtml, String? senderThumbnailUrl, String? replyToMailId
});




}
/// @nodoc
class _$MailBodyDtoCopyWithImpl<$Res>
    implements $MailBodyDtoCopyWith<$Res> {
  _$MailBodyDtoCopyWithImpl(this._self, this._then);

  final MailBodyDto _self;
  final $Res Function(MailBodyDto) _then;

/// Create a copy of MailBodyDto
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

class _MailBodyDto implements MailBodyDto {
  const _MailBodyDto({required this.mailId, required this.title, required this.senderName, required this.receivedAt, required this.bodyHtml, this.senderThumbnailUrl, this.replyToMailId});
  factory _MailBodyDto.fromJson(Map<String, dynamic> json) => _$MailBodyDtoFromJson(json);

@override final  String mailId;
@override final  String title;
@override final  String senderName;
@override final  DateTime receivedAt;
@override final  String bodyHtml;
@override final  String? senderThumbnailUrl;
@override final  String? replyToMailId;

/// Create a copy of MailBodyDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MailBodyDtoCopyWith<_MailBodyDto> get copyWith => __$MailBodyDtoCopyWithImpl<_MailBodyDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MailBodyDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MailBodyDto&&(identical(other.mailId, mailId) || other.mailId == mailId)&&(identical(other.title, title) || other.title == title)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.bodyHtml, bodyHtml) || other.bodyHtml == bodyHtml)&&(identical(other.senderThumbnailUrl, senderThumbnailUrl) || other.senderThumbnailUrl == senderThumbnailUrl)&&(identical(other.replyToMailId, replyToMailId) || other.replyToMailId == replyToMailId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mailId,title,senderName,receivedAt,bodyHtml,senderThumbnailUrl,replyToMailId);

@override
String toString() {
  return 'MailBodyDto(mailId: $mailId, title: $title, senderName: $senderName, receivedAt: $receivedAt, bodyHtml: $bodyHtml, senderThumbnailUrl: $senderThumbnailUrl, replyToMailId: $replyToMailId)';
}


}

/// @nodoc
abstract mixin class _$MailBodyDtoCopyWith<$Res> implements $MailBodyDtoCopyWith<$Res> {
  factory _$MailBodyDtoCopyWith(_MailBodyDto value, $Res Function(_MailBodyDto) _then) = __$MailBodyDtoCopyWithImpl;
@override @useResult
$Res call({
 String mailId, String title, String senderName, DateTime receivedAt, String bodyHtml, String? senderThumbnailUrl, String? replyToMailId
});




}
/// @nodoc
class __$MailBodyDtoCopyWithImpl<$Res>
    implements _$MailBodyDtoCopyWith<$Res> {
  __$MailBodyDtoCopyWithImpl(this._self, this._then);

  final _MailBodyDto _self;
  final $Res Function(_MailBodyDto) _then;

/// Create a copy of MailBodyDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mailId = null,Object? title = null,Object? senderName = null,Object? receivedAt = null,Object? bodyHtml = null,Object? senderThumbnailUrl = freezed,Object? replyToMailId = freezed,}) {
  return _then(_MailBodyDto(
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
