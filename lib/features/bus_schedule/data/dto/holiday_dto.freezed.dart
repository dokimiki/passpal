// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'holiday_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HolidayDto {

 String get date; String get title; String get description;
/// Create a copy of HolidayDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HolidayDtoCopyWith<HolidayDto> get copyWith => _$HolidayDtoCopyWithImpl<HolidayDto>(this as HolidayDto, _$identity);

  /// Serializes this HolidayDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HolidayDto&&(identical(other.date, date) || other.date == date)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,title,description);

@override
String toString() {
  return 'HolidayDto(date: $date, title: $title, description: $description)';
}


}

/// @nodoc
abstract mixin class $HolidayDtoCopyWith<$Res>  {
  factory $HolidayDtoCopyWith(HolidayDto value, $Res Function(HolidayDto) _then) = _$HolidayDtoCopyWithImpl;
@useResult
$Res call({
 String date, String title, String description
});




}
/// @nodoc
class _$HolidayDtoCopyWithImpl<$Res>
    implements $HolidayDtoCopyWith<$Res> {
  _$HolidayDtoCopyWithImpl(this._self, this._then);

  final HolidayDto _self;
  final $Res Function(HolidayDto) _then;

/// Create a copy of HolidayDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? title = null,Object? description = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _HolidayDto implements HolidayDto {
  const _HolidayDto({required this.date, required this.title, required this.description});
  factory _HolidayDto.fromJson(Map<String, dynamic> json) => _$HolidayDtoFromJson(json);

@override final  String date;
@override final  String title;
@override final  String description;

/// Create a copy of HolidayDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HolidayDtoCopyWith<_HolidayDto> get copyWith => __$HolidayDtoCopyWithImpl<_HolidayDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HolidayDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HolidayDto&&(identical(other.date, date) || other.date == date)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,title,description);

@override
String toString() {
  return 'HolidayDto(date: $date, title: $title, description: $description)';
}


}

/// @nodoc
abstract mixin class _$HolidayDtoCopyWith<$Res> implements $HolidayDtoCopyWith<$Res> {
  factory _$HolidayDtoCopyWith(_HolidayDto value, $Res Function(_HolidayDto) _then) = __$HolidayDtoCopyWithImpl;
@override @useResult
$Res call({
 String date, String title, String description
});




}
/// @nodoc
class __$HolidayDtoCopyWithImpl<$Res>
    implements _$HolidayDtoCopyWith<$Res> {
  __$HolidayDtoCopyWithImpl(this._self, this._then);

  final _HolidayDto _self;
  final $Res Function(_HolidayDto) _then;

/// Create a copy of HolidayDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? title = null,Object? description = null,}) {
  return _then(_HolidayDto(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$HolidayResponseDto {

 List<HolidayDto> get holidays;
/// Create a copy of HolidayResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HolidayResponseDtoCopyWith<HolidayResponseDto> get copyWith => _$HolidayResponseDtoCopyWithImpl<HolidayResponseDto>(this as HolidayResponseDto, _$identity);

  /// Serializes this HolidayResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HolidayResponseDto&&const DeepCollectionEquality().equals(other.holidays, holidays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(holidays));

@override
String toString() {
  return 'HolidayResponseDto(holidays: $holidays)';
}


}

/// @nodoc
abstract mixin class $HolidayResponseDtoCopyWith<$Res>  {
  factory $HolidayResponseDtoCopyWith(HolidayResponseDto value, $Res Function(HolidayResponseDto) _then) = _$HolidayResponseDtoCopyWithImpl;
@useResult
$Res call({
 List<HolidayDto> holidays
});




}
/// @nodoc
class _$HolidayResponseDtoCopyWithImpl<$Res>
    implements $HolidayResponseDtoCopyWith<$Res> {
  _$HolidayResponseDtoCopyWithImpl(this._self, this._then);

  final HolidayResponseDto _self;
  final $Res Function(HolidayResponseDto) _then;

/// Create a copy of HolidayResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? holidays = null,}) {
  return _then(_self.copyWith(
holidays: null == holidays ? _self.holidays : holidays // ignore: cast_nullable_to_non_nullable
as List<HolidayDto>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _HolidayResponseDto implements HolidayResponseDto {
  const _HolidayResponseDto({required final  List<HolidayDto> holidays}): _holidays = holidays;
  factory _HolidayResponseDto.fromJson(Map<String, dynamic> json) => _$HolidayResponseDtoFromJson(json);

 final  List<HolidayDto> _holidays;
@override List<HolidayDto> get holidays {
  if (_holidays is EqualUnmodifiableListView) return _holidays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_holidays);
}


/// Create a copy of HolidayResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HolidayResponseDtoCopyWith<_HolidayResponseDto> get copyWith => __$HolidayResponseDtoCopyWithImpl<_HolidayResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HolidayResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HolidayResponseDto&&const DeepCollectionEquality().equals(other._holidays, _holidays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_holidays));

@override
String toString() {
  return 'HolidayResponseDto(holidays: $holidays)';
}


}

/// @nodoc
abstract mixin class _$HolidayResponseDtoCopyWith<$Res> implements $HolidayResponseDtoCopyWith<$Res> {
  factory _$HolidayResponseDtoCopyWith(_HolidayResponseDto value, $Res Function(_HolidayResponseDto) _then) = __$HolidayResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 List<HolidayDto> holidays
});




}
/// @nodoc
class __$HolidayResponseDtoCopyWithImpl<$Res>
    implements _$HolidayResponseDtoCopyWith<$Res> {
  __$HolidayResponseDtoCopyWithImpl(this._self, this._then);

  final _HolidayResponseDto _self;
  final $Res Function(_HolidayResponseDto) _then;

/// Create a copy of HolidayResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? holidays = null,}) {
  return _then(_HolidayResponseDto(
holidays: null == holidays ? _self._holidays : holidays // ignore: cast_nullable_to_non_nullable
as List<HolidayDto>,
  ));
}


}

// dart format on
