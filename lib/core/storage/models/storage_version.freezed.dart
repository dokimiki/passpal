// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'storage_version.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StorageVersion {

 int get version; String get description; DateTime get createdAt; List<String> get migrations;
/// Create a copy of StorageVersion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorageVersionCopyWith<StorageVersion> get copyWith => _$StorageVersionCopyWithImpl<StorageVersion>(this as StorageVersion, _$identity);

  /// Serializes this StorageVersion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorageVersion&&(identical(other.version, version) || other.version == version)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.migrations, migrations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,description,createdAt,const DeepCollectionEquality().hash(migrations));

@override
String toString() {
  return 'StorageVersion(version: $version, description: $description, createdAt: $createdAt, migrations: $migrations)';
}


}

/// @nodoc
abstract mixin class $StorageVersionCopyWith<$Res>  {
  factory $StorageVersionCopyWith(StorageVersion value, $Res Function(StorageVersion) _then) = _$StorageVersionCopyWithImpl;
@useResult
$Res call({
 int version, String description, DateTime createdAt, List<String> migrations
});




}
/// @nodoc
class _$StorageVersionCopyWithImpl<$Res>
    implements $StorageVersionCopyWith<$Res> {
  _$StorageVersionCopyWithImpl(this._self, this._then);

  final StorageVersion _self;
  final $Res Function(StorageVersion) _then;

/// Create a copy of StorageVersion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? description = null,Object? createdAt = null,Object? migrations = null,}) {
  return _then(_self.copyWith(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,migrations: null == migrations ? _self.migrations : migrations // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [StorageVersion].
extension StorageVersionPatterns on StorageVersion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StorageVersion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StorageVersion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StorageVersion value)  $default,){
final _that = this;
switch (_that) {
case _StorageVersion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StorageVersion value)?  $default,){
final _that = this;
switch (_that) {
case _StorageVersion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int version,  String description,  DateTime createdAt,  List<String> migrations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StorageVersion() when $default != null:
return $default(_that.version,_that.description,_that.createdAt,_that.migrations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int version,  String description,  DateTime createdAt,  List<String> migrations)  $default,) {final _that = this;
switch (_that) {
case _StorageVersion():
return $default(_that.version,_that.description,_that.createdAt,_that.migrations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int version,  String description,  DateTime createdAt,  List<String> migrations)?  $default,) {final _that = this;
switch (_that) {
case _StorageVersion() when $default != null:
return $default(_that.version,_that.description,_that.createdAt,_that.migrations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StorageVersion implements StorageVersion {
  const _StorageVersion({required this.version, required this.description, required this.createdAt, final  List<String> migrations = const <String>[]}): _migrations = migrations;
  factory _StorageVersion.fromJson(Map<String, dynamic> json) => _$StorageVersionFromJson(json);

@override final  int version;
@override final  String description;
@override final  DateTime createdAt;
 final  List<String> _migrations;
@override@JsonKey() List<String> get migrations {
  if (_migrations is EqualUnmodifiableListView) return _migrations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_migrations);
}


/// Create a copy of StorageVersion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StorageVersionCopyWith<_StorageVersion> get copyWith => __$StorageVersionCopyWithImpl<_StorageVersion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StorageVersionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StorageVersion&&(identical(other.version, version) || other.version == version)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._migrations, _migrations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,description,createdAt,const DeepCollectionEquality().hash(_migrations));

@override
String toString() {
  return 'StorageVersion(version: $version, description: $description, createdAt: $createdAt, migrations: $migrations)';
}


}

/// @nodoc
abstract mixin class _$StorageVersionCopyWith<$Res> implements $StorageVersionCopyWith<$Res> {
  factory _$StorageVersionCopyWith(_StorageVersion value, $Res Function(_StorageVersion) _then) = __$StorageVersionCopyWithImpl;
@override @useResult
$Res call({
 int version, String description, DateTime createdAt, List<String> migrations
});




}
/// @nodoc
class __$StorageVersionCopyWithImpl<$Res>
    implements _$StorageVersionCopyWith<$Res> {
  __$StorageVersionCopyWithImpl(this._self, this._then);

  final _StorageVersion _self;
  final $Res Function(_StorageVersion) _then;

/// Create a copy of StorageVersion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? description = null,Object? createdAt = null,Object? migrations = null,}) {
  return _then(_StorageVersion(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,migrations: null == migrations ? _self._migrations : migrations // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$MigrationStep {

 String get id; int get fromVersion; int get toVersion; String get description; MigrationType get type; Map<String, dynamic> get parameters;
/// Create a copy of MigrationStep
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MigrationStepCopyWith<MigrationStep> get copyWith => _$MigrationStepCopyWithImpl<MigrationStep>(this as MigrationStep, _$identity);

  /// Serializes this MigrationStep to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MigrationStep&&(identical(other.id, id) || other.id == id)&&(identical(other.fromVersion, fromVersion) || other.fromVersion == fromVersion)&&(identical(other.toVersion, toVersion) || other.toVersion == toVersion)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.parameters, parameters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fromVersion,toVersion,description,type,const DeepCollectionEquality().hash(parameters));

@override
String toString() {
  return 'MigrationStep(id: $id, fromVersion: $fromVersion, toVersion: $toVersion, description: $description, type: $type, parameters: $parameters)';
}


}

/// @nodoc
abstract mixin class $MigrationStepCopyWith<$Res>  {
  factory $MigrationStepCopyWith(MigrationStep value, $Res Function(MigrationStep) _then) = _$MigrationStepCopyWithImpl;
@useResult
$Res call({
 String id, int fromVersion, int toVersion, String description, MigrationType type, Map<String, dynamic> parameters
});




}
/// @nodoc
class _$MigrationStepCopyWithImpl<$Res>
    implements $MigrationStepCopyWith<$Res> {
  _$MigrationStepCopyWithImpl(this._self, this._then);

  final MigrationStep _self;
  final $Res Function(MigrationStep) _then;

/// Create a copy of MigrationStep
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fromVersion = null,Object? toVersion = null,Object? description = null,Object? type = null,Object? parameters = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fromVersion: null == fromVersion ? _self.fromVersion : fromVersion // ignore: cast_nullable_to_non_nullable
as int,toVersion: null == toVersion ? _self.toVersion : toVersion // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MigrationType,parameters: null == parameters ? _self.parameters : parameters // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [MigrationStep].
extension MigrationStepPatterns on MigrationStep {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MigrationStep value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MigrationStep() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MigrationStep value)  $default,){
final _that = this;
switch (_that) {
case _MigrationStep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MigrationStep value)?  $default,){
final _that = this;
switch (_that) {
case _MigrationStep() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int fromVersion,  int toVersion,  String description,  MigrationType type,  Map<String, dynamic> parameters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MigrationStep() when $default != null:
return $default(_that.id,_that.fromVersion,_that.toVersion,_that.description,_that.type,_that.parameters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int fromVersion,  int toVersion,  String description,  MigrationType type,  Map<String, dynamic> parameters)  $default,) {final _that = this;
switch (_that) {
case _MigrationStep():
return $default(_that.id,_that.fromVersion,_that.toVersion,_that.description,_that.type,_that.parameters);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int fromVersion,  int toVersion,  String description,  MigrationType type,  Map<String, dynamic> parameters)?  $default,) {final _that = this;
switch (_that) {
case _MigrationStep() when $default != null:
return $default(_that.id,_that.fromVersion,_that.toVersion,_that.description,_that.type,_that.parameters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MigrationStep implements MigrationStep {
  const _MigrationStep({required this.id, required this.fromVersion, required this.toVersion, required this.description, required this.type, required final  Map<String, dynamic> parameters}): _parameters = parameters;
  factory _MigrationStep.fromJson(Map<String, dynamic> json) => _$MigrationStepFromJson(json);

@override final  String id;
@override final  int fromVersion;
@override final  int toVersion;
@override final  String description;
@override final  MigrationType type;
 final  Map<String, dynamic> _parameters;
@override Map<String, dynamic> get parameters {
  if (_parameters is EqualUnmodifiableMapView) return _parameters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_parameters);
}


/// Create a copy of MigrationStep
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MigrationStepCopyWith<_MigrationStep> get copyWith => __$MigrationStepCopyWithImpl<_MigrationStep>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MigrationStepToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MigrationStep&&(identical(other.id, id) || other.id == id)&&(identical(other.fromVersion, fromVersion) || other.fromVersion == fromVersion)&&(identical(other.toVersion, toVersion) || other.toVersion == toVersion)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._parameters, _parameters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fromVersion,toVersion,description,type,const DeepCollectionEquality().hash(_parameters));

@override
String toString() {
  return 'MigrationStep(id: $id, fromVersion: $fromVersion, toVersion: $toVersion, description: $description, type: $type, parameters: $parameters)';
}


}

/// @nodoc
abstract mixin class _$MigrationStepCopyWith<$Res> implements $MigrationStepCopyWith<$Res> {
  factory _$MigrationStepCopyWith(_MigrationStep value, $Res Function(_MigrationStep) _then) = __$MigrationStepCopyWithImpl;
@override @useResult
$Res call({
 String id, int fromVersion, int toVersion, String description, MigrationType type, Map<String, dynamic> parameters
});




}
/// @nodoc
class __$MigrationStepCopyWithImpl<$Res>
    implements _$MigrationStepCopyWith<$Res> {
  __$MigrationStepCopyWithImpl(this._self, this._then);

  final _MigrationStep _self;
  final $Res Function(_MigrationStep) _then;

/// Create a copy of MigrationStep
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fromVersion = null,Object? toVersion = null,Object? description = null,Object? type = null,Object? parameters = null,}) {
  return _then(_MigrationStep(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fromVersion: null == fromVersion ? _self.fromVersion : fromVersion // ignore: cast_nullable_to_non_nullable
as int,toVersion: null == toVersion ? _self.toVersion : toVersion // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MigrationType,parameters: null == parameters ? _self._parameters : parameters // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}


/// @nodoc
mixin _$MigrationResult {

 bool get success; int get fromVersion; int get toVersion; List<String> get appliedMigrations; String? get error; Map<String, dynamic> get metadata;
/// Create a copy of MigrationResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MigrationResultCopyWith<MigrationResult> get copyWith => _$MigrationResultCopyWithImpl<MigrationResult>(this as MigrationResult, _$identity);

  /// Serializes this MigrationResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MigrationResult&&(identical(other.success, success) || other.success == success)&&(identical(other.fromVersion, fromVersion) || other.fromVersion == fromVersion)&&(identical(other.toVersion, toVersion) || other.toVersion == toVersion)&&const DeepCollectionEquality().equals(other.appliedMigrations, appliedMigrations)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,fromVersion,toVersion,const DeepCollectionEquality().hash(appliedMigrations),error,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'MigrationResult(success: $success, fromVersion: $fromVersion, toVersion: $toVersion, appliedMigrations: $appliedMigrations, error: $error, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $MigrationResultCopyWith<$Res>  {
  factory $MigrationResultCopyWith(MigrationResult value, $Res Function(MigrationResult) _then) = _$MigrationResultCopyWithImpl;
@useResult
$Res call({
 bool success, int fromVersion, int toVersion, List<String> appliedMigrations, String? error, Map<String, dynamic> metadata
});




}
/// @nodoc
class _$MigrationResultCopyWithImpl<$Res>
    implements $MigrationResultCopyWith<$Res> {
  _$MigrationResultCopyWithImpl(this._self, this._then);

  final MigrationResult _self;
  final $Res Function(MigrationResult) _then;

/// Create a copy of MigrationResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? fromVersion = null,Object? toVersion = null,Object? appliedMigrations = null,Object? error = freezed,Object? metadata = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,fromVersion: null == fromVersion ? _self.fromVersion : fromVersion // ignore: cast_nullable_to_non_nullable
as int,toVersion: null == toVersion ? _self.toVersion : toVersion // ignore: cast_nullable_to_non_nullable
as int,appliedMigrations: null == appliedMigrations ? _self.appliedMigrations : appliedMigrations // ignore: cast_nullable_to_non_nullable
as List<String>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [MigrationResult].
extension MigrationResultPatterns on MigrationResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MigrationResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MigrationResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MigrationResult value)  $default,){
final _that = this;
switch (_that) {
case _MigrationResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MigrationResult value)?  $default,){
final _that = this;
switch (_that) {
case _MigrationResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  int fromVersion,  int toVersion,  List<String> appliedMigrations,  String? error,  Map<String, dynamic> metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MigrationResult() when $default != null:
return $default(_that.success,_that.fromVersion,_that.toVersion,_that.appliedMigrations,_that.error,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  int fromVersion,  int toVersion,  List<String> appliedMigrations,  String? error,  Map<String, dynamic> metadata)  $default,) {final _that = this;
switch (_that) {
case _MigrationResult():
return $default(_that.success,_that.fromVersion,_that.toVersion,_that.appliedMigrations,_that.error,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  int fromVersion,  int toVersion,  List<String> appliedMigrations,  String? error,  Map<String, dynamic> metadata)?  $default,) {final _that = this;
switch (_that) {
case _MigrationResult() when $default != null:
return $default(_that.success,_that.fromVersion,_that.toVersion,_that.appliedMigrations,_that.error,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MigrationResult implements MigrationResult {
  const _MigrationResult({required this.success, required this.fromVersion, required this.toVersion, required final  List<String> appliedMigrations, this.error, final  Map<String, dynamic> metadata = const <String, dynamic>{}}): _appliedMigrations = appliedMigrations,_metadata = metadata;
  factory _MigrationResult.fromJson(Map<String, dynamic> json) => _$MigrationResultFromJson(json);

@override final  bool success;
@override final  int fromVersion;
@override final  int toVersion;
 final  List<String> _appliedMigrations;
@override List<String> get appliedMigrations {
  if (_appliedMigrations is EqualUnmodifiableListView) return _appliedMigrations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_appliedMigrations);
}

@override final  String? error;
 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of MigrationResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MigrationResultCopyWith<_MigrationResult> get copyWith => __$MigrationResultCopyWithImpl<_MigrationResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MigrationResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MigrationResult&&(identical(other.success, success) || other.success == success)&&(identical(other.fromVersion, fromVersion) || other.fromVersion == fromVersion)&&(identical(other.toVersion, toVersion) || other.toVersion == toVersion)&&const DeepCollectionEquality().equals(other._appliedMigrations, _appliedMigrations)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,fromVersion,toVersion,const DeepCollectionEquality().hash(_appliedMigrations),error,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'MigrationResult(success: $success, fromVersion: $fromVersion, toVersion: $toVersion, appliedMigrations: $appliedMigrations, error: $error, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$MigrationResultCopyWith<$Res> implements $MigrationResultCopyWith<$Res> {
  factory _$MigrationResultCopyWith(_MigrationResult value, $Res Function(_MigrationResult) _then) = __$MigrationResultCopyWithImpl;
@override @useResult
$Res call({
 bool success, int fromVersion, int toVersion, List<String> appliedMigrations, String? error, Map<String, dynamic> metadata
});




}
/// @nodoc
class __$MigrationResultCopyWithImpl<$Res>
    implements _$MigrationResultCopyWith<$Res> {
  __$MigrationResultCopyWithImpl(this._self, this._then);

  final _MigrationResult _self;
  final $Res Function(_MigrationResult) _then;

/// Create a copy of MigrationResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? fromVersion = null,Object? toVersion = null,Object? appliedMigrations = null,Object? error = freezed,Object? metadata = null,}) {
  return _then(_MigrationResult(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,fromVersion: null == fromVersion ? _self.fromVersion : fromVersion // ignore: cast_nullable_to_non_nullable
as int,toVersion: null == toVersion ? _self.toVersion : toVersion // ignore: cast_nullable_to_non_nullable
as int,appliedMigrations: null == appliedMigrations ? _self._appliedMigrations : appliedMigrations // ignore: cast_nullable_to_non_nullable
as List<String>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
