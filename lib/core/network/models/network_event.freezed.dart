// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NetworkEvent {

/// Previous connectivity status (null for initial state)
 ConnectivityStatus? get previous;/// Current connectivity status
 ConnectivityStatus get current;/// Timestamp when the event occurred
 DateTime get timestamp;/// Event type classification
 NetworkEventType get type;/// Optional additional context or metadata
 Map<String, dynamic>? get metadata;
/// Create a copy of NetworkEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkEventCopyWith<NetworkEvent> get copyWith => _$NetworkEventCopyWithImpl<NetworkEvent>(this as NetworkEvent, _$identity);

  /// Serializes this NetworkEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkEvent&&(identical(other.previous, previous) || other.previous == previous)&&(identical(other.current, current) || other.current == current)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,previous,current,timestamp,type,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'NetworkEvent(previous: $previous, current: $current, timestamp: $timestamp, type: $type, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $NetworkEventCopyWith<$Res>  {
  factory $NetworkEventCopyWith(NetworkEvent value, $Res Function(NetworkEvent) _then) = _$NetworkEventCopyWithImpl;
@useResult
$Res call({
 ConnectivityStatus? previous, ConnectivityStatus current, DateTime timestamp, NetworkEventType type, Map<String, dynamic>? metadata
});


$ConnectivityStatusCopyWith<$Res>? get previous;$ConnectivityStatusCopyWith<$Res> get current;$NetworkEventTypeCopyWith<$Res> get type;

}
/// @nodoc
class _$NetworkEventCopyWithImpl<$Res>
    implements $NetworkEventCopyWith<$Res> {
  _$NetworkEventCopyWithImpl(this._self, this._then);

  final NetworkEvent _self;
  final $Res Function(NetworkEvent) _then;

/// Create a copy of NetworkEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? previous = freezed,Object? current = null,Object? timestamp = null,Object? type = null,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
previous: freezed == previous ? _self.previous : previous // ignore: cast_nullable_to_non_nullable
as ConnectivityStatus?,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as ConnectivityStatus,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NetworkEventType,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}
/// Create a copy of NetworkEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConnectivityStatusCopyWith<$Res>? get previous {
    if (_self.previous == null) {
    return null;
  }

  return $ConnectivityStatusCopyWith<$Res>(_self.previous!, (value) {
    return _then(_self.copyWith(previous: value));
  });
}/// Create a copy of NetworkEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConnectivityStatusCopyWith<$Res> get current {
  
  return $ConnectivityStatusCopyWith<$Res>(_self.current, (value) {
    return _then(_self.copyWith(current: value));
  });
}/// Create a copy of NetworkEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NetworkEventTypeCopyWith<$Res> get type {
  
  return $NetworkEventTypeCopyWith<$Res>(_self.type, (value) {
    return _then(_self.copyWith(type: value));
  });
}
}


