// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Failure {

 String get message; String get errorCode; StackTrace? get stackTrace; DateTime get timestamp; Duration? get retryDelay; Map<String, dynamic>? get context;
/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureCopyWith<Failure> get copyWith => _$FailureCopyWithImpl<Failure>(this as Failure, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure&&(identical(other.message, message) || other.message == message)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.retryDelay, retryDelay) || other.retryDelay == retryDelay)&&const DeepCollectionEquality().equals(other.context, context));
}


@override
int get hashCode => Object.hash(runtimeType,message,errorCode,stackTrace,timestamp,retryDelay,const DeepCollectionEquality().hash(context));

@override
String toString() {
  return 'Failure(message: $message, errorCode: $errorCode, stackTrace: $stackTrace, timestamp: $timestamp, retryDelay: $retryDelay, context: $context)';
}


}

/// @nodoc
abstract mixin class $FailureCopyWith<$Res>  {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) _then) = _$FailureCopyWithImpl;
@useResult
$Res call({
 String message, String errorCode, StackTrace? stackTrace, DateTime timestamp, Duration? retryDelay, Map<String, dynamic>? context
});




}
/// @nodoc
class _$FailureCopyWithImpl<$Res>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._self, this._then);

  final Failure _self;
  final $Res Function(Failure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? errorCode = null,Object? stackTrace = freezed,Object? timestamp = null,Object? retryDelay = freezed,Object? context = freezed,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,errorCode: null == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,retryDelay: freezed == retryDelay ? _self.retryDelay : retryDelay // ignore: cast_nullable_to_non_nullable
as Duration?,context: freezed == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [Failure].
extension FailurePatterns on Failure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NetworkFailure value)?  network,TResult Function( ParseFailure value)?  parse,TResult Function( ConfigSourceFailure value)?  configSource,TResult Function( ConfigParseFailure value)?  configParse,TResult Function( StorageReadFailure value)?  storageRead,TResult Function( StorageWriteFailure value)?  storageWrite,TResult Function( StorageSerializationFailure value)?  storageSerialization,TResult Function( StorageCapacityFailure value)?  storageCapacity,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network(_that);case ParseFailure() when parse != null:
return parse(_that);case ConfigSourceFailure() when configSource != null:
return configSource(_that);case ConfigParseFailure() when configParse != null:
return configParse(_that);case StorageReadFailure() when storageRead != null:
return storageRead(_that);case StorageWriteFailure() when storageWrite != null:
return storageWrite(_that);case StorageSerializationFailure() when storageSerialization != null:
return storageSerialization(_that);case StorageCapacityFailure() when storageCapacity != null:
return storageCapacity(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NetworkFailure value)  network,required TResult Function( ParseFailure value)  parse,required TResult Function( ConfigSourceFailure value)  configSource,required TResult Function( ConfigParseFailure value)  configParse,required TResult Function( StorageReadFailure value)  storageRead,required TResult Function( StorageWriteFailure value)  storageWrite,required TResult Function( StorageSerializationFailure value)  storageSerialization,required TResult Function( StorageCapacityFailure value)  storageCapacity,}){
final _that = this;
switch (_that) {
case NetworkFailure():
return network(_that);case ParseFailure():
return parse(_that);case ConfigSourceFailure():
return configSource(_that);case ConfigParseFailure():
return configParse(_that);case StorageReadFailure():
return storageRead(_that);case StorageWriteFailure():
return storageWrite(_that);case StorageSerializationFailure():
return storageSerialization(_that);case StorageCapacityFailure():
return storageCapacity(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NetworkFailure value)?  network,TResult? Function( ParseFailure value)?  parse,TResult? Function( ConfigSourceFailure value)?  configSource,TResult? Function( ConfigParseFailure value)?  configParse,TResult? Function( StorageReadFailure value)?  storageRead,TResult? Function( StorageWriteFailure value)?  storageWrite,TResult? Function( StorageSerializationFailure value)?  storageSerialization,TResult? Function( StorageCapacityFailure value)?  storageCapacity,}){
final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network(_that);case ParseFailure() when parse != null:
return parse(_that);case ConfigSourceFailure() when configSource != null:
return configSource(_that);case ConfigParseFailure() when configParse != null:
return configParse(_that);case StorageReadFailure() when storageRead != null:
return storageRead(_that);case StorageWriteFailure() when storageWrite != null:
return storageWrite(_that);case StorageSerializationFailure() when storageSerialization != null:
return storageSerialization(_that);case StorageCapacityFailure() when storageCapacity != null:
return storageCapacity(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Duration? retryDelay,  Map<String, dynamic>? context)?  network,TResult Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Duration? retryDelay,  Map<String, dynamic>? context)?  parse,TResult Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Duration? retryDelay,  Map<String, dynamic>? context)?  configSource,TResult Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Duration? retryDelay,  Map<String, dynamic>? context)?  configParse,TResult Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Duration? retryDelay,  Map<String, dynamic>? context)?  storageRead,TResult Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Duration? retryDelay,  Map<String, dynamic>? context)?  storageWrite,TResult Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Duration? retryDelay,  Map<String, dynamic>? context)?  storageSerialization,TResult Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Duration? retryDelay,  Map<String, dynamic>? context)?  storageCapacity,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.retryDelay,_that.context);case ParseFailure() when parse != null:
return parse(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.retryDelay,_that.context);case ConfigSourceFailure() when configSource != null:
return configSource(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.retryDelay,_that.context);case ConfigParseFailure() when configParse != null:
return configParse(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.retryDelay,_that.context);case StorageReadFailure() when storageRead != null:
return storageRead(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.retryDelay,_that.context);case StorageWriteFailure() when storageWrite != null:
return storageWrite(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.retryDelay,_that.context);case StorageSerializationFailure() when storageSerialization != null:
return storageSerialization(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.retryDelay,_that.context);case StorageCapacityFailure() when storageCapacity != null:
return storageCapacity(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.retryDelay,_that.context);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Duration? retryDelay,  Map<String, dynamic>? context)  network,required TResult Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Duration? retryDelay,  Map<String, dynamic>? context)  parse,required TResult Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Duration? retryDelay,  Map<String, dynamic>? context)  configSource,required TResult Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Duration? retryDelay,  Map<String, dynamic>? context)  configParse,required TResult Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Duration? retryDelay,  Map<String, dynamic>? context)  storageRead,required TResult Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Duration? retryDelay,  Map<String, dynamic>? context)  storageWrite,required TResult Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Duration? retryDelay,  Map<String, dynamic>? context)  storageSerialization,required TResult Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Duration? retryDelay,  Map<String, dynamic>? context)  storageCapacity,}) {final _that = this;
switch (_that) {
case NetworkFailure():
return network(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.retryDelay,_that.context);case ParseFailure():
return parse(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.retryDelay,_that.context);case ConfigSourceFailure():
return configSource(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.retryDelay,_that.context);case ConfigParseFailure():
return configParse(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.retryDelay,_that.context);case StorageReadFailure():
return storageRead(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.retryDelay,_that.context);case StorageWriteFailure():
return storageWrite(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.retryDelay,_that.context);case StorageSerializationFailure():
return storageSerialization(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.retryDelay,_that.context);case StorageCapacityFailure():
return storageCapacity(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.retryDelay,_that.context);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Duration? retryDelay,  Map<String, dynamic>? context)?  network,TResult? Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Duration? retryDelay,  Map<String, dynamic>? context)?  parse,TResult? Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Duration? retryDelay,  Map<String, dynamic>? context)?  configSource,TResult? Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Duration? retryDelay,  Map<String, dynamic>? context)?  configParse,TResult? Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Duration? retryDelay,  Map<String, dynamic>? context)?  storageRead,TResult? Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Duration? retryDelay,  Map<String, dynamic>? context)?  storageWrite,TResult? Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Duration? retryDelay,  Map<String, dynamic>? context)?  storageSerialization,TResult? Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Duration? retryDelay,  Map<String, dynamic>? context)?  storageCapacity,}) {final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.retryDelay,_that.context);case ParseFailure() when parse != null:
return parse(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.retryDelay,_that.context);case ConfigSourceFailure() when configSource != null:
return configSource(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.retryDelay,_that.context);case ConfigParseFailure() when configParse != null:
return configParse(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.retryDelay,_that.context);case StorageReadFailure() when storageRead != null:
return storageRead(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.retryDelay,_that.context);case StorageWriteFailure() when storageWrite != null:
return storageWrite(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.retryDelay,_that.context);case StorageSerializationFailure() when storageSerialization != null:
return storageSerialization(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.retryDelay,_that.context);case StorageCapacityFailure() when storageCapacity != null:
return storageCapacity(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.retryDelay,_that.context);case _:
  return null;

}
}

}

