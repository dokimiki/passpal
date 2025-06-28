// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'holiday.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HolidayEntity {

 DateTime get date; String get name;
/// Create a copy of HolidayEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HolidayEntityCopyWith<HolidayEntity> get copyWith => _$HolidayEntityCopyWithImpl<HolidayEntity>(this as HolidayEntity, _$identity);

  /// Serializes this HolidayEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HolidayEntity&&(identical(other.date, date) || other.date == date)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,name);

@override
String toString() {
  return 'HolidayEntity(date: $date, name: $name)';
}


}

/// @nodoc
abstract mixin class $HolidayEntityCopyWith<$Res>  {
  factory $HolidayEntityCopyWith(HolidayEntity value, $Res Function(HolidayEntity) _then) = _$HolidayEntityCopyWithImpl;
@useResult
$Res call({
 DateTime date, String name
});




}
/// @nodoc
class _$HolidayEntityCopyWithImpl<$Res>
    implements $HolidayEntityCopyWith<$Res> {
  _$HolidayEntityCopyWithImpl(this._self, this._then);

  final HolidayEntity _self;
  final $Res Function(HolidayEntity) _then;

/// Create a copy of HolidayEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? name = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _HolidayEntity implements HolidayEntity {
  const _HolidayEntity({required this.date, required this.name});
  factory _HolidayEntity.fromJson(Map<String, dynamic> json) => _$HolidayEntityFromJson(json);

@override final  DateTime date;
@override final  String name;

/// Create a copy of HolidayEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HolidayEntityCopyWith<_HolidayEntity> get copyWith => __$HolidayEntityCopyWithImpl<_HolidayEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HolidayEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HolidayEntity&&(identical(other.date, date) || other.date == date)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,name);

@override
String toString() {
  return 'HolidayEntity(date: $date, name: $name)';
}


}

/// @nodoc
abstract mixin class _$HolidayEntityCopyWith<$Res> implements $HolidayEntityCopyWith<$Res> {
  factory _$HolidayEntityCopyWith(_HolidayEntity value, $Res Function(_HolidayEntity) _then) = __$HolidayEntityCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, String name
});




}
/// @nodoc
class __$HolidayEntityCopyWithImpl<$Res>
    implements _$HolidayEntityCopyWith<$Res> {
  __$HolidayEntityCopyWithImpl(this._self, this._then);

  final _HolidayEntity _self;
  final $Res Function(_HolidayEntity) _then;

/// Create a copy of HolidayEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? name = null,}) {
  return _then(_HolidayEntity(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$HolidayCollection {

 Map<String, String> get holidays; DateTime? get lastUpdated;
/// Create a copy of HolidayCollection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HolidayCollectionCopyWith<HolidayCollection> get copyWith => _$HolidayCollectionCopyWithImpl<HolidayCollection>(this as HolidayCollection, _$identity);

  /// Serializes this HolidayCollection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HolidayCollection&&const DeepCollectionEquality().equals(other.holidays, holidays)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(holidays),lastUpdated);

@override
String toString() {
  return 'HolidayCollection(holidays: $holidays, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class $HolidayCollectionCopyWith<$Res>  {
  factory $HolidayCollectionCopyWith(HolidayCollection value, $Res Function(HolidayCollection) _then) = _$HolidayCollectionCopyWithImpl;
@useResult
$Res call({
 Map<String, String> holidays, DateTime? lastUpdated
});




}
/// @nodoc
class _$HolidayCollectionCopyWithImpl<$Res>
    implements $HolidayCollectionCopyWith<$Res> {
  _$HolidayCollectionCopyWithImpl(this._self, this._then);

  final HolidayCollection _self;
  final $Res Function(HolidayCollection) _then;

/// Create a copy of HolidayCollection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? holidays = null,Object? lastUpdated = freezed,}) {
  return _then(_self.copyWith(
holidays: null == holidays ? _self.holidays : holidays // ignore: cast_nullable_to_non_nullable
as Map<String, String>,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _HolidayCollection implements HolidayCollection {
  const _HolidayCollection({required final  Map<String, String> holidays, this.lastUpdated}): _holidays = holidays;
  factory _HolidayCollection.fromJson(Map<String, dynamic> json) => _$HolidayCollectionFromJson(json);

 final  Map<String, String> _holidays;
@override Map<String, String> get holidays {
  if (_holidays is EqualUnmodifiableMapView) return _holidays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_holidays);
}

@override final  DateTime? lastUpdated;

/// Create a copy of HolidayCollection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HolidayCollectionCopyWith<_HolidayCollection> get copyWith => __$HolidayCollectionCopyWithImpl<_HolidayCollection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HolidayCollectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HolidayCollection&&const DeepCollectionEquality().equals(other._holidays, _holidays)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_holidays),lastUpdated);

@override
String toString() {
  return 'HolidayCollection(holidays: $holidays, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class _$HolidayCollectionCopyWith<$Res> implements $HolidayCollectionCopyWith<$Res> {
  factory _$HolidayCollectionCopyWith(_HolidayCollection value, $Res Function(_HolidayCollection) _then) = __$HolidayCollectionCopyWithImpl;
@override @useResult
$Res call({
 Map<String, String> holidays, DateTime? lastUpdated
});




}
/// @nodoc
class __$HolidayCollectionCopyWithImpl<$Res>
    implements _$HolidayCollectionCopyWith<$Res> {
  __$HolidayCollectionCopyWithImpl(this._self, this._then);

  final _HolidayCollection _self;
  final $Res Function(_HolidayCollection) _then;

/// Create a copy of HolidayCollection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? holidays = null,Object? lastUpdated = freezed,}) {
  return _then(_HolidayCollection(
holidays: null == holidays ? _self._holidays : holidays // ignore: cast_nullable_to_non_nullable
as Map<String, String>,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