/// Adds pattern-matching-related methods to [NetworkEvent].
extension NetworkEventPatterns on NetworkEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NetworkEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NetworkEvent() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NetworkEvent value)  $default,){
final _that = this;
switch (_that) {
case _NetworkEvent():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NetworkEvent value)?  $default,){
final _that = this;
switch (_that) {
case _NetworkEvent() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ConnectivityStatus? previous,  ConnectivityStatus current,  DateTime timestamp,  NetworkEventType type,  Map<String, dynamic>? metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NetworkEvent() when $default != null:
return $default(_that.previous,_that.current,_that.timestamp,_that.type,_that.metadata);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ConnectivityStatus? previous,  ConnectivityStatus current,  DateTime timestamp,  NetworkEventType type,  Map<String, dynamic>? metadata)  $default,) {final _that = this;
switch (_that) {
case _NetworkEvent():
return $default(_that.previous,_that.current,_that.timestamp,_that.type,_that.metadata);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ConnectivityStatus? previous,  ConnectivityStatus current,  DateTime timestamp,  NetworkEventType type,  Map<String, dynamic>? metadata)?  $default,) {final _that = this;
switch (_that) {
case _NetworkEvent() when $default != null:
return $default(_that.previous,_that.current,_that.timestamp,_that.type,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NetworkEvent implements NetworkEvent {
  const _NetworkEvent({this.previous, required this.current, required this.timestamp, required this.type, final  Map<String, dynamic>? metadata}): _metadata = metadata;
  factory _NetworkEvent.fromJson(Map<String, dynamic> json) => _$NetworkEventFromJson(json);

/// Previous connectivity status (null for initial state)
@override final  ConnectivityStatus? previous;
/// Current connectivity status
@override final  ConnectivityStatus current;
/// Timestamp when the event occurred
@override final  DateTime timestamp;
/// Event type classification
@override final  NetworkEventType type;
/// Optional additional context or metadata
 final  Map<String, dynamic>? _metadata;
/// Optional additional context or metadata
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of NetworkEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NetworkEventCopyWith<_NetworkEvent> get copyWith => __$NetworkEventCopyWithImpl<_NetworkEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NetworkEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NetworkEvent&&(identical(other.previous, previous) || other.previous == previous)&&(identical(other.current, current) || other.current == current)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,previous,current,timestamp,type,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'NetworkEvent(previous: $previous, current: $current, timestamp: $timestamp, type: $type, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$NetworkEventCopyWith<$Res> implements $NetworkEventCopyWith<$Res> {
  factory _$NetworkEventCopyWith(_NetworkEvent value, $Res Function(_NetworkEvent) _then) = __$NetworkEventCopyWithImpl;
@override @useResult
$Res call({
 ConnectivityStatus? previous, ConnectivityStatus current, DateTime timestamp, NetworkEventType type, Map<String, dynamic>? metadata
});


@override $ConnectivityStatusCopyWith<$Res>? get previous;@override $ConnectivityStatusCopyWith<$Res> get current;@override $NetworkEventTypeCopyWith<$Res> get type;

}
/// @nodoc
class __$NetworkEventCopyWithImpl<$Res>
    implements _$NetworkEventCopyWith<$Res> {
  __$NetworkEventCopyWithImpl(this._self, this._then);

  final _NetworkEvent _self;
  final $Res Function(_NetworkEvent) _then;

/// Create a copy of NetworkEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? previous = freezed,Object? current = null,Object? timestamp = null,Object? type = null,Object? metadata = freezed,}) {
  return _then(_NetworkEvent(
previous: freezed == previous ? _self.previous : previous // ignore: cast_nullable_to_non_nullable
as ConnectivityStatus?,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as ConnectivityStatus,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NetworkEventType,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

/// Create a copy of NetworkEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConnectivityStatusCopyWith<$Res>? get previous {
    if (_self.previous == null) {
    return null;
  }

  return $ConnectivityStatusCopyWith<$Res>(_self.previous!, (value) {
    return _then(_self.copyWith(previous: value));
  });
}/// Create a copy of NetworkEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConnectivityStatusCopyWith<$Res> get current {
  
  return $ConnectivityStatusCopyWith<$Res>(_self.current, (value) {
    return _then(_self.copyWith(current: value));
  });
}/// Create a copy of NetworkEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NetworkEventTypeCopyWith<$Res> get type {
  
  return $NetworkEventTypeCopyWith<$Res>(_self.type, (value) {
    return _then(_self.copyWith(type: value));
  });
}
}

NetworkEventType _$NetworkEventTypeFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'connected':
          return _Connected.fromJson(
            json
          );
                case 'disconnected':
          return _Disconnected.fromJson(
            json
          );
                case 'typeChanged':
          return _TypeChanged.fromJson(
            json
          );
                case 'qualityChanged':
          return _QualityChanged.fromJson(
            json
          );
                case 'initial':
          return _Initial.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'NetworkEventType',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$NetworkEventType {



  /// Serializes this NetworkEventType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkEventType);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkEventType()';
}


}

/// @nodoc
class $NetworkEventTypeCopyWith<$Res>  {
$NetworkEventTypeCopyWith(NetworkEventType _, $Res Function(NetworkEventType) __);
}


/// Adds pattern-matching-related methods to [NetworkEventType].
extension NetworkEventTypePatterns on NetworkEventType {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Connected value)?  connected,TResult Function( _Disconnected value)?  disconnected,TResult Function( _TypeChanged value)?  typeChanged,TResult Function( _QualityChanged value)?  qualityChanged,TResult Function( _Initial value)?  initial,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Connected() when connected != null:
return connected(_that);case _Disconnected() when disconnected != null:
return disconnected(_that);case _TypeChanged() when typeChanged != null:
return typeChanged(_that);case _QualityChanged() when qualityChanged != null:
return qualityChanged(_that);case _Initial() when initial != null:
return initial(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Connected value)  connected,required TResult Function( _Disconnected value)  disconnected,required TResult Function( _TypeChanged value)  typeChanged,required TResult Function( _QualityChanged value)  qualityChanged,required TResult Function( _Initial value)  initial,}){
final _that = this;
switch (_that) {
case _Connected():
return connected(_that);case _Disconnected():
return disconnected(_that);case _TypeChanged():
return typeChanged(_that);case _QualityChanged():
return qualityChanged(_that);case _Initial():
return initial(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Connected value)?  connected,TResult? Function( _Disconnected value)?  disconnected,TResult? Function( _TypeChanged value)?  typeChanged,TResult? Function( _QualityChanged value)?  qualityChanged,TResult? Function( _Initial value)?  initial,}){
final _that = this;
switch (_that) {
case _Connected() when connected != null:
return connected(_that);case _Disconnected() when disconnected != null:
return disconnected(_that);case _TypeChanged() when typeChanged != null:
return typeChanged(_that);case _QualityChanged() when qualityChanged != null:
return qualityChanged(_that);case _Initial() when initial != null:
return initial(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  connected,TResult Function()?  disconnected,TResult Function()?  typeChanged,TResult Function()?  qualityChanged,TResult Function()?  initial,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Connected() when connected != null:
return connected();case _Disconnected() when disconnected != null:
return disconnected();case _TypeChanged() when typeChanged != null:
return typeChanged();case _QualityChanged() when qualityChanged != null:
return qualityChanged();case _Initial() when initial != null:
return initial();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  connected,required TResult Function()  disconnected,required TResult Function()  typeChanged,required TResult Function()  qualityChanged,required TResult Function()  initial,}) {final _that = this;
switch (_that) {
case _Connected():
return connected();case _Disconnected():
return disconnected();case _TypeChanged():
return typeChanged();case _QualityChanged():
return qualityChanged();case _Initial():
return initial();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  connected,TResult? Function()?  disconnected,TResult? Function()?  typeChanged,TResult? Function()?  qualityChanged,TResult? Function()?  initial,}) {final _that = this;
switch (_that) {
case _Connected() when connected != null:
return connected();case _Disconnected() when disconnected != null:
return disconnected();case _TypeChanged() when typeChanged != null:
return typeChanged();case _QualityChanged() when qualityChanged != null:
return qualityChanged();case _Initial() when initial != null:
return initial();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Connected implements NetworkEventType {
  const _Connected({final  String? $type}): $type = $type ?? 'connected';
  factory _Connected.fromJson(Map<String, dynamic> json) => _$ConnectedFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$ConnectedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Connected);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkEventType.connected()';
}


}




/// @nodoc
@JsonSerializable()

class _Disconnected implements NetworkEventType {
  const _Disconnected({final  String? $type}): $type = $type ?? 'disconnected';
  factory _Disconnected.fromJson(Map<String, dynamic> json) => _$DisconnectedFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$DisconnectedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Disconnected);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkEventType.disconnected()';
}


}




/// @nodoc
@JsonSerializable()

class _TypeChanged implements NetworkEventType {
  const _TypeChanged({final  String? $type}): $type = $type ?? 'typeChanged';
  factory _TypeChanged.fromJson(Map<String, dynamic> json) => _$TypeChangedFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$TypeChangedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TypeChanged);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkEventType.typeChanged()';
}


}




/// @nodoc
@JsonSerializable()

class _QualityChanged implements NetworkEventType {
  const _QualityChanged({final  String? $type}): $type = $type ?? 'qualityChanged';
  factory _QualityChanged.fromJson(Map<String, dynamic> json) => _$QualityChangedFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$QualityChangedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QualityChanged);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkEventType.qualityChanged()';
}


}




/// @nodoc
@JsonSerializable()

class _Initial implements NetworkEventType {
  const _Initial({final  String? $type}): $type = $type ?? 'initial';
  factory _Initial.fromJson(Map<String, dynamic> json) => _$InitialFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$InitialToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkEventType.initial()';
}


}




// dart format on