/// @nodoc


class NetworkFailure extends Failure {
  const NetworkFailure({required this.message, required this.errorCode, this.stackTrace, required this.timestamp, this.retryDelay, final  Map<String, dynamic>? context}): _context = context,super._();
  

@override final  String message;
@override final  String errorCode;
@override final  StackTrace? stackTrace;
@override final  DateTime timestamp;
@override final  Duration? retryDelay;
 final  Map<String, dynamic>? _context;
@override Map<String, dynamic>? get context {
  final value = _context;
  if (value == null) return null;
  if (_context is EqualUnmodifiableMapView) return _context;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkFailureCopyWith<NetworkFailure> get copyWith => _$NetworkFailureCopyWithImpl<NetworkFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkFailure&&(identical(other.message, message) || other.message == message)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.retryDelay, retryDelay) || other.retryDelay == retryDelay)&&const DeepCollectionEquality().equals(other._context, _context));
}


@override
int get hashCode => Object.hash(runtimeType,message,errorCode,stackTrace,timestamp,retryDelay,const DeepCollectionEquality().hash(_context));

@override
String toString() {
  return 'Failure.network(message: $message, errorCode: $errorCode, stackTrace: $stackTrace, timestamp: $timestamp, retryDelay: $retryDelay, context: $context)';
}


}

