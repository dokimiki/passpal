// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'line.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LineEntity {

 LineId get id; String get name; TransportMode get type; String get from; String get to; String? get via; Map<String, String>? get directionName; Map<String, Map<String, String>>? get destination; Map<String, DiagramEntity> get diagram; ElapsedTimeEntity? get elapsedTime;
/// Create a copy of LineEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LineEntityCopyWith<LineEntity> get copyWith => _$LineEntityCopyWithImpl<LineEntity>(this as LineEntity, _$identity);

  /// Serializes this LineEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LineEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.via, via) || other.via == via)&&const DeepCollectionEquality().equals(other.directionName, directionName)&&const DeepCollectionEquality().equals(other.destination, destination)&&const DeepCollectionEquality().equals(other.diagram, diagram)&&(identical(other.elapsedTime, elapsedTime) || other.elapsedTime == elapsedTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,from,to,via,const DeepCollectionEquality().hash(directionName),const DeepCollectionEquality().hash(destination),const DeepCollectionEquality().hash(diagram),elapsedTime);

@override
String toString() {
  return 'LineEntity(id: $id, name: $name, type: $type, from: $from, to: $to, via: $via, directionName: $directionName, destination: $destination, diagram: $diagram, elapsedTime: $elapsedTime)';
}


}

/// @nodoc
abstract mixin class $LineEntityCopyWith<$Res>  {
  factory $LineEntityCopyWith(LineEntity value, $Res Function(LineEntity) _then) = _$LineEntityCopyWithImpl;
@useResult
$Res call({
 LineId id, String name, TransportMode type, String from, String to, String? via, Map<String, String>? directionName, Map<String, Map<String, String>>? destination, Map<String, DiagramEntity> diagram, ElapsedTimeEntity? elapsedTime
});


$LineIdCopyWith<$Res> get id;$ElapsedTimeEntityCopyWith<$Res>? get elapsedTime;

}
/// @nodoc
class _$LineEntityCopyWithImpl<$Res>
    implements $LineEntityCopyWith<$Res> {
  _$LineEntityCopyWithImpl(this._self, this._then);

  final LineEntity _self;
  final $Res Function(LineEntity) _then;

/// Create a copy of LineEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? from = null,Object? to = null,Object? via = freezed,Object? directionName = freezed,Object? destination = freezed,Object? diagram = null,Object? elapsedTime = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as LineId,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransportMode,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,via: freezed == via ? _self.via : via // ignore: cast_nullable_to_non_nullable
as String?,directionName: freezed == directionName ? _self.directionName : directionName // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,destination: freezed == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, String>>?,diagram: null == diagram ? _self.diagram : diagram // ignore: cast_nullable_to_non_nullable
as Map<String, DiagramEntity>,elapsedTime: freezed == elapsedTime ? _self.elapsedTime : elapsedTime // ignore: cast_nullable_to_non_nullable
as ElapsedTimeEntity?,
  ));
}
/// Create a copy of LineEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LineIdCopyWith<$Res> get id {
  
  return $LineIdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}/// Create a copy of LineEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ElapsedTimeEntityCopyWith<$Res>? get elapsedTime {
    if (_self.elapsedTime == null) {
    return null;
  }

  return $ElapsedTimeEntityCopyWith<$Res>(_self.elapsedTime!, (value) {
    return _then(_self.copyWith(elapsedTime: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _LineEntity implements LineEntity {
  const _LineEntity({required this.id, required this.name, required this.type, required this.from, required this.to, this.via, final  Map<String, String>? directionName, final  Map<String, Map<String, String>>? destination, required final  Map<String, DiagramEntity> diagram, this.elapsedTime}): _directionName = directionName,_destination = destination,_diagram = diagram;
  factory _LineEntity.fromJson(Map<String, dynamic> json) => _$LineEntityFromJson(json);

@override final  LineId id;
@override final  String name;
@override final  TransportMode type;
@override final  String from;
@override final  String to;
@override final  String? via;
 final  Map<String, String>? _directionName;
@override Map<String, String>? get directionName {
  final value = _directionName;
  if (value == null) return null;
  if (_directionName is EqualUnmodifiableMapView) return _directionName;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, Map<String, String>>? _destination;
@override Map<String, Map<String, String>>? get destination {
  final value = _destination;
  if (value == null) return null;
  if (_destination is EqualUnmodifiableMapView) return _destination;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, DiagramEntity> _diagram;
@override Map<String, DiagramEntity> get diagram {
  if (_diagram is EqualUnmodifiableMapView) return _diagram;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_diagram);
}

@override final  ElapsedTimeEntity? elapsedTime;

/// Create a copy of LineEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LineEntityCopyWith<_LineEntity> get copyWith => __$LineEntityCopyWithImpl<_LineEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LineEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LineEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.via, via) || other.via == via)&&const DeepCollectionEquality().equals(other._directionName, _directionName)&&const DeepCollectionEquality().equals(other._destination, _destination)&&const DeepCollectionEquality().equals(other._diagram, _diagram)&&(identical(other.elapsedTime, elapsedTime) || other.elapsedTime == elapsedTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,from,to,via,const DeepCollectionEquality().hash(_directionName),const DeepCollectionEquality().hash(_destination),const DeepCollectionEquality().hash(_diagram),elapsedTime);

@override
String toString() {
  return 'LineEntity(id: $id, name: $name, type: $type, from: $from, to: $to, via: $via, directionName: $directionName, destination: $destination, diagram: $diagram, elapsedTime: $elapsedTime)';
}


}

/// @nodoc
abstract mixin class _$LineEntityCopyWith<$Res> implements $LineEntityCopyWith<$Res> {
  factory _$LineEntityCopyWith(_LineEntity value, $Res Function(_LineEntity) _then) = __$LineEntityCopyWithImpl;
@override @useResult
$Res call({
 LineId id, String name, TransportMode type, String from, String to, String? via, Map<String, String>? directionName, Map<String, Map<String, String>>? destination, Map<String, DiagramEntity> diagram, ElapsedTimeEntity? elapsedTime
});


@override $LineIdCopyWith<$Res> get id;@override $ElapsedTimeEntityCopyWith<$Res>? get elapsedTime;

}
/// @nodoc
class __$LineEntityCopyWithImpl<$Res>
    implements _$LineEntityCopyWith<$Res> {
  __$LineEntityCopyWithImpl(this._self, this._then);

  final _LineEntity _self;
  final $Res Function(_LineEntity) _then;

/// Create a copy of LineEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? from = null,Object? to = null,Object? via = freezed,Object? directionName = freezed,Object? destination = freezed,Object? diagram = null,Object? elapsedTime = freezed,}) {
  return _then(_LineEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as LineId,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransportMode,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,via: freezed == via ? _self.via : via // ignore: cast_nullable_to_non_nullable
as String?,directionName: freezed == directionName ? _self._directionName : directionName // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,destination: freezed == destination ? _self._destination : destination // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, String>>?,diagram: null == diagram ? _self._diagram : diagram // ignore: cast_nullable_to_non_nullable
as Map<String, DiagramEntity>,elapsedTime: freezed == elapsedTime ? _self.elapsedTime : elapsedTime // ignore: cast_nullable_to_non_nullable
as ElapsedTimeEntity?,
  ));
}

/// Create a copy of LineEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LineIdCopyWith<$Res> get id {
  
  return $LineIdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}/// Create a copy of LineEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ElapsedTimeEntityCopyWith<$Res>? get elapsedTime {
    if (_self.elapsedTime == null) {
    return null;
  }

  return $ElapsedTimeEntityCopyWith<$Res>(_self.elapsedTime!, (value) {
    return _then(_self.copyWith(elapsedTime: value));
  });
}
}


/// @nodoc
mixin _$ElapsedTimeEntity {

 int get forward; int get reverse; int? get via;
/// Create a copy of ElapsedTimeEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ElapsedTimeEntityCopyWith<ElapsedTimeEntity> get copyWith => _$ElapsedTimeEntityCopyWithImpl<ElapsedTimeEntity>(this as ElapsedTimeEntity, _$identity);

  /// Serializes this ElapsedTimeEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ElapsedTimeEntity&&(identical(other.forward, forward) || other.forward == forward)&&(identical(other.reverse, reverse) || other.reverse == reverse)&&(identical(other.via, via) || other.via == via));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,forward,reverse,via);

@override
String toString() {
  return 'ElapsedTimeEntity(forward: $forward, reverse: $reverse, via: $via)';
}


}

/// @nodoc
abstract mixin class $ElapsedTimeEntityCopyWith<$Res>  {
  factory $ElapsedTimeEntityCopyWith(ElapsedTimeEntity value, $Res Function(ElapsedTimeEntity) _then) = _$ElapsedTimeEntityCopyWithImpl;
@useResult
$Res call({
 int forward, int reverse, int? via
});




}
/// @nodoc
class _$ElapsedTimeEntityCopyWithImpl<$Res>
    implements $ElapsedTimeEntityCopyWith<$Res> {
  _$ElapsedTimeEntityCopyWithImpl(this._self, this._then);

  final ElapsedTimeEntity _self;
  final $Res Function(ElapsedTimeEntity) _then;

/// Create a copy of ElapsedTimeEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? forward = null,Object? reverse = null,Object? via = freezed,}) {
  return _then(_self.copyWith(
forward: null == forward ? _self.forward : forward // ignore: cast_nullable_to_non_nullable
as int,reverse: null == reverse ? _self.reverse : reverse // ignore: cast_nullable_to_non_nullable
as int,via: freezed == via ? _self.via : via // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ElapsedTimeEntity implements ElapsedTimeEntity {
  const _ElapsedTimeEntity({required this.forward, required this.reverse, this.via});
  factory _ElapsedTimeEntity.fromJson(Map<String, dynamic> json) => _$ElapsedTimeEntityFromJson(json);

@override final  int forward;
@override final  int reverse;
@override final  int? via;

/// Create a copy of ElapsedTimeEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ElapsedTimeEntityCopyWith<_ElapsedTimeEntity> get copyWith => __$ElapsedTimeEntityCopyWithImpl<_ElapsedTimeEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ElapsedTimeEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ElapsedTimeEntity&&(identical(other.forward, forward) || other.forward == forward)&&(identical(other.reverse, reverse) || other.reverse == reverse)&&(identical(other.via, via) || other.via == via));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,forward,reverse,via);

@override
String toString() {
  return 'ElapsedTimeEntity(forward: $forward, reverse: $reverse, via: $via)';
}


}

/// @nodoc
abstract mixin class _$ElapsedTimeEntityCopyWith<$Res> implements $ElapsedTimeEntityCopyWith<$Res> {
  factory _$ElapsedTimeEntityCopyWith(_ElapsedTimeEntity value, $Res Function(_ElapsedTimeEntity) _then) = __$ElapsedTimeEntityCopyWithImpl;
@override @useResult
$Res call({
 int forward, int reverse, int? via
});




}
/// @nodoc
class __$ElapsedTimeEntityCopyWithImpl<$Res>
    implements _$ElapsedTimeEntityCopyWith<$Res> {
  __$ElapsedTimeEntityCopyWithImpl(this._self, this._then);

  final _ElapsedTimeEntity _self;
  final $Res Function(_ElapsedTimeEntity) _then;

/// Create a copy of ElapsedTimeEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? forward = null,Object? reverse = null,Object? via = freezed,}) {
  return _then(_ElapsedTimeEntity(
forward: null == forward ? _self.forward : forward // ignore: cast_nullable_to_non_nullable
as int,reverse: null == reverse ? _self.reverse : reverse // ignore: cast_nullable_to_non_nullable
as int,via: freezed == via ? _self.via : via // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$DiagramEntity {

 String get id; Map<RouteDirection, Map<int, List<DepartureTime>>> get schedule;
/// Create a copy of DiagramEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiagramEntityCopyWith<DiagramEntity> get copyWith => _$DiagramEntityCopyWithImpl<DiagramEntity>(this as DiagramEntity, _$identity);

  /// Serializes this DiagramEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiagramEntity&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.schedule, schedule));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(schedule));

@override
String toString() {
  return 'DiagramEntity(id: $id, schedule: $schedule)';
}


}

/// @nodoc
abstract mixin class $DiagramEntityCopyWith<$Res>  {
  factory $DiagramEntityCopyWith(DiagramEntity value, $Res Function(DiagramEntity) _then) = _$DiagramEntityCopyWithImpl;
@useResult
$Res call({
 String id, Map<RouteDirection, Map<int, List<DepartureTime>>> schedule
});




}
/// @nodoc
class _$DiagramEntityCopyWithImpl<$Res>
    implements $DiagramEntityCopyWith<$Res> {
  _$DiagramEntityCopyWithImpl(this._self, this._then);

  final DiagramEntity _self;
  final $Res Function(DiagramEntity) _then;

/// Create a copy of DiagramEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? schedule = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,schedule: null == schedule ? _self.schedule : schedule // ignore: cast_nullable_to_non_nullable
as Map<RouteDirection, Map<int, List<DepartureTime>>>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _DiagramEntity implements DiagramEntity {
  const _DiagramEntity({required this.id, required final  Map<RouteDirection, Map<int, List<DepartureTime>>> schedule}): _schedule = schedule;
  factory _DiagramEntity.fromJson(Map<String, dynamic> json) => _$DiagramEntityFromJson(json);

@override final  String id;
 final  Map<RouteDirection, Map<int, List<DepartureTime>>> _schedule;
@override Map<RouteDirection, Map<int, List<DepartureTime>>> get schedule {
  if (_schedule is EqualUnmodifiableMapView) return _schedule;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_schedule);
}


/// Create a copy of DiagramEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiagramEntityCopyWith<_DiagramEntity> get copyWith => __$DiagramEntityCopyWithImpl<_DiagramEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiagramEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiagramEntity&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._schedule, _schedule));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_schedule));

@override
String toString() {
  return 'DiagramEntity(id: $id, schedule: $schedule)';
}


}

/// @nodoc
abstract mixin class _$DiagramEntityCopyWith<$Res> implements $DiagramEntityCopyWith<$Res> {
  factory _$DiagramEntityCopyWith(_DiagramEntity value, $Res Function(_DiagramEntity) _then) = __$DiagramEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, Map<RouteDirection, Map<int, List<DepartureTime>>> schedule
});




}
/// @nodoc
class __$DiagramEntityCopyWithImpl<$Res>
    implements _$DiagramEntityCopyWith<$Res> {
  __$DiagramEntityCopyWithImpl(this._self, this._then);

  final _DiagramEntity _self;
  final $Res Function(_DiagramEntity) _then;

/// Create a copy of DiagramEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? schedule = null,}) {
  return _then(_DiagramEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,schedule: null == schedule ? _self._schedule : schedule // ignore: cast_nullable_to_non_nullable
as Map<RouteDirection, Map<int, List<DepartureTime>>>,
  ));
}


}


/// @nodoc
mixin _$DepartureTime {

 int get minute; bool? get isVia; String? get destination;
/// Create a copy of DepartureTime
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DepartureTimeCopyWith<DepartureTime> get copyWith => _$DepartureTimeCopyWithImpl<DepartureTime>(this as DepartureTime, _$identity);

  /// Serializes this DepartureTime to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DepartureTime&&(identical(other.minute, minute) || other.minute == minute)&&(identical(other.isVia, isVia) || other.isVia == isVia)&&(identical(other.destination, destination) || other.destination == destination));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minute,isVia,destination);

@override
String toString() {
  return 'DepartureTime(minute: $minute, isVia: $isVia, destination: $destination)';
}


}

/// @nodoc
abstract mixin class $DepartureTimeCopyWith<$Res>  {
  factory $DepartureTimeCopyWith(DepartureTime value, $Res Function(DepartureTime) _then) = _$DepartureTimeCopyWithImpl;
@useResult
$Res call({
 int minute, bool? isVia, String? destination
});




}
/// @nodoc
class _$DepartureTimeCopyWithImpl<$Res>
    implements $DepartureTimeCopyWith<$Res> {
  _$DepartureTimeCopyWithImpl(this._self, this._then);

  final DepartureTime _self;
  final $Res Function(DepartureTime) _then;

/// Create a copy of DepartureTime
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? minute = null,Object? isVia = freezed,Object? destination = freezed,}) {
  return _then(_self.copyWith(
minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,isVia: freezed == isVia ? _self.isVia : isVia // ignore: cast_nullable_to_non_nullable
as bool?,destination: freezed == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _DepartureTime implements DepartureTime {
  const _DepartureTime({required this.minute, this.isVia, this.destination});
  factory _DepartureTime.fromJson(Map<String, dynamic> json) => _$DepartureTimeFromJson(json);

@override final  int minute;
@override final  bool? isVia;
@override final  String? destination;

/// Create a copy of DepartureTime
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DepartureTimeCopyWith<_DepartureTime> get copyWith => __$DepartureTimeCopyWithImpl<_DepartureTime>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DepartureTimeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DepartureTime&&(identical(other.minute, minute) || other.minute == minute)&&(identical(other.isVia, isVia) || other.isVia == isVia)&&(identical(other.destination, destination) || other.destination == destination));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minute,isVia,destination);

@override
String toString() {
  return 'DepartureTime(minute: $minute, isVia: $isVia, destination: $destination)';
}


}

/// @nodoc
abstract mixin class _$DepartureTimeCopyWith<$Res> implements $DepartureTimeCopyWith<$Res> {
  factory _$DepartureTimeCopyWith(_DepartureTime value, $Res Function(_DepartureTime) _then) = __$DepartureTimeCopyWithImpl;
@override @useResult
$Res call({
 int minute, bool? isVia, String? destination
});




}
/// @nodoc
class __$DepartureTimeCopyWithImpl<$Res>
    implements _$DepartureTimeCopyWith<$Res> {
  __$DepartureTimeCopyWithImpl(this._self, this._then);

  final _DepartureTime _self;
  final $Res Function(_DepartureTime) _then;

/// Create a copy of DepartureTime
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? minute = null,Object? isVia = freezed,Object? destination = freezed,}) {
  return _then(_DepartureTime(
minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,isVia: freezed == isVia ? _self.isVia : isVia // ignore: cast_nullable_to_non_nullable
as bool?,destination: freezed == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
