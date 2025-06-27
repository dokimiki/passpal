// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AssignmentDetailArgs {

 String get courseId; String get assignmentId;
/// Create a copy of AssignmentDetailArgs
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssignmentDetailArgsCopyWith<AssignmentDetailArgs> get copyWith => _$AssignmentDetailArgsCopyWithImpl<AssignmentDetailArgs>(this as AssignmentDetailArgs, _$identity);

  /// Serializes this AssignmentDetailArgs to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssignmentDetailArgs&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.assignmentId, assignmentId) || other.assignmentId == assignmentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,courseId,assignmentId);

@override
String toString() {
  return 'AssignmentDetailArgs(courseId: $courseId, assignmentId: $assignmentId)';
}


}

/// @nodoc
abstract mixin class $AssignmentDetailArgsCopyWith<$Res>  {
  factory $AssignmentDetailArgsCopyWith(AssignmentDetailArgs value, $Res Function(AssignmentDetailArgs) _then) = _$AssignmentDetailArgsCopyWithImpl;
@useResult
$Res call({
 String courseId, String assignmentId
});




}
/// @nodoc
class _$AssignmentDetailArgsCopyWithImpl<$Res>
    implements $AssignmentDetailArgsCopyWith<$Res> {
  _$AssignmentDetailArgsCopyWithImpl(this._self, this._then);

  final AssignmentDetailArgs _self;
  final $Res Function(AssignmentDetailArgs) _then;

/// Create a copy of AssignmentDetailArgs
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? courseId = null,Object? assignmentId = null,}) {
  return _then(_self.copyWith(
courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,assignmentId: null == assignmentId ? _self.assignmentId : assignmentId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _AssignmentDetailArgs implements AssignmentDetailArgs {
  const _AssignmentDetailArgs({required this.courseId, required this.assignmentId});
  factory _AssignmentDetailArgs.fromJson(Map<String, dynamic> json) => _$AssignmentDetailArgsFromJson(json);

@override final  String courseId;
@override final  String assignmentId;

/// Create a copy of AssignmentDetailArgs
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssignmentDetailArgsCopyWith<_AssignmentDetailArgs> get copyWith => __$AssignmentDetailArgsCopyWithImpl<_AssignmentDetailArgs>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssignmentDetailArgsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssignmentDetailArgs&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.assignmentId, assignmentId) || other.assignmentId == assignmentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,courseId,assignmentId);

@override
String toString() {
  return 'AssignmentDetailArgs(courseId: $courseId, assignmentId: $assignmentId)';
}


}

/// @nodoc
abstract mixin class _$AssignmentDetailArgsCopyWith<$Res> implements $AssignmentDetailArgsCopyWith<$Res> {
  factory _$AssignmentDetailArgsCopyWith(_AssignmentDetailArgs value, $Res Function(_AssignmentDetailArgs) _then) = __$AssignmentDetailArgsCopyWithImpl;
@override @useResult
$Res call({
 String courseId, String assignmentId
});




}
/// @nodoc
class __$AssignmentDetailArgsCopyWithImpl<$Res>
    implements _$AssignmentDetailArgsCopyWith<$Res> {
  __$AssignmentDetailArgsCopyWithImpl(this._self, this._then);

  final _AssignmentDetailArgs _self;
  final $Res Function(_AssignmentDetailArgs) _then;

/// Create a copy of AssignmentDetailArgs
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? courseId = null,Object? assignmentId = null,}) {
  return _then(_AssignmentDetailArgs(
courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,assignmentId: null == assignmentId ? _self.assignmentId : assignmentId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CourseDetailArgs {

 String get courseId;
/// Create a copy of CourseDetailArgs
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseDetailArgsCopyWith<CourseDetailArgs> get copyWith => _$CourseDetailArgsCopyWithImpl<CourseDetailArgs>(this as CourseDetailArgs, _$identity);

  /// Serializes this CourseDetailArgs to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseDetailArgs&&(identical(other.courseId, courseId) || other.courseId == courseId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,courseId);

@override
String toString() {
  return 'CourseDetailArgs(courseId: $courseId)';
}


}

/// @nodoc
abstract mixin class $CourseDetailArgsCopyWith<$Res>  {
  factory $CourseDetailArgsCopyWith(CourseDetailArgs value, $Res Function(CourseDetailArgs) _then) = _$CourseDetailArgsCopyWithImpl;
@useResult
$Res call({
 String courseId
});




}
/// @nodoc
class _$CourseDetailArgsCopyWithImpl<$Res>
    implements $CourseDetailArgsCopyWith<$Res> {
  _$CourseDetailArgsCopyWithImpl(this._self, this._then);

  final CourseDetailArgs _self;
  final $Res Function(CourseDetailArgs) _then;

/// Create a copy of CourseDetailArgs
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? courseId = null,}) {
  return _then(_self.copyWith(
courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CourseDetailArgs implements CourseDetailArgs {
  const _CourseDetailArgs({required this.courseId});
  factory _CourseDetailArgs.fromJson(Map<String, dynamic> json) => _$CourseDetailArgsFromJson(json);

@override final  String courseId;

/// Create a copy of CourseDetailArgs
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourseDetailArgsCopyWith<_CourseDetailArgs> get copyWith => __$CourseDetailArgsCopyWithImpl<_CourseDetailArgs>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CourseDetailArgsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CourseDetailArgs&&(identical(other.courseId, courseId) || other.courseId == courseId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,courseId);

@override
String toString() {
  return 'CourseDetailArgs(courseId: $courseId)';
}


}

/// @nodoc
abstract mixin class _$CourseDetailArgsCopyWith<$Res> implements $CourseDetailArgsCopyWith<$Res> {
  factory _$CourseDetailArgsCopyWith(_CourseDetailArgs value, $Res Function(_CourseDetailArgs) _then) = __$CourseDetailArgsCopyWithImpl;
@override @useResult
$Res call({
 String courseId
});




}
/// @nodoc
class __$CourseDetailArgsCopyWithImpl<$Res>
    implements _$CourseDetailArgsCopyWith<$Res> {
  __$CourseDetailArgsCopyWithImpl(this._self, this._then);

  final _CourseDetailArgs _self;
  final $Res Function(_CourseDetailArgs) _then;

/// Create a copy of CourseDetailArgs
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? courseId = null,}) {
  return _then(_CourseDetailArgs(
courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CourseMaterialsArgs {

 String get courseId;
/// Create a copy of CourseMaterialsArgs
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseMaterialsArgsCopyWith<CourseMaterialsArgs> get copyWith => _$CourseMaterialsArgsCopyWithImpl<CourseMaterialsArgs>(this as CourseMaterialsArgs, _$identity);

  /// Serializes this CourseMaterialsArgs to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseMaterialsArgs&&(identical(other.courseId, courseId) || other.courseId == courseId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,courseId);

@override
String toString() {
  return 'CourseMaterialsArgs(courseId: $courseId)';
}


}

/// @nodoc
abstract mixin class $CourseMaterialsArgsCopyWith<$Res>  {
  factory $CourseMaterialsArgsCopyWith(CourseMaterialsArgs value, $Res Function(CourseMaterialsArgs) _then) = _$CourseMaterialsArgsCopyWithImpl;
@useResult
$Res call({
 String courseId
});




}
/// @nodoc
class _$CourseMaterialsArgsCopyWithImpl<$Res>
    implements $CourseMaterialsArgsCopyWith<$Res> {
  _$CourseMaterialsArgsCopyWithImpl(this._self, this._then);

  final CourseMaterialsArgs _self;
  final $Res Function(CourseMaterialsArgs) _then;

/// Create a copy of CourseMaterialsArgs
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? courseId = null,}) {
  return _then(_self.copyWith(
courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CourseMaterialsArgs implements CourseMaterialsArgs {
  const _CourseMaterialsArgs({required this.courseId});
  factory _CourseMaterialsArgs.fromJson(Map<String, dynamic> json) => _$CourseMaterialsArgsFromJson(json);

@override final  String courseId;

/// Create a copy of CourseMaterialsArgs
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourseMaterialsArgsCopyWith<_CourseMaterialsArgs> get copyWith => __$CourseMaterialsArgsCopyWithImpl<_CourseMaterialsArgs>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CourseMaterialsArgsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CourseMaterialsArgs&&(identical(other.courseId, courseId) || other.courseId == courseId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,courseId);

@override
String toString() {
  return 'CourseMaterialsArgs(courseId: $courseId)';
}


}

/// @nodoc
abstract mixin class _$CourseMaterialsArgsCopyWith<$Res> implements $CourseMaterialsArgsCopyWith<$Res> {
  factory _$CourseMaterialsArgsCopyWith(_CourseMaterialsArgs value, $Res Function(_CourseMaterialsArgs) _then) = __$CourseMaterialsArgsCopyWithImpl;
@override @useResult
$Res call({
 String courseId
});




}
/// @nodoc
class __$CourseMaterialsArgsCopyWithImpl<$Res>
    implements _$CourseMaterialsArgsCopyWith<$Res> {
  __$CourseMaterialsArgsCopyWithImpl(this._self, this._then);

  final _CourseMaterialsArgs _self;
  final $Res Function(_CourseMaterialsArgs) _then;

/// Create a copy of CourseMaterialsArgs
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? courseId = null,}) {
  return _then(_CourseMaterialsArgs(
courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ErrorPageArgs {

 String get title; String get message; bool get canRetry;
/// Create a copy of ErrorPageArgs
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorPageArgsCopyWith<ErrorPageArgs> get copyWith => _$ErrorPageArgsCopyWithImpl<ErrorPageArgs>(this as ErrorPageArgs, _$identity);

  /// Serializes this ErrorPageArgs to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorPageArgs&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message)&&(identical(other.canRetry, canRetry) || other.canRetry == canRetry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,message,canRetry);

@override
String toString() {
  return 'ErrorPageArgs(title: $title, message: $message, canRetry: $canRetry)';
}


}

/// @nodoc
abstract mixin class $ErrorPageArgsCopyWith<$Res>  {
  factory $ErrorPageArgsCopyWith(ErrorPageArgs value, $Res Function(ErrorPageArgs) _then) = _$ErrorPageArgsCopyWithImpl;
@useResult
$Res call({
 String title, String message, bool canRetry
});




}
/// @nodoc
class _$ErrorPageArgsCopyWithImpl<$Res>
    implements $ErrorPageArgsCopyWith<$Res> {
  _$ErrorPageArgsCopyWithImpl(this._self, this._then);

  final ErrorPageArgs _self;
  final $Res Function(ErrorPageArgs) _then;

/// Create a copy of ErrorPageArgs
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? message = null,Object? canRetry = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,canRetry: null == canRetry ? _self.canRetry : canRetry // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ErrorPageArgs implements ErrorPageArgs {
  const _ErrorPageArgs({required this.title, required this.message, this.canRetry = true});
  factory _ErrorPageArgs.fromJson(Map<String, dynamic> json) => _$ErrorPageArgsFromJson(json);

@override final  String title;
@override final  String message;
@override@JsonKey() final  bool canRetry;

/// Create a copy of ErrorPageArgs
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorPageArgsCopyWith<_ErrorPageArgs> get copyWith => __$ErrorPageArgsCopyWithImpl<_ErrorPageArgs>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ErrorPageArgsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ErrorPageArgs&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message)&&(identical(other.canRetry, canRetry) || other.canRetry == canRetry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,message,canRetry);

@override
String toString() {
  return 'ErrorPageArgs(title: $title, message: $message, canRetry: $canRetry)';
}


}

/// @nodoc
abstract mixin class _$ErrorPageArgsCopyWith<$Res> implements $ErrorPageArgsCopyWith<$Res> {
  factory _$ErrorPageArgsCopyWith(_ErrorPageArgs value, $Res Function(_ErrorPageArgs) _then) = __$ErrorPageArgsCopyWithImpl;
@override @useResult
$Res call({
 String title, String message, bool canRetry
});




}
/// @nodoc
class __$ErrorPageArgsCopyWithImpl<$Res>
    implements _$ErrorPageArgsCopyWith<$Res> {
  __$ErrorPageArgsCopyWithImpl(this._self, this._then);

  final _ErrorPageArgs _self;
  final $Res Function(_ErrorPageArgs) _then;

/// Create a copy of ErrorPageArgs
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? message = null,Object? canRetry = null,}) {
  return _then(_ErrorPageArgs(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,canRetry: null == canRetry ? _self.canRetry : canRetry // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$DeepLinkData {

 Uri get uri; Map<String, dynamic>? get pushPayload; DateTime? get timestamp;
/// Create a copy of DeepLinkData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeepLinkDataCopyWith<DeepLinkData> get copyWith => _$DeepLinkDataCopyWithImpl<DeepLinkData>(this as DeepLinkData, _$identity);

  /// Serializes this DeepLinkData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeepLinkData&&(identical(other.uri, uri) || other.uri == uri)&&const DeepCollectionEquality().equals(other.pushPayload, pushPayload)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uri,const DeepCollectionEquality().hash(pushPayload),timestamp);

@override
String toString() {
  return 'DeepLinkData(uri: $uri, pushPayload: $pushPayload, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $DeepLinkDataCopyWith<$Res>  {
  factory $DeepLinkDataCopyWith(DeepLinkData value, $Res Function(DeepLinkData) _then) = _$DeepLinkDataCopyWithImpl;
@useResult
$Res call({
 Uri uri, Map<String, dynamic>? pushPayload, DateTime? timestamp
});




}
/// @nodoc
class _$DeepLinkDataCopyWithImpl<$Res>
    implements $DeepLinkDataCopyWith<$Res> {
  _$DeepLinkDataCopyWithImpl(this._self, this._then);

  final DeepLinkData _self;
  final $Res Function(DeepLinkData) _then;

/// Create a copy of DeepLinkData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uri = null,Object? pushPayload = freezed,Object? timestamp = freezed,}) {
  return _then(_self.copyWith(
uri: null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as Uri,pushPayload: freezed == pushPayload ? _self.pushPayload : pushPayload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _DeepLinkData implements DeepLinkData {
  const _DeepLinkData({required this.uri, final  Map<String, dynamic>? pushPayload, this.timestamp}): _pushPayload = pushPayload;
  factory _DeepLinkData.fromJson(Map<String, dynamic> json) => _$DeepLinkDataFromJson(json);

@override final  Uri uri;
 final  Map<String, dynamic>? _pushPayload;
@override Map<String, dynamic>? get pushPayload {
  final value = _pushPayload;
  if (value == null) return null;
  if (_pushPayload is EqualUnmodifiableMapView) return _pushPayload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  DateTime? timestamp;

/// Create a copy of DeepLinkData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeepLinkDataCopyWith<_DeepLinkData> get copyWith => __$DeepLinkDataCopyWithImpl<_DeepLinkData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeepLinkDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeepLinkData&&(identical(other.uri, uri) || other.uri == uri)&&const DeepCollectionEquality().equals(other._pushPayload, _pushPayload)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uri,const DeepCollectionEquality().hash(_pushPayload),timestamp);

@override
String toString() {
  return 'DeepLinkData(uri: $uri, pushPayload: $pushPayload, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$DeepLinkDataCopyWith<$Res> implements $DeepLinkDataCopyWith<$Res> {
  factory _$DeepLinkDataCopyWith(_DeepLinkData value, $Res Function(_DeepLinkData) _then) = __$DeepLinkDataCopyWithImpl;
@override @useResult
$Res call({
 Uri uri, Map<String, dynamic>? pushPayload, DateTime? timestamp
});




}
/// @nodoc
class __$DeepLinkDataCopyWithImpl<$Res>
    implements _$DeepLinkDataCopyWith<$Res> {
  __$DeepLinkDataCopyWithImpl(this._self, this._then);

  final _DeepLinkData _self;
  final $Res Function(_DeepLinkData) _then;

/// Create a copy of DeepLinkData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uri = null,Object? pushPayload = freezed,Object? timestamp = freezed,}) {
  return _then(_DeepLinkData(
uri: null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as Uri,pushPayload: freezed == pushPayload ? _self._pushPayload : pushPayload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