/// @nodoc
abstract mixin class $NetworkFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $NetworkFailureCopyWith(NetworkFailure value, $Res Function(NetworkFailure) _then) = _$NetworkFailureCopyWithImpl;
@override @useResult
$Res call({
 String message, String errorCode, StackTrace? stackTrace, DateTime timestamp, Duration? retryDelay, Map<String, dynamic>? context
});




}
/// @nodoc
class _$NetworkFailureCopyWithImpl<$Res>
    implements $NetworkFailureCopyWith<$Res> {
  _$NetworkFailureCopyWithImpl(this._self, this._then);

  final NetworkFailure _self;
  final $Res Function(NetworkFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? errorCode = null,Object? stackTrace = freezed,Object? timestamp = null,Object? retryDelay = freezed,Object? context = freezed,}) {
  return _then(NetworkFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,errorCode: null == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,retryDelay: freezed == retryDelay ? _self.retryDelay : retryDelay // ignore: cast_nullable_to_non_nullable
as Duration?,context: freezed == context ? _self._context : context // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

/// @nodoc


class ParseFailure extends Failure {
  const ParseFailure({required this.message, required this.errorCode, this.stackTrace, required this.timestamp, this.retryDelay, final  Map<String, dynamic>? context}): _context = context,super._();
  

@override final  String message;
@override final  String errorCode;
@override final  StackTrace? stackTrace;
@override final  DateTime timestamp;
@override final  Duration? retryDelay;
 final  Map<String, dynamic>? _context;
@override Map<String, dynamic>? get context {
  final value = _context;
  if (value == null) return null;
  if (_context is EqualUnmodifiableMapView) return _context;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParseFailureCopyWith<ParseFailure> get copyWith => _$ParseFailureCopyWithImpl<ParseFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParseFailure&&(identical(other.message, message) || other.message == message)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.retryDelay, retryDelay) || other.retryDelay == retryDelay)&&const DeepCollectionEquality().equals(other._context, _context));
}


