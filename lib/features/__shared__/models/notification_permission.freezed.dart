// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_permission.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
NotificationPermission _$NotificationPermissionFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'granted':
          return _Granted.fromJson(
            json
          );
                case 'denied':
          return _Denied.fromJson(
            json
          );
                case 'provisional':
          return _Provisional.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'NotificationPermission',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$NotificationPermission {



  /// Serializes this NotificationPermission to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationPermission);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationPermission()';
}


}

/// @nodoc
class $NotificationPermissionCopyWith<$Res>  {
$NotificationPermissionCopyWith(NotificationPermission _, $Res Function(NotificationPermission) __);
}


/// @nodoc
@JsonSerializable()

class _Granted implements NotificationPermission {
  const _Granted({final  String? $type}): $type = $type ?? 'granted';
  factory _Granted.fromJson(Map<String, dynamic> json) => _$GrantedFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$GrantedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Granted);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationPermission.granted()';
}


}




/// @nodoc
@JsonSerializable()

class _Denied implements NotificationPermission {
  const _Denied({final  String? $type}): $type = $type ?? 'denied';
  factory _Denied.fromJson(Map<String, dynamic> json) => _$DeniedFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$DeniedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Denied);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationPermission.denied()';
}


}




/// @nodoc
@JsonSerializable()

class _Provisional implements NotificationPermission {
  const _Provisional({final  String? $type}): $type = $type ?? 'provisional';
  factory _Provisional.fromJson(Map<String, dynamic> json) => _$ProvisionalFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$ProvisionalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Provisional);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationPermission.provisional()';
}


}




// dart format on
