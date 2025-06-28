// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TimetableState {

 List<DepartureDTO> get items; bool get loading; SimpleError? get error;
/// Create a copy of TimetableState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimetableStateCopyWith<TimetableState> get copyWith => _$TimetableStateCopyWithImpl<TimetableState>(this as TimetableState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimetableState&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),loading,error);

@override
String toString() {
  return 'TimetableState(items: $items, loading: $loading, error: $error)';
}


}

/// @nodoc
abstract mixin class $TimetableStateCopyWith<$Res>  {
  factory $TimetableStateCopyWith(TimetableState value, $Res Function(TimetableState) _then) = _$TimetableStateCopyWithImpl;
@useResult
$Res call({
 List<DepartureDTO> items, bool loading, SimpleError? error
});




}
/// @nodoc
class _$TimetableStateCopyWithImpl<$Res>
    implements $TimetableStateCopyWith<$Res> {
  _$TimetableStateCopyWithImpl(this._self, this._then);

  final TimetableState _self;
  final $Res Function(TimetableState) _then;

/// Create a copy of TimetableState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? loading = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<DepartureDTO>,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SimpleError?,
  ));
}

}


/// @nodoc


class _TimetableState implements TimetableState {
  const _TimetableState({final  List<DepartureDTO> items = const [], this.loading = false, this.error}): _items = items;
  

 final  List<DepartureDTO> _items;
@override@JsonKey() List<DepartureDTO> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  bool loading;
@override final  SimpleError? error;

/// Create a copy of TimetableState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimetableStateCopyWith<_TimetableState> get copyWith => __$TimetableStateCopyWithImpl<_TimetableState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimetableState&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),loading,error);

@override
String toString() {
  return 'TimetableState(items: $items, loading: $loading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$TimetableStateCopyWith<$Res> implements $TimetableStateCopyWith<$Res> {
  factory _$TimetableStateCopyWith(_TimetableState value, $Res Function(_TimetableState) _then) = __$TimetableStateCopyWithImpl;
@override @useResult
$Res call({
 List<DepartureDTO> items, bool loading, SimpleError? error
});




}
/// @nodoc
class __$TimetableStateCopyWithImpl<$Res>
    implements _$TimetableStateCopyWith<$Res> {
  __$TimetableStateCopyWithImpl(this._self, this._then);

  final _TimetableState _self;
  final $Res Function(_TimetableState) _then;

/// Create a copy of TimetableState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? loading = null,Object? error = freezed,}) {
  return _then(_TimetableState(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<DepartureDTO>,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SimpleError?,
  ));
}


}

// dart format on