@override
int get hashCode => Object.hash(runtimeType,message,errorCode,stackTrace,timestamp,retryDelay,const DeepCollectionEquality().hash(_context));

@override
String toString() {
  return 'Failure.parse(message: $message, errorCode: $errorCode, stackTrace: $stackTrace, timestamp: $timestamp, retryDelay: $retryDelay, context: $context)';
}


}

/// @nodoc
abstract mixin class $ParseFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ParseFailureCopyWith(ParseFailure value, $Res Function(ParseFailure) _then) = _$ParseFailureCopyWithImpl;
@override @useResult
$Res call({
 String message, String errorCode, StackTrace? stackTrace, DateTime timestamp, Duration? retryDelay, Map<String, dynamic>? context
});




}
/// @nodoc
class _$ParseFailureCopyWithImpl<$Res>
    implements $ParseFailureCopyWith<$Res> {
  _$ParseFailureCopyWithImpl(this._self, this._then);

  final ParseFailure _self;
  final $Res Function(ParseFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? errorCode = null,Object? stackTrace = freezed,Object? timestamp = null,Object? retryDelay = freezed,Object? context = freezed,}) {
  return _then(ParseFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,errorCode: null == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,retryDelay: freezed == retryDelay ? _self.retryDelay : retryDelay // ignore: cast_nullable_to_non_nullable
as Duration?,context: freezed == context ? _self._context : context // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

/// @nodoc


class ConfigSourceFailure extends Failure {
  const ConfigSourceFailure({required this.message, required this.errorCode, this.stackTrace, required this.timestamp, this.retryDelay, final  Map<String, dynamic>? context}): _context = context,super._();
  

@override final  String message;
@override final  String errorCode;
@override final  StackTrace? stackTrace;
@override final  DateTime timestamp;
@override final  Duration? retryDelay;
 final  Map<String, dynamic>? _context;
@override Map<String, dynamic>? get context {
  final value = _context;
  if (value == null) return null;
  if (_context is EqualUnmodifiableMapView) return _context;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConfigSourceFailureCopyWith<ConfigSourceFailure> get copyWith => _$ConfigSourceFailureCopyWithImpl<ConfigSourceFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfigSourceFailure&&(identical(other.message, message) || other.message == message)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.retryDelay, retryDelay) || other.retryDelay == retryDelay)&&const DeepCollectionEquality().equals(other._context, _context));
}


@override
int get hashCode => Object.hash(runtimeType,message,errorCode,stackTrace,timestamp,retryDelay,const DeepCollectionEquality().hash(_context));

@override
String toString() {
  return 'Failure.configSource(message: $message, errorCode: $errorCode, stackTrace: $stackTrace, timestamp: $timestamp, retryDelay: $retryDelay, context: $context)';
}


}

/// @nodoc
abstract mixin class $ConfigSourceFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ConfigSourceFailureCopyWith(ConfigSourceFailure value, $Res Function(ConfigSourceFailure) _then) = _$ConfigSourceFailureCopyWithImpl;
@override @useResult
$Res call({
 String message, String errorCode, StackTrace? stackTrace, DateTime timestamp, Duration? retryDelay, Map<String, dynamic>? context
});




}
/// @nodoc
class _$ConfigSourceFailureCopyWithImpl<$Res>
    implements $ConfigSourceFailureCopyWith<$Res> {
  _$ConfigSourceFailureCopyWithImpl(this._self, this._then);

  final ConfigSourceFailure _self;
  final $Res Function(ConfigSourceFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? errorCode = null,Object? stackTrace = freezed,Object? timestamp = null,Object? retryDelay = freezed,Object? context = freezed,}) {
  return _then(ConfigSourceFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,errorCode: null == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,retryDelay: freezed == retryDelay ? _self.retryDelay : retryDelay // ignore: cast_nullable_to_non_nullable
as Duration?,context: freezed == context ? _self._context : context // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

/// @nodoc


class ConfigParseFailure extends Failure {
  const ConfigParseFailure({required this.message, required this.errorCode, this.stackTrace, required this.timestamp, this.retryDelay, final  Map<String, dynamic>? context}): _context = context,super._();
  

@override final  String message;
@override final  String errorCode;
@override final  StackTrace? stackTrace;
@override final  DateTime timestamp;
@override final  Duration? retryDelay;
 final  Map<String, dynamic>? _context;
@override Map<String, dynamic>? get context {
  final value = _context;
  if (value == null) return null;
  if (_context is EqualUnmodifiableMapView) return _context;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConfigParseFailureCopyWith<ConfigParseFailure> get copyWith => _$ConfigParseFailureCopyWithImpl<ConfigParseFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfigParseFailure&&(identical(other.message, message) || other.message == message)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.retryDelay, retryDelay) || other.retryDelay == retryDelay)&&const DeepCollectionEquality().equals(other._context, _context));
}


