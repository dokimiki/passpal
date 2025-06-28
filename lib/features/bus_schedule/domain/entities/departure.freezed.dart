// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'departure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DepartureEntity {

 TimeOfDay get departureTime; TimeOfDay get arrivalTime; LineId get lineId; RouteDirection get direction; DiagramId get diagramId; String? get destination; bool? get isVia; int? get elapsedMinutes;
/// Create a copy of DepartureEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DepartureEntityCopyWith<DepartureEntity> get copyWith => _$DepartureEntityCopyWithImpl<DepartureEntity>(this as DepartureEntity, _$identity);

  /// Serializes this DepartureEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DepartureEntity&&(identical(other.departureTime, departureTime) || other.departureTime == departureTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.lineId, lineId) || other.lineId == lineId)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.diagramId, diagramId) || other.diagramId == diagramId)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.isVia, isVia) || other.isVia == isVia)&&(identical(other.elapsedMinutes, elapsedMinutes) || other.elapsedMinutes == elapsedMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,departureTime,arrivalTime,lineId,direction,diagramId,destination,isVia,elapsedMinutes);

@override
String toString() {
  return 'DepartureEntity(departureTime: $departureTime, arrivalTime: $arrivalTime, lineId: $lineId, direction: $direction, diagramId: $diagramId, destination: $destination, isVia: $isVia, elapsedMinutes: $elapsedMinutes)';
}


}

