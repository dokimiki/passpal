// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timetable_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TimetableDto {

 String get lineId; String get diagramId; String get direction; String get transportMode; List<DepartureTimeDto> get departures; Map<String, dynamic> get metadata;
/// Create a copy of TimetableDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimetableDtoCopyWith<TimetableDto> get copyWith => _$TimetableDtoCopyWithImpl<TimetableDto>(this as TimetableDto, _$identity);

  /// Serializes this TimetableDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimetableDto&&(identical(other.lineId, lineId) || other.lineId == lineId)&&(identical(other.diagramId, diagramId) || other.diagramId == diagramId)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.transportMode, transportMode) || other.transportMode == transportMode)&&const DeepCollectionEquality().equals(other.departures, departures)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lineId,diagramId,direction,transportMode,const DeepCollectionEquality().hash(departures),const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'TimetableDto(lineId: $lineId, diagramId: $diagramId, direction: $direction, transportMode: $transportMode, departures: $departures, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $TimetableDtoCopyWith<$Res>  {
  factory $TimetableDtoCopyWith(TimetableDto value, $Res Function(TimetableDto) _then) = _$TimetableDtoCopyWithImpl;
@useResult
$Res call({
 String lineId, String diagramId, String direction, String transportMode, List<DepartureTimeDto> departures, Map<String, dynamic> metadata
});




}
/// @nodoc
class _$TimetableDtoCopyWithImpl<$Res>
    implements $TimetableDtoCopyWith<$Res> {
  _$TimetableDtoCopyWithImpl(this._self, this._then);

  final TimetableDto _self;
  final $Res Function(TimetableDto) _then;

/// Create a copy of TimetableDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lineId = null,Object? diagramId = null,Object? direction = null,Object? transportMode = null,Object? departures = null,Object? metadata = null,}) {
  return _then(_self.copyWith(
lineId: null == lineId ? _self.lineId : lineId // ignore: cast_nullable_to_non_nullable
as String,diagramId: null == diagramId ? _self.diagramId : diagramId // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,transportMode: null == transportMode ? _self.transportMode : transportMode // ignore: cast_nullable_to_non_nullable
as String,departures: null == departures ? _self.departures : departures // ignore: cast_nullable_to_non_nullable
as List<DepartureTimeDto>,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _TimetableDto implements TimetableDto {
  const _TimetableDto({required this.lineId, required this.diagramId, required this.direction, required this.transportMode, required final  List<DepartureTimeDto> departures, final  Map<String, dynamic> metadata = const {}}): _departures = departures,_metadata = metadata;
  factory _TimetableDto.fromJson(Map<String, dynamic> json) => _$TimetableDtoFromJson(json);

@override final  String lineId;
@override final  String diagramId;
@override final  String direction;
@override final  String transportMode;
 final  List<DepartureTimeDto> _departures;
@override List<DepartureTimeDto> get departures {
  if (_departures is EqualUnmodifiableListView) return _departures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_departures);
}

 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of TimetableDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimetableDtoCopyWith<_TimetableDto> get copyWith => __$TimetableDtoCopyWithImpl<_TimetableDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TimetableDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimetableDto&&(identical(other.lineId, lineId) || other.lineId == lineId)&&(identical(other.diagramId, diagramId) || other.diagramId == diagramId)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.transportMode, transportMode) || other.transportMode == transportMode)&&const DeepCollectionEquality().equals(other._departures, _departures)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lineId,diagramId,direction,transportMode,const DeepCollectionEquality().hash(_departures),const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'TimetableDto(lineId: $lineId, diagramId: $diagramId, direction: $direction, transportMode: $transportMode, departures: $departures, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$TimetableDtoCopyWith<$Res> implements $TimetableDtoCopyWith<$Res> {
  factory _$TimetableDtoCopyWith(_TimetableDto value, $Res Function(_TimetableDto) _then) = __$TimetableDtoCopyWithImpl;
@override @useResult
$Res call({
 String lineId, String diagramId, String direction, String transportMode, List<DepartureTimeDto> departures, Map<String, dynamic> metadata
});




}
/// @nodoc
class __$TimetableDtoCopyWithImpl<$Res>
    implements _$TimetableDtoCopyWith<$Res> {
  __$TimetableDtoCopyWithImpl(this._self, this._then);

  final _TimetableDto _self;
  final $Res Function(_TimetableDto) _then;

/// Create a copy of TimetableDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lineId = null,Object? diagramId = null,Object? direction = null,Object? transportMode = null,Object? departures = null,Object? metadata = null,}) {
  return _then(_TimetableDto(
lineId: null == lineId ? _self.lineId : lineId // ignore: cast_nullable_to_non_nullable
as String,diagramId: null == diagramId ? _self.diagramId : diagramId // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,transportMode: null == transportMode ? _self.transportMode : transportMode // ignore: cast_nullable_to_non_nullable
as String,departures: null == departures ? _self._departures : departures // ignore: cast_nullable_to_non_nullable
as List<DepartureTimeDto>,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}


/// @nodoc
mixin _$DepartureTimeDto {

 String get time; String get stationId; bool get isHoliday; bool get isWeekend; Map<String, dynamic> get metadata;
/// Create a copy of DepartureTimeDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DepartureTimeDtoCopyWith<DepartureTimeDto> get copyWith => _$DepartureTimeDtoCopyWithImpl<DepartureTimeDto>(this as DepartureTimeDto, _$identity);

  /// Serializes this DepartureTimeDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DepartureTimeDto&&(identical(other.time, time) || other.time == time)&&(identical(other.stationId, stationId) || other.stationId == stationId)&&(identical(other.isHoliday, isHoliday) || other.isHoliday == isHoliday)&&(identical(other.isWeekend, isWeekend) || other.isWeekend == isWeekend)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,time,stationId,isHoliday,isWeekend,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'DepartureTimeDto(time: $time, stationId: $stationId, isHoliday: $isHoliday, isWeekend: $isWeekend, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $DepartureTimeDtoCopyWith<$Res>  {
  factory $DepartureTimeDtoCopyWith(DepartureTimeDto value, $Res Function(DepartureTimeDto) _then) = _$DepartureTimeDtoCopyWithImpl;
@useResult
$Res call({
 String time, String stationId, bool isHoliday, bool isWeekend, Map<String, dynamic> metadata
});




}
/// @nodoc
class _$DepartureTimeDtoCopyWithImpl<$Res>
    implements $DepartureTimeDtoCopyWith<$Res> {
  _$DepartureTimeDtoCopyWithImpl(this._self, this._then);

  final DepartureTimeDto _self;
  final $Res Function(DepartureTimeDto) _then;

/// Create a copy of DepartureTimeDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? time = null,Object? stationId = null,Object? isHoliday = null,Object? isWeekend = null,Object? metadata = null,}) {
  return _then(_self.copyWith(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,stationId: null == stationId ? _self.stationId : stationId // ignore: cast_nullable_to_non_nullable
as String,isHoliday: null == isHoliday ? _self.isHoliday : isHoliday // ignore: cast_nullable_to_non_nullable
as bool,isWeekend: null == isWeekend ? _self.isWeekend : isWeekend // ignore: cast_nullable_to_non_nullable
as bool,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _DepartureTimeDto implements DepartureTimeDto {
  const _DepartureTimeDto({required this.time, required this.stationId, this.isHoliday = false, this.isWeekend = false, final  Map<String, dynamic> metadata = const {}}): _metadata = metadata;
  factory _DepartureTimeDto.fromJson(Map<String, dynamic> json) => _$DepartureTimeDtoFromJson(json);

@override final  String time;
@override final  String stationId;
@override@JsonKey() final  bool isHoliday;
@override@JsonKey() final  bool isWeekend;
 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of DepartureTimeDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DepartureTimeDtoCopyWith<_DepartureTimeDto> get copyWith => __$DepartureTimeDtoCopyWithImpl<_DepartureTimeDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DepartureTimeDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DepartureTimeDto&&(identical(other.time, time) || other.time == time)&&(identical(other.stationId, stationId) || other.stationId == stationId)&&(identical(other.isHoliday, isHoliday) || other.isHoliday == isHoliday)&&(identical(other.isWeekend, isWeekend) || other.isWeekend == isWeekend)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,time,stationId,isHoliday,isWeekend,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'DepartureTimeDto(time: $time, stationId: $stationId, isHoliday: $isHoliday, isWeekend: $isWeekend, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$DepartureTimeDtoCopyWith<$Res> implements $DepartureTimeDtoCopyWith<$Res> {
  factory _$DepartureTimeDtoCopyWith(_DepartureTimeDto value, $Res Function(_DepartureTimeDto) _then) = __$DepartureTimeDtoCopyWithImpl;
@override @useResult
$Res call({
 String time, String stationId, bool isHoliday, bool isWeekend, Map<String, dynamic> metadata
});




}
/// @nodoc
class __$DepartureTimeDtoCopyWithImpl<$Res>
    implements _$DepartureTimeDtoCopyWith<$Res> {
  __$DepartureTimeDtoCopyWithImpl(this._self, this._then);

  final _DepartureTimeDto _self;
  final $Res Function(_DepartureTimeDto) _then;

/// Create a copy of DepartureTimeDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? time = null,Object? stationId = null,Object? isHoliday = null,Object? isWeekend = null,Object? metadata = null,}) {
  return _then(_DepartureTimeDto(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,stationId: null == stationId ? _self.stationId : stationId // ignore: cast_nullable_to_non_nullable
as String,isHoliday: null == isHoliday ? _self.isHoliday : isHoliday // ignore: cast_nullable_to_non_nullable
as bool,isWeekend: null == isWeekend ? _self.isWeekend : isWeekend // ignore: cast_nullable_to_non_nullable
as bool,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