@override
int get hashCode => Object.hash(runtimeType,message,errorCode,stackTrace,timestamp,retryDelay,const DeepCollectionEquality().hash(_context));

@override
String toString() {
  return 'Failure.configParse(message: $message, errorCode: $errorCode, stackTrace: $stackTrace, timestamp: $timestamp, retryDelay: $retryDelay, context: $context)';
}


}

/// @nodoc
abstract mixin class $ConfigParseFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ConfigParseFailureCopyWith(ConfigParseFailure value, $Res Function(ConfigParseFailure) _then) = _$ConfigParseFailureCopyWithImpl;
@override @useResult
$Res call({
 String message, String errorCode, StackTrace? stackTrace, DateTime timestamp, Duration? retryDelay, Map<String, dynamic>? context
});




}
/// @nodoc
class _$ConfigParseFailureCopyWithImpl<$Res>
    implements $ConfigParseFailureCopyWith<$Res> {
  _$ConfigParseFailureCopyWithImpl(this._self, this._then);

  final ConfigParseFailure _self;
  final $Res Function(ConfigParseFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? errorCode = null,Object? stackTrace = freezed,Object? timestamp = null,Object? retryDelay = freezed,Object? context = freezed,}) {
  return _then(ConfigParseFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,errorCode: null == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,retryDelay: freezed == retryDelay ? _self.retryDelay : retryDelay // ignore: cast_nullable_to_non_nullable
as Duration?,context: freezed == context ? _self._context : context // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

/// @nodoc


class StorageReadFailure extends Failure {
  const StorageReadFailure({required this.message, required this.errorCode, this.stackTrace, required this.timestamp, this.retryDelay, final  Map<String, dynamic>? context}): _context = context,super._();
  

@override final  String message;
@override final  String errorCode;
@override final  StackTrace? stackTrace;
@override final  DateTime timestamp;
@override final  Duration? retryDelay;
 final  Map<String, dynamic>? _context;
@override Map<String, dynamic>? get context {
  final value = _context;
  if (value == null) return null;
  if (_context is EqualUnmodifiableMapView) return _context;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorageReadFailureCopyWith<StorageReadFailure> get copyWith => _$StorageReadFailureCopyWithImpl<StorageReadFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorageReadFailure&&(identical(other.message, message) || other.message == message)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.retryDelay, retryDelay) || other.retryDelay == retryDelay)&&const DeepCollectionEquality().equals(other._context, _context));
}


@override
int get hashCode => Object.hash(runtimeType,message,errorCode,stackTrace,timestamp,retryDelay,const DeepCollectionEquality().hash(_context));

@override
String toString() {
  return 'Failure.storageRead(message: $message, errorCode: $errorCode, stackTrace: $stackTrace, timestamp: $timestamp, retryDelay: $retryDelay, context: $context)';
}


}

