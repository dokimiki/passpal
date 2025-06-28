// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campus.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
Campus _$CampusFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'nagoya':
          return _Nagoya.fromJson(
            json
          );
                case 'toyota':
          return _Toyota.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'Campus',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$Campus {



  /// Serializes this Campus to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Campus);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Campus()';
}


}

/// @nodoc
class $CampusCopyWith<$Res>  {
$CampusCopyWith(Campus _, $Res Function(Campus) __);
}


/// @nodoc
@JsonSerializable()

class _Nagoya implements Campus {
  const _Nagoya({final  String? $type}): $type = $type ?? 'nagoya';
  factory _Nagoya.fromJson(Map<String, dynamic> json) => _$NagoyaFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$NagoyaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Nagoya);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Campus.nagoya()';
}


}




/// @nodoc
@JsonSerializable()

class _Toyota implements Campus {
  const _Toyota({final  String? $type}): $type = $type ?? 'toyota';
  factory _Toyota.fromJson(Map<String, dynamic> json) => _$ToyotaFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$ToyotaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Toyota);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Campus.toyota()';
}


}




// dart format on
