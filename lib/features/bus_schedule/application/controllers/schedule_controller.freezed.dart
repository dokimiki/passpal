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





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimetableState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TimetableState()';
}


}

/// @nodoc
class $TimetableStateCopyWith<$Res>  {
$TimetableStateCopyWith(TimetableState _, $Res Function(TimetableState) __);
}


/// @nodoc


class TimetableLoading implements TimetableState {
  const TimetableLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimetableLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TimetableState.loading()';
}


}




/// @nodoc


class TimetableLoaded implements TimetableState {
  const TimetableLoaded(final  List<DepartureDTO> items): _items = items;
  

 final  List<DepartureDTO> _items;
 List<DepartureDTO> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of TimetableState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimetableLoadedCopyWith<TimetableLoaded> get copyWith => _$TimetableLoadedCopyWithImpl<TimetableLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimetableLoaded&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'TimetableState.loaded(items: $items)';
}


}

/// @nodoc
abstract mixin class $TimetableLoadedCopyWith<$Res> implements $TimetableStateCopyWith<$Res> {
  factory $TimetableLoadedCopyWith(TimetableLoaded value, $Res Function(TimetableLoaded) _then) = _$TimetableLoadedCopyWithImpl;
@useResult
$Res call({
 List<DepartureDTO> items
});




}
/// @nodoc
class _$TimetableLoadedCopyWithImpl<$Res>
    implements $TimetableLoadedCopyWith<$Res> {
  _$TimetableLoadedCopyWithImpl(this._self, this._then);

  final TimetableLoaded _self;
  final $Res Function(TimetableLoaded) _then;

/// Create a copy of TimetableState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(TimetableLoaded(
null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<DepartureDTO>,
  ));
}


}

/// @nodoc


class TimetableError implements TimetableState {
  const TimetableError(this.message);
  

 final  String message;

/// Create a copy of TimetableState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimetableErrorCopyWith<TimetableError> get copyWith => _$TimetableErrorCopyWithImpl<TimetableError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimetableError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'TimetableState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $TimetableErrorCopyWith<$Res> implements $TimetableStateCopyWith<$Res> {
  factory $TimetableErrorCopyWith(TimetableError value, $Res Function(TimetableError) _then) = _$TimetableErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$TimetableErrorCopyWithImpl<$Res>
    implements $TimetableErrorCopyWith<$Res> {
  _$TimetableErrorCopyWithImpl(this._self, this._then);

  final TimetableError _self;
  final $Res Function(TimetableError) _then;

/// Create a copy of TimetableState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(TimetableError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