/// @nodoc
abstract mixin class $StorageReadFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $StorageReadFailureCopyWith(StorageReadFailure value, $Res Function(StorageReadFailure) _then) = _$StorageReadFailureCopyWithImpl;
@override @useResult
$Res call({
 String message, String errorCode, StackTrace? stackTrace, DateTime timestamp, Duration? retryDelay, Map<String, dynamic>? context
});




}
/// @nodoc
class _$StorageReadFailureCopyWithImpl<$Res>
    implements $StorageReadFailureCopyWith<$Res> {
  _$StorageReadFailureCopyWithImpl(this._self, this._then);

  final StorageReadFailure _self;
  final $Res Function(StorageReadFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? errorCode = null,Object? stackTrace = freezed,Object? timestamp = null,Object? retryDelay = freezed,Object? context = freezed,}) {
  return _then(StorageReadFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,errorCode: null == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,retryDelay: freezed == retryDelay ? _self.retryDelay : retryDelay // ignore: cast_nullable_to_non_nullable
as Duration?,context: freezed == context ? _self._context : context // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

/// @nodoc


class StorageWriteFailure extends Failure {
  const StorageWriteFailure({required this.message, required this.errorCode, this.stackTrace, required this.timestamp, this.retryDelay, final  Map<String, dynamic>? context}): _context = context,super._();
  

@override final  String message;
@override final  String errorCode;
@override final  StackTrace? stackTrace;
@override final  DateTime timestamp;
@override final  Duration? retryDelay;
 final  Map<String, dynamic>? _context;
@override Map<String, dynamic>? get context {
  final value = _context;
  if (value == null) return null;
  if (_context is EqualUnmodifiableMapView) return _context;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorageWriteFailureCopyWith<StorageWriteFailure> get copyWith => _$StorageWriteFailureCopyWithImpl<StorageWriteFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorageWriteFailure&&(identical(other.message, message) || other.message == message)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.retryDelay, retryDelay) || other.retryDelay == retryDelay)&&const DeepCollectionEquality().equals(other._context, _context));
}


@override
int get hashCode => Object.hash(runtimeType,message,errorCode,stackTrace,timestamp,retryDelay,const DeepCollectionEquality().hash(_context));

@override
String toString() {
  return 'Failure.storageWrite(message: $message, errorCode: $errorCode, stackTrace: $stackTrace, timestamp: $timestamp, retryDelay: $retryDelay, context: $context)';
}


}

/// @nodoc
abstract mixin class $StorageWriteFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $StorageWriteFailureCopyWith(StorageWriteFailure value, $Res Function(StorageWriteFailure) _then) = _$StorageWriteFailureCopyWithImpl;
@override @useResult
$Res call({
 String message, String errorCode, StackTrace? stackTrace, DateTime timestamp, Duration? retryDelay, Map<String, dynamic>? context
});




}
/// @nodoc
class _$StorageWriteFailureCopyWithImpl<$Res>
    implements $StorageWriteFailureCopyWith<$Res> {
  _$StorageWriteFailureCopyWithImpl(this._self, this._then);

  final StorageWriteFailure _self;
  final $Res Function(StorageWriteFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? errorCode = null,Object? stackTrace = freezed,Object? timestamp = null,Object? retryDelay = freezed,Object? context = freezed,}) {
  return _then(StorageWriteFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,errorCode: null == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,retryDelay: freezed == retryDelay ? _self.retryDelay : retryDelay // ignore: cast_nullable_to_non_nullable
as Duration?,context: freezed == context ? _self._context : context // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

/// @nodoc


class StorageSerializationFailure extends Failure {
  const StorageSerializationFailure({required this.message, required this.errorCode, this.stackTrace, required this.timestamp, this.retryDelay, final  Map<String, dynamic>? context}): _context = context,super._();
  

@override final  String message;
@override final  String errorCode;
@override final  StackTrace? stackTrace;
@override final  DateTime timestamp;
@override final  Duration? retryDelay;
 final  Map<String, dynamic>? _context;
@override Map<String, dynamic>? get context {
  final value = _context;
  if (value == null) return null;
  if (_context is EqualUnmodifiableMapView) return _context;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorageSerializationFailureCopyWith<StorageSerializationFailure> get copyWith => _$StorageSerializationFailureCopyWithImpl<StorageSerializationFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorageSerializationFailure&&(identical(other.message, message) || other.message == message)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.retryDelay, retryDelay) || other.retryDelay == retryDelay)&&const DeepCollectionEquality().equals(other._context, _context));
}


