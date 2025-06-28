// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bus_diagram_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BusDiagramDto {

 String get diagramId; String get name; String get campusName; List<RouteDto> get routes; Map<String, dynamic> get metadata;
/// Create a copy of BusDiagramDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusDiagramDtoCopyWith<BusDiagramDto> get copyWith => _$BusDiagramDtoCopyWithImpl<BusDiagramDto>(this as BusDiagramDto, _$identity);

  /// Serializes this BusDiagramDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusDiagramDto&&(identical(other.diagramId, diagramId) || other.diagramId == diagramId)&&(identical(other.name, name) || other.name == name)&&(identical(other.campusName, campusName) || other.campusName == campusName)&&const DeepCollectionEquality().equals(other.routes, routes)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,diagramId,name,campusName,const DeepCollectionEquality().hash(routes),const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'BusDiagramDto(diagramId: $diagramId, name: $name, campusName: $campusName, routes: $routes, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $BusDiagramDtoCopyWith<$Res>  {
  factory $BusDiagramDtoCopyWith(BusDiagramDto value, $Res Function(BusDiagramDto) _then) = _$BusDiagramDtoCopyWithImpl;
@useResult
$Res call({
 String diagramId, String name, String campusName, List<RouteDto> routes, Map<String, dynamic> metadata
});




}
/// @nodoc
class _$BusDiagramDtoCopyWithImpl<$Res>
    implements $BusDiagramDtoCopyWith<$Res> {
  _$BusDiagramDtoCopyWithImpl(this._self, this._then);

  final BusDiagramDto _self;
  final $Res Function(BusDiagramDto) _then;

/// Create a copy of BusDiagramDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? diagramId = null,Object? name = null,Object? campusName = null,Object? routes = null,Object? metadata = null,}) {
  return _then(_self.copyWith(
diagramId: null == diagramId ? _self.diagramId : diagramId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,campusName: null == campusName ? _self.campusName : campusName // ignore: cast_nullable_to_non_nullable
as String,routes: null == routes ? _self.routes : routes // ignore: cast_nullable_to_non_nullable
as List<RouteDto>,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _BusDiagramDto implements BusDiagramDto {
  const _BusDiagramDto({required this.diagramId, required this.name, required this.campusName, required final  List<RouteDto> routes, final  Map<String, dynamic> metadata = const {}}): _routes = routes,_metadata = metadata;
  factory _BusDiagramDto.fromJson(Map<String, dynamic> json) => _$BusDiagramDtoFromJson(json);

@override final  String diagramId;
@override final  String name;
@override final  String campusName;
 final  List<RouteDto> _routes;
@override List<RouteDto> get routes {
  if (_routes is EqualUnmodifiableListView) return _routes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_routes);
}

 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of BusDiagramDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusDiagramDtoCopyWith<_BusDiagramDto> get copyWith => __$BusDiagramDtoCopyWithImpl<_BusDiagramDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusDiagramDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusDiagramDto&&(identical(other.diagramId, diagramId) || other.diagramId == diagramId)&&(identical(other.name, name) || other.name == name)&&(identical(other.campusName, campusName) || other.campusName == campusName)&&const DeepCollectionEquality().equals(other._routes, _routes)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,diagramId,name,campusName,const DeepCollectionEquality().hash(_routes),const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'BusDiagramDto(diagramId: $diagramId, name: $name, campusName: $campusName, routes: $routes, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$BusDiagramDtoCopyWith<$Res> implements $BusDiagramDtoCopyWith<$Res> {
  factory _$BusDiagramDtoCopyWith(_BusDiagramDto value, $Res Function(_BusDiagramDto) _then) = __$BusDiagramDtoCopyWithImpl;
@override @useResult
$Res call({
 String diagramId, String name, String campusName, List<RouteDto> routes, Map<String, dynamic> metadata
});




}
/// @nodoc
class __$BusDiagramDtoCopyWithImpl<$Res>
    implements _$BusDiagramDtoCopyWith<$Res> {
  __$BusDiagramDtoCopyWithImpl(this._self, this._then);

  final _BusDiagramDto _self;
  final $Res Function(_BusDiagramDto) _then;

/// Create a copy of BusDiagramDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? diagramId = null,Object? name = null,Object? campusName = null,Object? routes = null,Object? metadata = null,}) {
  return _then(_BusDiagramDto(
diagramId: null == diagramId ? _self.diagramId : diagramId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,campusName: null == campusName ? _self.campusName : campusName // ignore: cast_nullable_to_non_nullable
as String,routes: null == routes ? _self._routes : routes // ignore: cast_nullable_to_non_nullable
as List<RouteDto>,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}


/// @nodoc
mixin _$RouteDto {

 String get lineId; String get routeName; String get direction; String get transportMode; List<String> get stations; Map<String, dynamic> get metadata;
/// Create a copy of RouteDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RouteDtoCopyWith<RouteDto> get copyWith => _$RouteDtoCopyWithImpl<RouteDto>(this as RouteDto, _$identity);

  /// Serializes this RouteDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RouteDto&&(identical(other.lineId, lineId) || other.lineId == lineId)&&(identical(other.routeName, routeName) || other.routeName == routeName)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.transportMode, transportMode) || other.transportMode == transportMode)&&const DeepCollectionEquality().equals(other.stations, stations)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lineId,routeName,direction,transportMode,const DeepCollectionEquality().hash(stations),const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'RouteDto(lineId: $lineId, routeName: $routeName, direction: $direction, transportMode: $transportMode, stations: $stations, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $RouteDtoCopyWith<$Res>  {
  factory $RouteDtoCopyWith(RouteDto value, $Res Function(RouteDto) _then) = _$RouteDtoCopyWithImpl;
@useResult
$Res call({
 String lineId, String routeName, String direction, String transportMode, List<String> stations, Map<String, dynamic> metadata
});




}
/// @nodoc
class _$RouteDtoCopyWithImpl<$Res>
    implements $RouteDtoCopyWith<$Res> {
  _$RouteDtoCopyWithImpl(this._self, this._then);

  final RouteDto _self;
  final $Res Function(RouteDto) _then;

/// Create a copy of RouteDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lineId = null,Object? routeName = null,Object? direction = null,Object? transportMode = null,Object? stations = null,Object? metadata = null,}) {
  return _then(_self.copyWith(
lineId: null == lineId ? _self.lineId : lineId // ignore: cast_nullable_to_non_nullable
as String,routeName: null == routeName ? _self.routeName : routeName // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,transportMode: null == transportMode ? _self.transportMode : transportMode // ignore: cast_nullable_to_non_nullable
as String,stations: null == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<String>,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _RouteDto implements RouteDto {
  const _RouteDto({required this.lineId, required this.routeName, required this.direction, required this.transportMode, required final  List<String> stations, final  Map<String, dynamic> metadata = const {}}): _stations = stations,_metadata = metadata;
  factory _RouteDto.fromJson(Map<String, dynamic> json) => _$RouteDtoFromJson(json);

@override final  String lineId;
@override final  String routeName;
@override final  String direction;
@override final  String transportMode;
 final  List<String> _stations;
@override List<String> get stations {
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stations);
}

 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of RouteDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RouteDtoCopyWith<_RouteDto> get copyWith => __$RouteDtoCopyWithImpl<_RouteDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RouteDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RouteDto&&(identical(other.lineId, lineId) || other.lineId == lineId)&&(identical(other.routeName, routeName) || other.routeName == routeName)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.transportMode, transportMode) || other.transportMode == transportMode)&&const DeepCollectionEquality().equals(other._stations, _stations)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lineId,routeName,direction,transportMode,const DeepCollectionEquality().hash(_stations),const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'RouteDto(lineId: $lineId, routeName: $routeName, direction: $direction, transportMode: $transportMode, stations: $stations, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$RouteDtoCopyWith<$Res> implements $RouteDtoCopyWith<$Res> {
  factory _$RouteDtoCopyWith(_RouteDto value, $Res Function(_RouteDto) _then) = __$RouteDtoCopyWithImpl;
@override @useResult
$Res call({
 String lineId, String routeName, String direction, String transportMode, List<String> stations, Map<String, dynamic> metadata
});




}
/// @nodoc
class __$RouteDtoCopyWithImpl<$Res>
    implements _$RouteDtoCopyWith<$Res> {
  __$RouteDtoCopyWithImpl(this._self, this._then);

  final _RouteDto _self;
  final $Res Function(_RouteDto) _then;

/// Create a copy of RouteDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lineId = null,Object? routeName = null,Object? direction = null,Object? transportMode = null,Object? stations = null,Object? metadata = null,}) {
  return _then(_RouteDto(
lineId: null == lineId ? _self.lineId : lineId // ignore: cast_nullable_to_non_nullable
as String,routeName: null == routeName ? _self.routeName : routeName // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,transportMode: null == transportMode ? _self.transportMode : transportMode // ignore: cast_nullable_to_non_nullable
as String,stations: null == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<String>,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