/// @nodoc
abstract mixin class $DepartureEntityCopyWith<$Res>  {
  factory $DepartureEntityCopyWith(DepartureEntity value, $Res Function(DepartureEntity) _then) = _$DepartureEntityCopyWithImpl;
@useResult
$Res call({
 TimeOfDay departureTime, TimeOfDay arrivalTime, LineId lineId, RouteDirection direction, DiagramId diagramId, String? destination, bool? isVia, int? elapsedMinutes
});


$TimeOfDayCopyWith<$Res> get departureTime;$TimeOfDayCopyWith<$Res> get arrivalTime;$LineIdCopyWith<$Res> get lineId;$DiagramIdCopyWith<$Res> get diagramId;

}
/// @nodoc
class _$DepartureEntityCopyWithImpl<$Res>
    implements $DepartureEntityCopyWith<$Res> {
  _$DepartureEntityCopyWithImpl(this._self, this._then);

  final DepartureEntity _self;
  final $Res Function(DepartureEntity) _then;

/// Create a copy of DepartureEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? departureTime = null,Object? arrivalTime = null,Object? lineId = null,Object? direction = null,Object? diagramId = null,Object? destination = freezed,Object? isVia = freezed,Object? elapsedMinutes = freezed,}) {
  return _then(_self.copyWith(
departureTime: null == departureTime ? _self.departureTime : departureTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay,arrivalTime: null == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay,lineId: null == lineId ? _self.lineId : lineId // ignore: cast_nullable_to_non_nullable
as LineId,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as RouteDirection,diagramId: null == diagramId ? _self.diagramId : diagramId // ignore: cast_nullable_to_non_nullable
as DiagramId,destination: freezed == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as String?,isVia: freezed == isVia ? _self.isVia : isVia // ignore: cast_nullable_to_non_nullable
as bool?,elapsedMinutes: freezed == elapsedMinutes ? _self.elapsedMinutes : elapsedMinutes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of DepartureEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeOfDayCopyWith<$Res> get departureTime {
  
  return $TimeOfDayCopyWith<$Res>(_self.departureTime, (value) {
    return _then(_self.copyWith(departureTime: value));
  });
}/// Create a copy of DepartureEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeOfDayCopyWith<$Res> get arrivalTime {
  
  return $TimeOfDayCopyWith<$Res>(_self.arrivalTime, (value) {
    return _then(_self.copyWith(arrivalTime: value));
  });
}/// Create a copy of DepartureEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LineIdCopyWith<$Res> get lineId {
  
  return $LineIdCopyWith<$Res>(_self.lineId, (value) {
    return _then(_self.copyWith(lineId: value));
  });
}/// Create a copy of DepartureEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiagramIdCopyWith<$Res> get diagramId {
  
  return $DiagramIdCopyWith<$Res>(_self.diagramId, (value) {
    return _then(_self.copyWith(diagramId: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _DepartureEntity implements DepartureEntity {
  const _DepartureEntity({required this.departureTime, required this.arrivalTime, required this.lineId, required this.direction, required this.diagramId, this.destination, this.isVia, this.elapsedMinutes});
  factory _DepartureEntity.fromJson(Map<String, dynamic> json) => _$DepartureEntityFromJson(json);

@override final  TimeOfDay departureTime;
@override final  TimeOfDay arrivalTime;
@override final  LineId lineId;
@override final  RouteDirection direction;
@override final  DiagramId diagramId;
@override final  String? destination;
@override final  bool? isVia;
@override final  int? elapsedMinutes;

/// Create a copy of DepartureEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DepartureEntityCopyWith<_DepartureEntity> get copyWith => __$DepartureEntityCopyWithImpl<_DepartureEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DepartureEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DepartureEntity&&(identical(other.departureTime, departureTime) || other.departureTime == departureTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.lineId, lineId) || other.lineId == lineId)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.diagramId, diagramId) || other.diagramId == diagramId)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.isVia, isVia) || other.isVia == isVia)&&(identical(other.elapsedMinutes, elapsedMinutes) || other.elapsedMinutes == elapsedMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,departureTime,arrivalTime,lineId,direction,diagramId,destination,isVia,elapsedMinutes);

@override
String toString() {
  return 'DepartureEntity(departureTime: $departureTime, arrivalTime: $arrivalTime, lineId: $lineId, direction: $direction, diagramId: $diagramId, destination: $destination, isVia: $isVia, elapsedMinutes: $elapsedMinutes)';
}


}

/// @nodoc
abstract mixin class _$DepartureEntityCopyWith<$Res> implements $DepartureEntityCopyWith<$Res> {
  factory _$DepartureEntityCopyWith(_DepartureEntity value, $Res Function(_DepartureEntity) _then) = __$DepartureEntityCopyWithImpl;
@override @useResult
$Res call({
 TimeOfDay departureTime, TimeOfDay arrivalTime, LineId lineId, RouteDirection direction, DiagramId diagramId, String? destination, bool? isVia, int? elapsedMinutes
});


@override $TimeOfDayCopyWith<$Res> get departureTime;@override $TimeOfDayCopyWith<$Res> get arrivalTime;@override $LineIdCopyWith<$Res> get lineId;@override $DiagramIdCopyWith<$Res> get diagramId;

}
/// @nodoc
class __$DepartureEntityCopyWithImpl<$Res>
    implements _$DepartureEntityCopyWith<$Res> {
  __$DepartureEntityCopyWithImpl(this._self, this._then);

  final _DepartureEntity _self;
  final $Res Function(_DepartureEntity) _then;

/// Create a copy of DepartureEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? departureTime = null,Object? arrivalTime = null,Object? lineId = null,Object? direction = null,Object? diagramId = null,Object? destination = freezed,Object? isVia = freezed,Object? elapsedMinutes = freezed,}) {
  return _then(_DepartureEntity(
departureTime: null == departureTime ? _self.departureTime : departureTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay,arrivalTime: null == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay,lineId: null == lineId ? _self.lineId : lineId // ignore: cast_nullable_to_non_nullable
as LineId,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as RouteDirection,diagramId: null == diagramId ? _self.diagramId : diagramId // ignore: cast_nullable_to_non_nullable
as DiagramId,destination: freezed == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as String?,isVia: freezed == isVia ? _self.isVia : isVia // ignore: cast_nullable_to_non_nullable
as bool?,elapsedMinutes: freezed == elapsedMinutes ? _self.elapsedMinutes : elapsedMinutes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of DepartureEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeOfDayCopyWith<$Res> get departureTime {
  
  return $TimeOfDayCopyWith<$Res>(_self.departureTime, (value) {
    return _then(_self.copyWith(departureTime: value));
  });
}/// Create a copy of DepartureEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeOfDayCopyWith<$Res> get arrivalTime {
  
  return $TimeOfDayCopyWith<$Res>(_self.arrivalTime, (value) {
    return _then(_self.copyWith(arrivalTime: value));
  });
}/// Create a copy of DepartureEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LineIdCopyWith<$Res> get lineId {
  
  return $LineIdCopyWith<$Res>(_self.lineId, (value) {
    return _then(_self.copyWith(lineId: value));
  });
}/// Create a copy of DepartureEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiagramIdCopyWith<$Res> get diagramId {
  
  return $DiagramIdCopyWith<$Res>(_self.diagramId, (value) {
    return _then(_self.copyWith(diagramId: value));
  });
}
}


/// @nodoc
mixin _$DepartureDTO {

 String get lineDisplayName; TimeOfDay get departureTime; TimeOfDay get arrivalTime; String get destinationName; RouteDirection get direction; bool get isNearestDeparture; String? get platformInfo; bool? get isVia; int? get minutesUntilDeparture;
/// Create a copy of DepartureDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DepartureDTOCopyWith<DepartureDTO> get copyWith => _$DepartureDTOCopyWithImpl<DepartureDTO>(this as DepartureDTO, _$identity);

  /// Serializes this DepartureDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DepartureDTO&&(identical(other.lineDisplayName, lineDisplayName) || other.lineDisplayName == lineDisplayName)&&(identical(other.departureTime, departureTime) || other.departureTime == departureTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.destinationName, destinationName) || other.destinationName == destinationName)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.isNearestDeparture, isNearestDeparture) || other.isNearestDeparture == isNearestDeparture)&&(identical(other.platformInfo, platformInfo) || other.platformInfo == platformInfo)&&(identical(other.isVia, isVia) || other.isVia == isVia)&&(identical(other.minutesUntilDeparture, minutesUntilDeparture) || other.minutesUntilDeparture == minutesUntilDeparture));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lineDisplayName,departureTime,arrivalTime,destinationName,direction,isNearestDeparture,platformInfo,isVia,minutesUntilDeparture);

@override
String toString() {
  return 'DepartureDTO(lineDisplayName: $lineDisplayName, departureTime: $departureTime, arrivalTime: $arrivalTime, destinationName: $destinationName, direction: $direction, isNearestDeparture: $isNearestDeparture, platformInfo: $platformInfo, isVia: $isVia, minutesUntilDeparture: $minutesUntilDeparture)';
}


}

/// @nodoc
abstract mixin class $DepartureDTOCopyWith<$Res>  {
  factory $DepartureDTOCopyWith(DepartureDTO value, $Res Function(DepartureDTO) _then) = _$DepartureDTOCopyWithImpl;
@useResult
$Res call({
 String lineDisplayName, TimeOfDay departureTime, TimeOfDay arrivalTime, String destinationName, RouteDirection direction, bool isNearestDeparture, String? platformInfo, bool? isVia, int? minutesUntilDeparture
});


$TimeOfDayCopyWith<$Res> get departureTime;$TimeOfDayCopyWith<$Res> get arrivalTime;

}
/// @nodoc
class _$DepartureDTOCopyWithImpl<$Res>
    implements $DepartureDTOCopyWith<$Res> {
  _$DepartureDTOCopyWithImpl(this._self, this._then);

  final DepartureDTO _self;
  final $Res Function(DepartureDTO) _then;

/// Create a copy of DepartureDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lineDisplayName = null,Object? departureTime = null,Object? arrivalTime = null,Object? destinationName = null,Object? direction = null,Object? isNearestDeparture = null,Object? platformInfo = freezed,Object? isVia = freezed,Object? minutesUntilDeparture = freezed,}) {
  return _then(_self.copyWith(
lineDisplayName: null == lineDisplayName ? _self.lineDisplayName : lineDisplayName // ignore: cast_nullable_to_non_nullable
as String,departureTime: null == departureTime ? _self.departureTime : departureTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay,arrivalTime: null == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay,destinationName: null == destinationName ? _self.destinationName : destinationName // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as RouteDirection,isNearestDeparture: null == isNearestDeparture ? _self.isNearestDeparture : isNearestDeparture // ignore: cast_nullable_to_non_nullable
as bool,platformInfo: freezed == platformInfo ? _self.platformInfo : platformInfo // ignore: cast_nullable_to_non_nullable
as String?,isVia: freezed == isVia ? _self.isVia : isVia // ignore: cast_nullable_to_non_nullable
as bool?,minutesUntilDeparture: freezed == minutesUntilDeparture ? _self.minutesUntilDeparture : minutesUntilDeparture // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of DepartureDTO
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeOfDayCopyWith<$Res> get departureTime {
  
  return $TimeOfDayCopyWith<$Res>(_self.departureTime, (value) {
    return _then(_self.copyWith(departureTime: value));
  });
}/// Create a copy of DepartureDTO
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeOfDayCopyWith<$Res> get arrivalTime {
  
  return $TimeOfDayCopyWith<$Res>(_self.arrivalTime, (value) {
    return _then(_self.copyWith(arrivalTime: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _DepartureDTO implements DepartureDTO {
  const _DepartureDTO({required this.lineDisplayName, required this.departureTime, required this.arrivalTime, required this.destinationName, required this.direction, required this.isNearestDeparture, this.platformInfo, this.isVia, this.minutesUntilDeparture});
  factory _DepartureDTO.fromJson(Map<String, dynamic> json) => _$DepartureDTOFromJson(json);

@override final  String lineDisplayName;
@override final  TimeOfDay departureTime;
@override final  TimeOfDay arrivalTime;
@override final  String destinationName;
@override final  RouteDirection direction;
@override final  bool isNearestDeparture;
@override final  String? platformInfo;
@override final  bool? isVia;
@override final  int? minutesUntilDeparture;

/// Create a copy of DepartureDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DepartureDTOCopyWith<_DepartureDTO> get copyWith => __$DepartureDTOCopyWithImpl<_DepartureDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DepartureDTOToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DepartureDTO&&(identical(other.lineDisplayName, lineDisplayName) || other.lineDisplayName == lineDisplayName)&&(identical(other.departureTime, departureTime) || other.departureTime == departureTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.destinationName, destinationName) || other.destinationName == destinationName)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.isNearestDeparture, isNearestDeparture) || other.isNearestDeparture == isNearestDeparture)&&(identical(other.platformInfo, platformInfo) || other.platformInfo == platformInfo)&&(identical(other.isVia, isVia) || other.isVia == isVia)&&(identical(other.minutesUntilDeparture, minutesUntilDeparture) || other.minutesUntilDeparture == minutesUntilDeparture));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lineDisplayName,departureTime,arrivalTime,destinationName,direction,isNearestDeparture,platformInfo,isVia,minutesUntilDeparture);

@override
String toString() {
  return 'DepartureDTO(lineDisplayName: $lineDisplayName, departureTime: $departureTime, arrivalTime: $arrivalTime, destinationName: $destinationName, direction: $direction, isNearestDeparture: $isNearestDeparture, platformInfo: $platformInfo, isVia: $isVia, minutesUntilDeparture: $minutesUntilDeparture)';
}


}

/// @nodoc
abstract mixin class _$DepartureDTOCopyWith<$Res> implements $DepartureDTOCopyWith<$Res> {
  factory _$DepartureDTOCopyWith(_DepartureDTO value, $Res Function(_DepartureDTO) _then) = __$DepartureDTOCopyWithImpl;
@override @useResult
$Res call({
 String lineDisplayName, TimeOfDay departureTime, TimeOfDay arrivalTime, String destinationName, RouteDirection direction, bool isNearestDeparture, String? platformInfo, bool? isVia, int? minutesUntilDeparture
});


@override $TimeOfDayCopyWith<$Res> get departureTime;@override $TimeOfDayCopyWith<$Res> get arrivalTime;

}
/// @nodoc
class __$DepartureDTOCopyWithImpl<$Res>
    implements _$DepartureDTOCopyWith<$Res> {
  __$DepartureDTOCopyWithImpl(this._self, this._then);

  final _DepartureDTO _self;
  final $Res Function(_DepartureDTO) _then;

/// Create a copy of DepartureDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lineDisplayName = null,Object? departureTime = null,Object? arrivalTime = null,Object? destinationName = null,Object? direction = null,Object? isNearestDeparture = null,Object? platformInfo = freezed,Object? isVia = freezed,Object? minutesUntilDeparture = freezed,}) {
  return _then(_DepartureDTO(
lineDisplayName: null == lineDisplayName ? _self.lineDisplayName : lineDisplayName // ignore: cast_nullable_to_non_nullable
as String,departureTime: null == departureTime ? _self.departureTime : departureTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay,arrivalTime: null == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay,destinationName: null == destinationName ? _self.destinationName : destinationName // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as RouteDirection,isNearestDeparture: null == isNearestDeparture ? _self.isNearestDeparture : isNearestDeparture // ignore: cast_nullable_to_non_nullable
as bool,platformInfo: freezed == platformInfo ? _self.platformInfo : platformInfo // ignore: cast_nullable_to_non_nullable
as String?,isVia: freezed == isVia ? _self.isVia : isVia // ignore: cast_nullable_to_non_nullable
as bool?,minutesUntilDeparture: freezed == minutesUntilDeparture ? _self.minutesUntilDeparture : minutesUntilDeparture // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of DepartureDTO
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeOfDayCopyWith<$Res> get departureTime {
  
  return $TimeOfDayCopyWith<$Res>(_self.departureTime, (value) {
    return _then(_self.copyWith(departureTime: value));
  });
}/// Create a copy of DepartureDTO
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeOfDayCopyWith<$Res> get arrivalTime {
  
  return $TimeOfDayCopyWith<$Res>(_self.arrivalTime, (value) {
    return _then(_self.copyWith(arrivalTime: value));
  });
}
}

// dart format on
