// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ManaboAttendanceResponseDto {

/// 成功フラグ
 bool get success;/// HTMLコンテンツ（エラー時）
 String? get html;/// エラーメッセージ
 String? get error;/// メッセージ
 String? get message;/// データ
 ManaboAttendanceDataDto? get data;
/// Create a copy of ManaboAttendanceResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ManaboAttendanceResponseDtoCopyWith<ManaboAttendanceResponseDto> get copyWith => _$ManaboAttendanceResponseDtoCopyWithImpl<ManaboAttendanceResponseDto>(this as ManaboAttendanceResponseDto, _$identity);

  /// Serializes this ManaboAttendanceResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ManaboAttendanceResponseDto&&(identical(other.success, success) || other.success == success)&&(identical(other.html, html) || other.html == html)&&(identical(other.error, error) || other.error == error)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,html,error,message,data);

@override
String toString() {
  return 'ManaboAttendanceResponseDto(success: $success, html: $html, error: $error, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $ManaboAttendanceResponseDtoCopyWith<$Res>  {
  factory $ManaboAttendanceResponseDtoCopyWith(ManaboAttendanceResponseDto value, $Res Function(ManaboAttendanceResponseDto) _then) = _$ManaboAttendanceResponseDtoCopyWithImpl;
@useResult
$Res call({
 bool success, String? html, String? error, String? message, ManaboAttendanceDataDto? data
});


$ManaboAttendanceDataDtoCopyWith<$Res>? get data;

}
/// @nodoc
class _$ManaboAttendanceResponseDtoCopyWithImpl<$Res>
    implements $ManaboAttendanceResponseDtoCopyWith<$Res> {
  _$ManaboAttendanceResponseDtoCopyWithImpl(this._self, this._then);

  final ManaboAttendanceResponseDto _self;
  final $Res Function(ManaboAttendanceResponseDto) _then;

/// Create a copy of ManaboAttendanceResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? html = freezed,Object? error = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,html: freezed == html ? _self.html : html // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ManaboAttendanceDataDto?,
  ));
}
/// Create a copy of ManaboAttendanceResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ManaboAttendanceDataDtoCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $ManaboAttendanceDataDtoCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _ManaboAttendanceResponseDto implements ManaboAttendanceResponseDto {
  const _ManaboAttendanceResponseDto({required this.success, this.html, this.error, this.message, this.data});
  factory _ManaboAttendanceResponseDto.fromJson(Map<String, dynamic> json) => _$ManaboAttendanceResponseDtoFromJson(json);

/// 成功フラグ
@override final  bool success;
/// HTMLコンテンツ（エラー時）
@override final  String? html;
/// エラーメッセージ
@override final  String? error;
/// メッセージ
@override final  String? message;
/// データ
@override final  ManaboAttendanceDataDto? data;

/// Create a copy of ManaboAttendanceResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ManaboAttendanceResponseDtoCopyWith<_ManaboAttendanceResponseDto> get copyWith => __$ManaboAttendanceResponseDtoCopyWithImpl<_ManaboAttendanceResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ManaboAttendanceResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ManaboAttendanceResponseDto&&(identical(other.success, success) || other.success == success)&&(identical(other.html, html) || other.html == html)&&(identical(other.error, error) || other.error == error)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,html,error,message,data);

@override
String toString() {
  return 'ManaboAttendanceResponseDto(success: $success, html: $html, error: $error, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$ManaboAttendanceResponseDtoCopyWith<$Res> implements $ManaboAttendanceResponseDtoCopyWith<$Res> {
  factory _$ManaboAttendanceResponseDtoCopyWith(_ManaboAttendanceResponseDto value, $Res Function(_ManaboAttendanceResponseDto) _then) = __$ManaboAttendanceResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 bool success, String? html, String? error, String? message, ManaboAttendanceDataDto? data
});


@override $ManaboAttendanceDataDtoCopyWith<$Res>? get data;

}
/// @nodoc
class __$ManaboAttendanceResponseDtoCopyWithImpl<$Res>
    implements _$ManaboAttendanceResponseDtoCopyWith<$Res> {
  __$ManaboAttendanceResponseDtoCopyWithImpl(this._self, this._then);

  final _ManaboAttendanceResponseDto _self;
  final $Res Function(_ManaboAttendanceResponseDto) _then;

/// Create a copy of ManaboAttendanceResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? html = freezed,Object? error = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_ManaboAttendanceResponseDto(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,html: freezed == html ? _self.html : html // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ManaboAttendanceDataDto?,
  ));
}

