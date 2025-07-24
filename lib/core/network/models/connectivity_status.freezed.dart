// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connectivity_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConnectivityStatus {

/// Whether device is connected to internet
 bool get isConnected;/// Type of network connection
 ConnectivityType get type;/// Connection quality assessment
 ConnectionQuality get quality;/// Signal strength (0-100 for mobile, dBm for WiFi)
 int? get signalStrength;/// Connection speed in Kbps (if available)
 double? get speedKbps;/// Whether connection is metered (limited data)
 bool get isMetered;/// Whether roaming (for mobile connections)
 bool get isRoaming;/// Network name (SSID for WiFi, carrier for mobile)
 String? get networkName;/// IP address (if available)
 String? get ipAddress;/// Connection timestamp
 DateTime get timestamp;/// Additional metadata
 Map<String, dynamic> get metadata;
/// Create a copy of ConnectivityStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectivityStatusCopyWith<ConnectivityStatus> get copyWith => _$ConnectivityStatusCopyWithImpl<ConnectivityStatus>(this as ConnectivityStatus, _$identity);

  /// Serializes this ConnectivityStatus to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectivityStatus&&(identical(other.isConnected, isConnected) || other.isConnected == isConnected)&&(identical(other.type, type) || other.type == type)&&(identical(other.quality, quality) || other.quality == quality)&&(identical(other.signalStrength, signalStrength) || other.signalStrength == signalStrength)&&(identical(other.speedKbps, speedKbps) || other.speedKbps == speedKbps)&&(identical(other.isMetered, isMetered) || other.isMetered == isMetered)&&(identical(other.isRoaming, isRoaming) || other.isRoaming == isRoaming)&&(identical(other.networkName, networkName) || other.networkName == networkName)&&(identical(other.ipAddress, ipAddress) || other.ipAddress == ipAddress)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isConnected,type,quality,signalStrength,speedKbps,isMetered,isRoaming,networkName,ipAddress,timestamp,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'ConnectivityStatus(isConnected: $isConnected, type: $type, quality: $quality, signalStrength: $signalStrength, speedKbps: $speedKbps, isMetered: $isMetered, isRoaming: $isRoaming, networkName: $networkName, ipAddress: $ipAddress, timestamp: $timestamp, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $ConnectivityStatusCopyWith<$Res>  {
  factory $ConnectivityStatusCopyWith(ConnectivityStatus value, $Res Function(ConnectivityStatus) _then) = _$ConnectivityStatusCopyWithImpl;
