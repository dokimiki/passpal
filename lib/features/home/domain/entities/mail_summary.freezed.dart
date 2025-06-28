// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mail_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MailSummary {

 String get mailId; String get title; String get senderName; DateTime get receivedAt; bool get isRead; String? get senderThumbnailUrl;
/// Create a copy of MailSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MailSummaryCopyWith<MailSummary> get copyWith => _$MailSummaryCopyWithImpl<MailSummary>(this as MailSummary, _$identity);

  /// Serializes this MailSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MailSummary&&(identical(other.mailId, mailId) || other.mailId == mailId)&&(identical(other.title, title) || other.title == title)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.senderThumbnailUrl, senderThumbnailUrl) || other.senderThumbnailUrl == senderThumbnailUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mailId,title,senderName,receivedAt,isRead,senderThumbnailUrl);

@override
String toString() {
  return 'MailSummary(mailId: $mailId, title: $title, senderName: $senderName, receivedAt: $receivedAt, isRead: $isRead, senderThumbnailUrl: $senderThumbnailUrl)';
}


}

/// @nodoc
abstract mixin class $MailSummaryCopyWith<$Res>  {
  factory $MailSummaryCopyWith(MailSummary value, $Res Function(MailSummary) _then) = _$MailSummaryCopyWithImpl;
@useResult
$Res call({
 String mailId, String title, String senderName, DateTime receivedAt, bool isRead, String? senderThumbnailUrl
});




}
/// @nodoc
class _$MailSummaryCopyWithImpl<$Res>
    implements $MailSummaryCopyWith<$Res> {
  _$MailSummaryCopyWithImpl(this._self, this._then);

  final MailSummary _self;
  final $Res Function(MailSummary) _then;

/// Create a copy of MailSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mailId = null,Object? title = null,Object? senderName = null,Object? receivedAt = null,Object? isRead = null,Object? senderThumbnailUrl = freezed,}) {
  return _then(_self.copyWith(
mailId: null == mailId ? _self.mailId : mailId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,senderThumbnailUrl: freezed == senderThumbnailUrl ? _self.senderThumbnailUrl : senderThumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _MailSummary implements MailSummary {
  const _MailSummary({required this.mailId, required this.title, required this.senderName, required this.receivedAt, required this.isRead, this.senderThumbnailUrl});
  factory _MailSummary.fromJson(Map<String, dynamic> json) => _$MailSummaryFromJson(json);

@override final  String mailId;
@override final  String title;
@override final  String senderName;
@override final  DateTime receivedAt;
@override final  bool isRead;
@override final  String? senderThumbnailUrl;

/// Create a copy of MailSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MailSummaryCopyWith<_MailSummary> get copyWith => __$MailSummaryCopyWithImpl<_MailSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MailSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MailSummary&&(identical(other.mailId, mailId) || other.mailId == mailId)&&(identical(other.title, title) || other.title == title)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.senderThumbnailUrl, senderThumbnailUrl) || other.senderThumbnailUrl == senderThumbnailUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mailId,title,senderName,receivedAt,isRead,senderThumbnailUrl);

@override
String toString() {
  return 'MailSummary(mailId: $mailId, title: $title, senderName: $senderName, receivedAt: $receivedAt, isRead: $isRead, senderThumbnailUrl: $senderThumbnailUrl)';
}


}

/// @nodoc
abstract mixin class _$MailSummaryCopyWith<$Res> implements $MailSummaryCopyWith<$Res> {
  factory _$MailSummaryCopyWith(_MailSummary value, $Res Function(_MailSummary) _then) = __$MailSummaryCopyWithImpl;
@override @useResult
$Res call({
 String mailId, String title, String senderName, DateTime receivedAt, bool isRead, String? senderThumbnailUrl
});




}
/// @nodoc
class __$MailSummaryCopyWithImpl<$Res>
    implements _$MailSummaryCopyWith<$Res> {
  __$MailSummaryCopyWithImpl(this._self, this._then);

  final _MailSummary _self;
  final $Res Function(_MailSummary) _then;

/// Create a copy of MailSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mailId = null,Object? title = null,Object? senderName = null,Object? receivedAt = null,Object? isRead = null,Object? senderThumbnailUrl = freezed,}) {
  return _then(_MailSummary(
mailId: null == mailId ? _self.mailId : mailId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,senderThumbnailUrl: freezed == senderThumbnailUrl ? _self.senderThumbnailUrl : senderThumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