/// Create a copy of ManaboAttendanceResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ManaboAttendanceDataDtoCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $ManaboAttendanceDataDtoCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$ManaboAttendanceDataDto {

/// 出席状態（0=未出席、1=出席済み）
 int get isAccepted;
/// Create a copy of ManaboAttendanceDataDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ManaboAttendanceDataDtoCopyWith<ManaboAttendanceDataDto> get copyWith => _$ManaboAttendanceDataDtoCopyWithImpl<ManaboAttendanceDataDto>(this as ManaboAttendanceDataDto, _$identity);

  /// Serializes this ManaboAttendanceDataDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ManaboAttendanceDataDto&&(identical(other.isAccepted, isAccepted) || other.isAccepted == isAccepted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isAccepted);

@override
String toString() {
  return 'ManaboAttendanceDataDto(isAccepted: $isAccepted)';
}


}

/// @nodoc
abstract mixin class $ManaboAttendanceDataDtoCopyWith<$Res>  {
  factory $ManaboAttendanceDataDtoCopyWith(ManaboAttendanceDataDto value, $Res Function(ManaboAttendanceDataDto) _then) = _$ManaboAttendanceDataDtoCopyWithImpl;
@useResult
$Res call({
 int isAccepted
});




}
/// @nodoc
class _$ManaboAttendanceDataDtoCopyWithImpl<$Res>
    implements $ManaboAttendanceDataDtoCopyWith<$Res> {
  _$ManaboAttendanceDataDtoCopyWithImpl(this._self, this._then);

  final ManaboAttendanceDataDto _self;
  final $Res Function(ManaboAttendanceDataDto) _then;

/// Create a copy of ManaboAttendanceDataDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isAccepted = null,}) {
  return _then(_self.copyWith(
isAccepted: null == isAccepted ? _self.isAccepted : isAccepted // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ManaboAttendanceDataDto implements ManaboAttendanceDataDto {
  const _ManaboAttendanceDataDto({required this.isAccepted});
  factory _ManaboAttendanceDataDto.fromJson(Map<String, dynamic> json) => _$ManaboAttendanceDataDtoFromJson(json);

/// 出席状態（0=未出席、1=出席済み）
@override final  int isAccepted;

/// Create a copy of ManaboAttendanceDataDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ManaboAttendanceDataDtoCopyWith<_ManaboAttendanceDataDto> get copyWith => __$ManaboAttendanceDataDtoCopyWithImpl<_ManaboAttendanceDataDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ManaboAttendanceDataDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ManaboAttendanceDataDto&&(identical(other.isAccepted, isAccepted) || other.isAccepted == isAccepted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isAccepted);

@override
String toString() {
  return 'ManaboAttendanceDataDto(isAccepted: $isAccepted)';
}


}

/// @nodoc
abstract mixin class _$ManaboAttendanceDataDtoCopyWith<$Res> implements $ManaboAttendanceDataDtoCopyWith<$Res> {
  factory _$ManaboAttendanceDataDtoCopyWith(_ManaboAttendanceDataDto value, $Res Function(_ManaboAttendanceDataDto) _then) = __$ManaboAttendanceDataDtoCopyWithImpl;
@override @useResult
$Res call({
 int isAccepted
});




}
/// @nodoc
class __$ManaboAttendanceDataDtoCopyWithImpl<$Res>
    implements _$ManaboAttendanceDataDtoCopyWith<$Res> {
  __$ManaboAttendanceDataDtoCopyWithImpl(this._self, this._then);

  final _ManaboAttendanceDataDto _self;
  final $Res Function(_ManaboAttendanceDataDto) _then;

/// Create a copy of ManaboAttendanceDataDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isAccepted = null,}) {
  return _then(_ManaboAttendanceDataDto(
isAccepted: null == isAccepted ? _self.isAccepted : isAccepted // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$AttendanceFormDto {

/// エントリーID
 String get entryId;/// ユニークID
 String get uniqid;/// パスワード要求フラグ
 bool get requiresPassword;
/// Create a copy of AttendanceFormDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceFormDtoCopyWith<AttendanceFormDto> get copyWith => _$AttendanceFormDtoCopyWithImpl<AttendanceFormDto>(this as AttendanceFormDto, _$identity);

  /// Serializes this AttendanceFormDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceFormDto&&(identical(other.entryId, entryId) || other.entryId == entryId)&&(identical(other.uniqid, uniqid) || other.uniqid == uniqid)&&(identical(other.requiresPassword, requiresPassword) || other.requiresPassword == requiresPassword));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,entryId,uniqid,requiresPassword);

@override
String toString() {
  return 'AttendanceFormDto(entryId: $entryId, uniqid: $uniqid, requiresPassword: $requiresPassword)';
}


}

/// @nodoc
abstract mixin class $AttendanceFormDtoCopyWith<$Res>  {
  factory $AttendanceFormDtoCopyWith(AttendanceFormDto value, $Res Function(AttendanceFormDto) _then) = _$AttendanceFormDtoCopyWithImpl;
@useResult
$Res call({
 String entryId, String uniqid, bool requiresPassword
});




}
/// @nodoc
class _$AttendanceFormDtoCopyWithImpl<$Res>
    implements $AttendanceFormDtoCopyWith<$Res> {
  _$AttendanceFormDtoCopyWithImpl(this._self, this._then);

  final AttendanceFormDto _self;
  final $Res Function(AttendanceFormDto) _then;

/// Create a copy of AttendanceFormDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entryId = null,Object? uniqid = null,Object? requiresPassword = null,}) {
  return _then(_self.copyWith(
entryId: null == entryId ? _self.entryId : entryId // ignore: cast_nullable_to_non_nullable
as String,uniqid: null == uniqid ? _self.uniqid : uniqid // ignore: cast_nullable_to_non_nullable
as String,requiresPassword: null == requiresPassword ? _self.requiresPassword : requiresPassword // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _AttendanceFormDto implements AttendanceFormDto {
  const _AttendanceFormDto({required this.entryId, required this.uniqid, this.requiresPassword = false});
  factory _AttendanceFormDto.fromJson(Map<String, dynamic> json) => _$AttendanceFormDtoFromJson(json);

/// エントリーID
@override final  String entryId;
/// ユニークID
@override final  String uniqid;
/// パスワード要求フラグ
@override@JsonKey() final  bool requiresPassword;

/// Create a copy of AttendanceFormDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceFormDtoCopyWith<_AttendanceFormDto> get copyWith => __$AttendanceFormDtoCopyWithImpl<_AttendanceFormDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttendanceFormDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendanceFormDto&&(identical(other.entryId, entryId) || other.entryId == entryId)&&(identical(other.uniqid, uniqid) || other.uniqid == uniqid)&&(identical(other.requiresPassword, requiresPassword) || other.requiresPassword == requiresPassword));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,entryId,uniqid,requiresPassword);

@override
String toString() {
  return 'AttendanceFormDto(entryId: $entryId, uniqid: $uniqid, requiresPassword: $requiresPassword)';
}


}

/// @nodoc
abstract mixin class _$AttendanceFormDtoCopyWith<$Res> implements $AttendanceFormDtoCopyWith<$Res> {
  factory _$AttendanceFormDtoCopyWith(_AttendanceFormDto value, $Res Function(_AttendanceFormDto) _then) = __$AttendanceFormDtoCopyWithImpl;
@override @useResult
$Res call({
 String entryId, String uniqid, bool requiresPassword
});




}
/// @nodoc
class __$AttendanceFormDtoCopyWithImpl<$Res>
    implements _$AttendanceFormDtoCopyWith<$Res> {
  __$AttendanceFormDtoCopyWithImpl(this._self, this._then);

  final _AttendanceFormDto _self;
  final $Res Function(_AttendanceFormDto) _then;

/// Create a copy of AttendanceFormDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entryId = null,Object? uniqid = null,Object? requiresPassword = null,}) {
  return _then(_AttendanceFormDto(
entryId: null == entryId ? _self.entryId : entryId // ignore: cast_nullable_to_non_nullable
as String,uniqid: null == uniqid ? _self.uniqid : uniqid // ignore: cast_nullable_to_non_nullable
as String,requiresPassword: null == requiresPassword ? _self.requiresPassword : requiresPassword // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