@override
int get hashCode => Object.hash(runtimeType,message,errorCode,stackTrace,timestamp,retryDelay,const DeepCollectionEquality().hash(_context));

@override
String toString() {
  return 'Failure.storageSerialization(message: $message, errorCode: $errorCode, stackTrace: $stackTrace, timestamp: $timestamp, retryDelay: $retryDelay, context: $context)';
}


}

/// @nodoc
abstract mixin class $StorageSerializationFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $StorageSerializationFailureCopyWith(StorageSerializationFailure value, $Res Function(StorageSerializationFailure) _then) = _$StorageSerializationFailureCopyWithImpl;
@override @useResult
$Res call({
 String message, String errorCode, StackTrace? stackTrace, DateTime timestamp, Duration? retryDelay, Map<String, dynamic>? context
});




}
/// @nodoc
class _$StorageSerializationFailureCopyWithImpl<$Res>
    implements $StorageSerializationFailureCopyWith<$Res> {
  _$StorageSerializationFailureCopyWithImpl(this._self, this._then);

  final StorageSerializationFailure _self;
  final $Res Function(StorageSerializationFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? errorCode = null,Object? stackTrace = freezed,Object? timestamp = null,Object? retryDelay = freezed,Object? context = freezed,}) {
  return _then(StorageSerializationFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,errorCode: null == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,retryDelay: freezed == retryDelay ? _self.retryDelay : retryDelay // ignore: cast_nullable_to_non_nullable
as Duration?,context: freezed == context ? _self._context : context // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

/// @nodoc


class StorageCapacityFailure extends Failure {
  const StorageCapacityFailure({required this.message, required this.errorCode, this.stackTrace, required this.timestamp, this.retryDelay, final  Map<String, dynamic>? context}): _context = context,super._();
  

@override final  String message;
@override final  String errorCode;
@override final  StackTrace? stackTrace;
@override final  DateTime timestamp;
@override final  Duration? retryDelay;
 final  Map<String, dynamic>? _context;
@override Map<String, dynamic>? get context {
  final value = _context;
  if (value == null) return null;
  if (_context is EqualUnmodifiableMapView) return _context;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorageCapacityFailureCopyWith<StorageCapacityFailure> get copyWith => _$StorageCapacityFailureCopyWithImpl<StorageCapacityFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorageCapacityFailure&&(identical(other.message, message) || other.message == message)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.retryDelay, retryDelay) || other.retryDelay == retryDelay)&&const DeepCollectionEquality().equals(other._context, _context));
}


@override
int get hashCode => Object.hash(runtimeType,message,errorCode,stackTrace,timestamp,retryDelay,const DeepCollectionEquality().hash(_context));

@override
String toString() {
  return 'Failure.storageCapacity(message: $message, errorCode: $errorCode, stackTrace: $stackTrace, timestamp: $timestamp, retryDelay: $retryDelay, context: $context)';
}


}

/// @nodoc
abstract mixin class $StorageCapacityFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $StorageCapacityFailureCopyWith(StorageCapacityFailure value, $Res Function(StorageCapacityFailure) _then) = _$StorageCapacityFailureCopyWithImpl;
@override @useResult
$Res call({
 String message, String errorCode, StackTrace? stackTrace, DateTime timestamp, Duration? retryDelay, Map<String, dynamic>? context
});




}
/// @nodoc
class _$StorageCapacityFailureCopyWithImpl<$Res>
    implements $StorageCapacityFailureCopyWith<$Res> {
  _$StorageCapacityFailureCopyWithImpl(this._self, this._then);

  final StorageCapacityFailure _self;
  final $Res Function(StorageCapacityFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? errorCode = null,Object? stackTrace = freezed,Object? timestamp = null,Object? retryDelay = freezed,Object? context = freezed,}) {
  return _then(StorageCapacityFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,errorCode: null == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,retryDelay: freezed == retryDelay ? _self.retryDelay : retryDelay // ignore: cast_nullable_to_non_nullable
as Duration?,context: freezed == context ? _self._context : context // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