@useResult
$Res call({
 bool isConnected, ConnectivityType type, ConnectionQuality quality, int? signalStrength, double? speedKbps, bool isMetered, bool isRoaming, String? networkName, String? ipAddress, DateTime timestamp, Map<String, dynamic> metadata
});




}
/// @nodoc
class _$ConnectivityStatusCopyWithImpl<$Res>
    implements $ConnectivityStatusCopyWith<$Res> {
  _$ConnectivityStatusCopyWithImpl(this._self, this._then);

  final ConnectivityStatus _self;
  final $Res Function(ConnectivityStatus) _then;

/// Create a copy of ConnectivityStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isConnected = null,Object? type = null,Object? quality = null,Object? signalStrength = freezed,Object? speedKbps = freezed,Object? isMetered = null,Object? isRoaming = null,Object? networkName = freezed,Object? ipAddress = freezed,Object? timestamp = null,Object? metadata = null,}) {
  return _then(_self.copyWith(
isConnected: null == isConnected ? _self.isConnected : isConnected // ignore: cast_nullable_to_non_nullable
as bool,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ConnectivityType,quality: null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as ConnectionQuality,signalStrength: freezed == signalStrength ? _self.signalStrength : signalStrength // ignore: cast_nullable_to_non_nullable
as int?,speedKbps: freezed == speedKbps ? _self.speedKbps : speedKbps // ignore: cast_nullable_to_non_nullable
as double?,isMetered: null == isMetered ? _self.isMetered : isMetered // ignore: cast_nullable_to_non_nullable
as bool,isRoaming: null == isRoaming ? _self.isRoaming : isRoaming // ignore: cast_nullable_to_non_nullable
as bool,networkName: freezed == networkName ? _self.networkName : networkName // ignore: cast_nullable_to_non_nullable
as String?,ipAddress: freezed == ipAddress ? _self.ipAddress : ipAddress // ignore: cast_nullable_to_non_nullable
as String?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [ConnectivityStatus].
extension ConnectivityStatusPatterns on ConnectivityStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConnectivityStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConnectivityStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConnectivityStatus value)  $default,){
final _that = this;
switch (_that) {
case _ConnectivityStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConnectivityStatus value)?  $default,){
final _that = this;
switch (_that) {
case _ConnectivityStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isConnected,  ConnectivityType type,  ConnectionQuality quality,  int? signalStrength,  double? speedKbps,  bool isMetered,  bool isRoaming,  String? networkName,  String? ipAddress,  DateTime timestamp,  Map<String, dynamic> metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConnectivityStatus() when $default != null:
return $default(_that.isConnected,_that.type,_that.quality,_that.signalStrength,_that.speedKbps,_that.isMetered,_that.isRoaming,_that.networkName,_that.ipAddress,_that.timestamp,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isConnected,  ConnectivityType type,  ConnectionQuality quality,  int? signalStrength,  double? speedKbps,  bool isMetered,  bool isRoaming,  String? networkName,  String? ipAddress,  DateTime timestamp,  Map<String, dynamic> metadata)  $default,) {final _that = this;
switch (_that) {
case _ConnectivityStatus():
return $default(_that.isConnected,_that.type,_that.quality,_that.signalStrength,_that.speedKbps,_that.isMetered,_that.isRoaming,_that.networkName,_that.ipAddress,_that.timestamp,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isConnected,  ConnectivityType type,  ConnectionQuality quality,  int? signalStrength,  double? speedKbps,  bool isMetered,  bool isRoaming,  String? networkName,  String? ipAddress,  DateTime timestamp,  Map<String, dynamic> metadata)?  $default,) {final _that = this;
switch (_that) {
case _ConnectivityStatus() when $default != null:
return $default(_that.isConnected,_that.type,_that.quality,_that.signalStrength,_that.speedKbps,_that.isMetered,_that.isRoaming,_that.networkName,_that.ipAddress,_that.timestamp,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConnectivityStatus implements ConnectivityStatus {
  const _ConnectivityStatus({required this.isConnected, required this.type, this.quality = ConnectionQuality.unknown, this.signalStrength, this.speedKbps, this.isMetered = false, this.isRoaming = false, this.networkName, this.ipAddress, required this.timestamp, final  Map<String, dynamic> metadata = const {}}): _metadata = metadata;
  factory _ConnectivityStatus.fromJson(Map<String, dynamic> json) => _$ConnectivityStatusFromJson(json);

/// Whether device is connected to internet
@override final  bool isConnected;
/// Type of network connection
@override final  ConnectivityType type;
/// Connection quality assessment
@override@JsonKey() final  ConnectionQuality quality;
/// Signal strength (0-100 for mobile, dBm for WiFi)
@override final  int? signalStrength;
/// Connection speed in Kbps (if available)
@override final  double? speedKbps;
/// Whether connection is metered (limited data)
@override@JsonKey() final  bool isMetered;
/// Whether roaming (for mobile connections)
@override@JsonKey() final  bool isRoaming;
/// Network name (SSID for WiFi, carrier for mobile)
@override final  String? networkName;
/// IP address (if available)
@override final  String? ipAddress;
/// Connection timestamp
@override final  DateTime timestamp;
/// Additional metadata
 final  Map<String, dynamic> _metadata;
/// Additional metadata
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of ConnectivityStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectivityStatusCopyWith<_ConnectivityStatus> get copyWith => __$ConnectivityStatusCopyWithImpl<_ConnectivityStatus>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConnectivityStatusToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectivityStatus&&(identical(other.isConnected, isConnected) || other.isConnected == isConnected)&&(identical(other.type, type) || other.type == type)&&(identical(other.quality, quality) || other.quality == quality)&&(identical(other.signalStrength, signalStrength) || other.signalStrength == signalStrength)&&(identical(other.speedKbps, speedKbps) || other.speedKbps == speedKbps)&&(identical(other.isMetered, isMetered) || other.isMetered == isMetered)&&(identical(other.isRoaming, isRoaming) || other.isRoaming == isRoaming)&&(identical(other.networkName, networkName) || other.networkName == networkName)&&(identical(other.ipAddress, ipAddress) || other.ipAddress == ipAddress)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isConnected,type,quality,signalStrength,speedKbps,isMetered,isRoaming,networkName,ipAddress,timestamp,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'ConnectivityStatus(isConnected: $isConnected, type: $type, quality: $quality, signalStrength: $signalStrength, speedKbps: $speedKbps, isMetered: $isMetered, isRoaming: $isRoaming, networkName: $networkName, ipAddress: $ipAddress, timestamp: $timestamp, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$ConnectivityStatusCopyWith<$Res> implements $ConnectivityStatusCopyWith<$Res> {
  factory _$ConnectivityStatusCopyWith(_ConnectivityStatus value, $Res Function(_ConnectivityStatus) _then) = __$ConnectivityStatusCopyWithImpl;
@override @useResult
$Res call({
 bool isConnected, ConnectivityType type, ConnectionQuality quality, int? signalStrength, double? speedKbps, bool isMetered, bool isRoaming, String? networkName, String? ipAddress, DateTime timestamp, Map<String, dynamic> metadata
});




}
/// @nodoc
class __$ConnectivityStatusCopyWithImpl<$Res>
    implements _$ConnectivityStatusCopyWith<$Res> {
  __$ConnectivityStatusCopyWithImpl(this._self, this._then);

  final _ConnectivityStatus _self;
  final $Res Function(_ConnectivityStatus) _then;

/// Create a copy of ConnectivityStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isConnected = null,Object? type = null,Object? quality = null,Object? signalStrength = freezed,Object? speedKbps = freezed,Object? isMetered = null,Object? isRoaming = null,Object? networkName = freezed,Object? ipAddress = freezed,Object? timestamp = null,Object? metadata = null,}) {
  return _then(_ConnectivityStatus(
isConnected: null == isConnected ? _self.isConnected : isConnected // ignore: cast_nullable_to_non_nullable
as bool,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ConnectivityType,quality: null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as ConnectionQuality,signalStrength: freezed == signalStrength ? _self.signalStrength : signalStrength // ignore: cast_nullable_to_non_nullable
as int?,speedKbps: freezed == speedKbps ? _self.speedKbps : speedKbps // ignore: cast_nullable_to_non_nullable
as double?,isMetered: null == isMetered ? _self.isMetered : isMetered // ignore: cast_nullable_to_non_nullable
as bool,isRoaming: null == isRoaming ? _self.isRoaming : isRoaming // ignore: cast_nullable_to_non_nullable
as bool,networkName: freezed == networkName ? _self.networkName : networkName // ignore: cast_nullable_to_non_nullable
as String?,ipAddress: freezed == ipAddress ? _self.ipAddress : ipAddress // ignore: cast_nullable_to_non_nullable
as String?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
