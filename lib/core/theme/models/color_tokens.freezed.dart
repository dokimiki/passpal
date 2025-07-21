// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'color_tokens.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ColorTokens {

/// プライマリカラー系統
 PrimaryColors get primary;/// ステータスカラー系統
 StatusColors get status;/// ニュートラルカラー系統
 NeutralColors get neutral;/// 背景・サーフェスカラー系統
 SurfaceColors get surface;
/// Create a copy of ColorTokens
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ColorTokensCopyWith<ColorTokens> get copyWith => _$ColorTokensCopyWithImpl<ColorTokens>(this as ColorTokens, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ColorTokens&&(identical(other.primary, primary) || other.primary == primary)&&(identical(other.status, status) || other.status == status)&&(identical(other.neutral, neutral) || other.neutral == neutral)&&(identical(other.surface, surface) || other.surface == surface));
}


@override
int get hashCode => Object.hash(runtimeType,primary,status,neutral,surface);

@override
String toString() {
  return 'ColorTokens(primary: $primary, status: $status, neutral: $neutral, surface: $surface)';
}


}

/// @nodoc
abstract mixin class $ColorTokensCopyWith<$Res>  {
  factory $ColorTokensCopyWith(ColorTokens value, $Res Function(ColorTokens) _then) = _$ColorTokensCopyWithImpl;
@useResult
$Res call({
 PrimaryColors primary, StatusColors status, NeutralColors neutral, SurfaceColors surface
});


$PrimaryColorsCopyWith<$Res> get primary;$StatusColorsCopyWith<$Res> get status;$NeutralColorsCopyWith<$Res> get neutral;$SurfaceColorsCopyWith<$Res> get surface;

}
/// @nodoc
class _$ColorTokensCopyWithImpl<$Res>
    implements $ColorTokensCopyWith<$Res> {
  _$ColorTokensCopyWithImpl(this._self, this._then);

  final ColorTokens _self;
  final $Res Function(ColorTokens) _then;

/// Create a copy of ColorTokens
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? primary = null,Object? status = null,Object? neutral = null,Object? surface = null,}) {
  return _then(_self.copyWith(
primary: null == primary ? _self.primary : primary // ignore: cast_nullable_to_non_nullable
as PrimaryColors,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StatusColors,neutral: null == neutral ? _self.neutral : neutral // ignore: cast_nullable_to_non_nullable
as NeutralColors,surface: null == surface ? _self.surface : surface // ignore: cast_nullable_to_non_nullable
as SurfaceColors,
  ));
}
/// Create a copy of ColorTokens
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PrimaryColorsCopyWith<$Res> get primary {
  
  return $PrimaryColorsCopyWith<$Res>(_self.primary, (value) {
    return _then(_self.copyWith(primary: value));
  });
}/// Create a copy of ColorTokens
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatusColorsCopyWith<$Res> get status {
  
  return $StatusColorsCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of ColorTokens
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NeutralColorsCopyWith<$Res> get neutral {
  
  return $NeutralColorsCopyWith<$Res>(_self.neutral, (value) {
    return _then(_self.copyWith(neutral: value));
  });
}/// Create a copy of ColorTokens
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SurfaceColorsCopyWith<$Res> get surface {
  
  return $SurfaceColorsCopyWith<$Res>(_self.surface, (value) {
    return _then(_self.copyWith(surface: value));
  });
}
}


/// Adds pattern-matching-related methods to [ColorTokens].
extension ColorTokensPatterns on ColorTokens {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ColorTokens value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ColorTokens() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ColorTokens value)  $default,){
final _that = this;
switch (_that) {
case _ColorTokens():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ColorTokens value)?  $default,){
final _that = this;
switch (_that) {
case _ColorTokens() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PrimaryColors primary,  StatusColors status,  NeutralColors neutral,  SurfaceColors surface)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ColorTokens() when $default != null:
return $default(_that.primary,_that.status,_that.neutral,_that.surface);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PrimaryColors primary,  StatusColors status,  NeutralColors neutral,  SurfaceColors surface)  $default,) {final _that = this;
switch (_that) {
case _ColorTokens():
return $default(_that.primary,_that.status,_that.neutral,_that.surface);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PrimaryColors primary,  StatusColors status,  NeutralColors neutral,  SurfaceColors surface)?  $default,) {final _that = this;
switch (_that) {
case _ColorTokens() when $default != null:
return $default(_that.primary,_that.status,_that.neutral,_that.surface);case _:
  return null;

}
}

}

/// @nodoc


class _ColorTokens implements ColorTokens {
  const _ColorTokens({required this.primary, required this.status, required this.neutral, required this.surface});
  

/// プライマリカラー系統
@override final  PrimaryColors primary;
/// ステータスカラー系統
@override final  StatusColors status;
/// ニュートラルカラー系統
@override final  NeutralColors neutral;
/// 背景・サーフェスカラー系統
@override final  SurfaceColors surface;

/// Create a copy of ColorTokens
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ColorTokensCopyWith<_ColorTokens> get copyWith => __$ColorTokensCopyWithImpl<_ColorTokens>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ColorTokens&&(identical(other.primary, primary) || other.primary == primary)&&(identical(other.status, status) || other.status == status)&&(identical(other.neutral, neutral) || other.neutral == neutral)&&(identical(other.surface, surface) || other.surface == surface));
}


@override
int get hashCode => Object.hash(runtimeType,primary,status,neutral,surface);

@override
String toString() {
  return 'ColorTokens(primary: $primary, status: $status, neutral: $neutral, surface: $surface)';
}


}

/// @nodoc
abstract mixin class _$ColorTokensCopyWith<$Res> implements $ColorTokensCopyWith<$Res> {
  factory _$ColorTokensCopyWith(_ColorTokens value, $Res Function(_ColorTokens) _then) = __$ColorTokensCopyWithImpl;
@override @useResult
$Res call({
 PrimaryColors primary, StatusColors status, NeutralColors neutral, SurfaceColors surface
});


@override $PrimaryColorsCopyWith<$Res> get primary;@override $StatusColorsCopyWith<$Res> get status;@override $NeutralColorsCopyWith<$Res> get neutral;@override $SurfaceColorsCopyWith<$Res> get surface;

}
/// @nodoc
class __$ColorTokensCopyWithImpl<$Res>
    implements _$ColorTokensCopyWith<$Res> {
  __$ColorTokensCopyWithImpl(this._self, this._then);

  final _ColorTokens _self;
  final $Res Function(_ColorTokens) _then;

/// Create a copy of ColorTokens
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? primary = null,Object? status = null,Object? neutral = null,Object? surface = null,}) {
  return _then(_ColorTokens(
primary: null == primary ? _self.primary : primary // ignore: cast_nullable_to_non_nullable
as PrimaryColors,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StatusColors,neutral: null == neutral ? _self.neutral : neutral // ignore: cast_nullable_to_non_nullable
as NeutralColors,surface: null == surface ? _self.surface : surface // ignore: cast_nullable_to_non_nullable
as SurfaceColors,
  ));
}

/// Create a copy of ColorTokens
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PrimaryColorsCopyWith<$Res> get primary {
  
  return $PrimaryColorsCopyWith<$Res>(_self.primary, (value) {
    return _then(_self.copyWith(primary: value));
  });
}/// Create a copy of ColorTokens
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatusColorsCopyWith<$Res> get status {
  
  return $StatusColorsCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of ColorTokens
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NeutralColorsCopyWith<$Res> get neutral {
  
  return $NeutralColorsCopyWith<$Res>(_self.neutral, (value) {
    return _then(_self.copyWith(neutral: value));
  });
}/// Create a copy of ColorTokens
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SurfaceColorsCopyWith<$Res> get surface {
  
  return $SurfaceColorsCopyWith<$Res>(_self.surface, (value) {
    return _then(_self.copyWith(surface: value));
  });
}
}

/// @nodoc
mixin _$PrimaryColors {

/// メインプライマリカラー（#B1BCD9 ベース）
 Color get primary;/// プライマリカラーのバリエーション
 Color get primary50; Color get primary100; Color get primary200; Color get primary300; Color get primary400; Color get primary500; Color get primary600; Color get primary700; Color get primary800; Color get primary900;/// プライマリカラーのオンカラー
 Color get onPrimary; Color get onPrimaryContainer;/// プライマリコンテナ
 Color get primaryContainer;
/// Create a copy of PrimaryColors
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrimaryColorsCopyWith<PrimaryColors> get copyWith => _$PrimaryColorsCopyWithImpl<PrimaryColors>(this as PrimaryColors, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrimaryColors&&(identical(other.primary, primary) || other.primary == primary)&&(identical(other.primary50, primary50) || other.primary50 == primary50)&&(identical(other.primary100, primary100) || other.primary100 == primary100)&&(identical(other.primary200, primary200) || other.primary200 == primary200)&&(identical(other.primary300, primary300) || other.primary300 == primary300)&&(identical(other.primary400, primary400) || other.primary400 == primary400)&&(identical(other.primary500, primary500) || other.primary500 == primary500)&&(identical(other.primary600, primary600) || other.primary600 == primary600)&&(identical(other.primary700, primary700) || other.primary700 == primary700)&&(identical(other.primary800, primary800) || other.primary800 == primary800)&&(identical(other.primary900, primary900) || other.primary900 == primary900)&&(identical(other.onPrimary, onPrimary) || other.onPrimary == onPrimary)&&(identical(other.onPrimaryContainer, onPrimaryContainer) || other.onPrimaryContainer == onPrimaryContainer)&&(identical(other.primaryContainer, primaryContainer) || other.primaryContainer == primaryContainer));
}


@override
int get hashCode => Object.hash(runtimeType,primary,primary50,primary100,primary200,primary300,primary400,primary500,primary600,primary700,primary800,primary900,onPrimary,onPrimaryContainer,primaryContainer);

@override
String toString() {
  return 'PrimaryColors(primary: $primary, primary50: $primary50, primary100: $primary100, primary200: $primary200, primary300: $primary300, primary400: $primary400, primary500: $primary500, primary600: $primary600, primary700: $primary700, primary800: $primary800, primary900: $primary900, onPrimary: $onPrimary, onPrimaryContainer: $onPrimaryContainer, primaryContainer: $primaryContainer)';
}


}

/// @nodoc
abstract mixin class $PrimaryColorsCopyWith<$Res>  {
  factory $PrimaryColorsCopyWith(PrimaryColors value, $Res Function(PrimaryColors) _then) = _$PrimaryColorsCopyWithImpl;
@useResult
$Res call({
 Color primary, Color primary50, Color primary100, Color primary200, Color primary300, Color primary400, Color primary500, Color primary600, Color primary700, Color primary800, Color primary900, Color onPrimary, Color onPrimaryContainer, Color primaryContainer
});




}
/// @nodoc
class _$PrimaryColorsCopyWithImpl<$Res>
    implements $PrimaryColorsCopyWith<$Res> {
  _$PrimaryColorsCopyWithImpl(this._self, this._then);

  final PrimaryColors _self;
  final $Res Function(PrimaryColors) _then;

/// Create a copy of PrimaryColors
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? primary = null,Object? primary50 = null,Object? primary100 = null,Object? primary200 = null,Object? primary300 = null,Object? primary400 = null,Object? primary500 = null,Object? primary600 = null,Object? primary700 = null,Object? primary800 = null,Object? primary900 = null,Object? onPrimary = null,Object? onPrimaryContainer = null,Object? primaryContainer = null,}) {
  return _then(_self.copyWith(
primary: null == primary ? _self.primary : primary // ignore: cast_nullable_to_non_nullable
as Color,primary50: null == primary50 ? _self.primary50 : primary50 // ignore: cast_nullable_to_non_nullable
as Color,primary100: null == primary100 ? _self.primary100 : primary100 // ignore: cast_nullable_to_non_nullable
as Color,primary200: null == primary200 ? _self.primary200 : primary200 // ignore: cast_nullable_to_non_nullable
as Color,primary300: null == primary300 ? _self.primary300 : primary300 // ignore: cast_nullable_to_non_nullable
as Color,primary400: null == primary400 ? _self.primary400 : primary400 // ignore: cast_nullable_to_non_nullable
as Color,primary500: null == primary500 ? _self.primary500 : primary500 // ignore: cast_nullable_to_non_nullable
as Color,primary600: null == primary600 ? _self.primary600 : primary600 // ignore: cast_nullable_to_non_nullable
as Color,primary700: null == primary700 ? _self.primary700 : primary700 // ignore: cast_nullable_to_non_nullable
as Color,primary800: null == primary800 ? _self.primary800 : primary800 // ignore: cast_nullable_to_non_nullable
as Color,primary900: null == primary900 ? _self.primary900 : primary900 // ignore: cast_nullable_to_non_nullable
as Color,onPrimary: null == onPrimary ? _self.onPrimary : onPrimary // ignore: cast_nullable_to_non_nullable
as Color,onPrimaryContainer: null == onPrimaryContainer ? _self.onPrimaryContainer : onPrimaryContainer // ignore: cast_nullable_to_non_nullable
as Color,primaryContainer: null == primaryContainer ? _self.primaryContainer : primaryContainer // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}

}


/// Adds pattern-matching-related methods to [PrimaryColors].
extension PrimaryColorsPatterns on PrimaryColors {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrimaryColors value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrimaryColors() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrimaryColors value)  $default,){
final _that = this;
switch (_that) {
case _PrimaryColors():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrimaryColors value)?  $default,){
final _that = this;
switch (_that) {
case _PrimaryColors() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Color primary,  Color primary50,  Color primary100,  Color primary200,  Color primary300,  Color primary400,  Color primary500,  Color primary600,  Color primary700,  Color primary800,  Color primary900,  Color onPrimary,  Color onPrimaryContainer,  Color primaryContainer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrimaryColors() when $default != null:
return $default(_that.primary,_that.primary50,_that.primary100,_that.primary200,_that.primary300,_that.primary400,_that.primary500,_that.primary600,_that.primary700,_that.primary800,_that.primary900,_that.onPrimary,_that.onPrimaryContainer,_that.primaryContainer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Color primary,  Color primary50,  Color primary100,  Color primary200,  Color primary300,  Color primary400,  Color primary500,  Color primary600,  Color primary700,  Color primary800,  Color primary900,  Color onPrimary,  Color onPrimaryContainer,  Color primaryContainer)  $default,) {final _that = this;
switch (_that) {
case _PrimaryColors():
return $default(_that.primary,_that.primary50,_that.primary100,_that.primary200,_that.primary300,_that.primary400,_that.primary500,_that.primary600,_that.primary700,_that.primary800,_that.primary900,_that.onPrimary,_that.onPrimaryContainer,_that.primaryContainer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Color primary,  Color primary50,  Color primary100,  Color primary200,  Color primary300,  Color primary400,  Color primary500,  Color primary600,  Color primary700,  Color primary800,  Color primary900,  Color onPrimary,  Color onPrimaryContainer,  Color primaryContainer)?  $default,) {final _that = this;
switch (_that) {
case _PrimaryColors() when $default != null:
return $default(_that.primary,_that.primary50,_that.primary100,_that.primary200,_that.primary300,_that.primary400,_that.primary500,_that.primary600,_that.primary700,_that.primary800,_that.primary900,_that.onPrimary,_that.onPrimaryContainer,_that.primaryContainer);case _:
  return null;

}
}

}

/// @nodoc


class _PrimaryColors implements PrimaryColors {
  const _PrimaryColors({required this.primary, required this.primary50, required this.primary100, required this.primary200, required this.primary300, required this.primary400, required this.primary500, required this.primary600, required this.primary700, required this.primary800, required this.primary900, required this.onPrimary, required this.onPrimaryContainer, required this.primaryContainer});
  

/// メインプライマリカラー（#B1BCD9 ベース）
@override final  Color primary;
/// プライマリカラーのバリエーション
@override final  Color primary50;
@override final  Color primary100;
@override final  Color primary200;
@override final  Color primary300;
@override final  Color primary400;
@override final  Color primary500;
@override final  Color primary600;
@override final  Color primary700;
@override final  Color primary800;
@override final  Color primary900;
/// プライマリカラーのオンカラー
@override final  Color onPrimary;
@override final  Color onPrimaryContainer;
/// プライマリコンテナ
@override final  Color primaryContainer;

/// Create a copy of PrimaryColors
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrimaryColorsCopyWith<_PrimaryColors> get copyWith => __$PrimaryColorsCopyWithImpl<_PrimaryColors>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrimaryColors&&(identical(other.primary, primary) || other.primary == primary)&&(identical(other.primary50, primary50) || other.primary50 == primary50)&&(identical(other.primary100, primary100) || other.primary100 == primary100)&&(identical(other.primary200, primary200) || other.primary200 == primary200)&&(identical(other.primary300, primary300) || other.primary300 == primary300)&&(identical(other.primary400, primary400) || other.primary400 == primary400)&&(identical(other.primary500, primary500) || other.primary500 == primary500)&&(identical(other.primary600, primary600) || other.primary600 == primary600)&&(identical(other.primary700, primary700) || other.primary700 == primary700)&&(identical(other.primary800, primary800) || other.primary800 == primary800)&&(identical(other.primary900, primary900) || other.primary900 == primary900)&&(identical(other.onPrimary, onPrimary) || other.onPrimary == onPrimary)&&(identical(other.onPrimaryContainer, onPrimaryContainer) || other.onPrimaryContainer == onPrimaryContainer)&&(identical(other.primaryContainer, primaryContainer) || other.primaryContainer == primaryContainer));
}


@override
int get hashCode => Object.hash(runtimeType,primary,primary50,primary100,primary200,primary300,primary400,primary500,primary600,primary700,primary800,primary900,onPrimary,onPrimaryContainer,primaryContainer);

@override
String toString() {
  return 'PrimaryColors(primary: $primary, primary50: $primary50, primary100: $primary100, primary200: $primary200, primary300: $primary300, primary400: $primary400, primary500: $primary500, primary600: $primary600, primary700: $primary700, primary800: $primary800, primary900: $primary900, onPrimary: $onPrimary, onPrimaryContainer: $onPrimaryContainer, primaryContainer: $primaryContainer)';
}


}

/// @nodoc
abstract mixin class _$PrimaryColorsCopyWith<$Res> implements $PrimaryColorsCopyWith<$Res> {
  factory _$PrimaryColorsCopyWith(_PrimaryColors value, $Res Function(_PrimaryColors) _then) = __$PrimaryColorsCopyWithImpl;
@override @useResult
$Res call({
 Color primary, Color primary50, Color primary100, Color primary200, Color primary300, Color primary400, Color primary500, Color primary600, Color primary700, Color primary800, Color primary900, Color onPrimary, Color onPrimaryContainer, Color primaryContainer
});




}
/// @nodoc
class __$PrimaryColorsCopyWithImpl<$Res>
    implements _$PrimaryColorsCopyWith<$Res> {
  __$PrimaryColorsCopyWithImpl(this._self, this._then);

  final _PrimaryColors _self;
  final $Res Function(_PrimaryColors) _then;

/// Create a copy of PrimaryColors
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? primary = null,Object? primary50 = null,Object? primary100 = null,Object? primary200 = null,Object? primary300 = null,Object? primary400 = null,Object? primary500 = null,Object? primary600 = null,Object? primary700 = null,Object? primary800 = null,Object? primary900 = null,Object? onPrimary = null,Object? onPrimaryContainer = null,Object? primaryContainer = null,}) {
  return _then(_PrimaryColors(
primary: null == primary ? _self.primary : primary // ignore: cast_nullable_to_non_nullable
as Color,primary50: null == primary50 ? _self.primary50 : primary50 // ignore: cast_nullable_to_non_nullable
as Color,primary100: null == primary100 ? _self.primary100 : primary100 // ignore: cast_nullable_to_non_nullable
as Color,primary200: null == primary200 ? _self.primary200 : primary200 // ignore: cast_nullable_to_non_nullable
as Color,primary300: null == primary300 ? _self.primary300 : primary300 // ignore: cast_nullable_to_non_nullable
as Color,primary400: null == primary400 ? _self.primary400 : primary400 // ignore: cast_nullable_to_non_nullable
as Color,primary500: null == primary500 ? _self.primary500 : primary500 // ignore: cast_nullable_to_non_nullable
as Color,primary600: null == primary600 ? _self.primary600 : primary600 // ignore: cast_nullable_to_non_nullable
as Color,primary700: null == primary700 ? _self.primary700 : primary700 // ignore: cast_nullable_to_non_nullable
as Color,primary800: null == primary800 ? _self.primary800 : primary800 // ignore: cast_nullable_to_non_nullable
as Color,primary900: null == primary900 ? _self.primary900 : primary900 // ignore: cast_nullable_to_non_nullable
as Color,onPrimary: null == onPrimary ? _self.onPrimary : onPrimary // ignore: cast_nullable_to_non_nullable
as Color,onPrimaryContainer: null == onPrimaryContainer ? _self.onPrimaryContainer : onPrimaryContainer // ignore: cast_nullable_to_non_nullable
as Color,primaryContainer: null == primaryContainer ? _self.primaryContainer : primaryContainer // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}


}

/// @nodoc
mixin _$StatusColors {

/// 成功状態
 Color get success; Color get onSuccess; Color get successContainer; Color get onSuccessContainer;/// 警告状態
 Color get warning; Color get onWarning; Color get warningContainer; Color get onWarningContainer;/// エラー状態
 Color get error; Color get onError; Color get errorContainer; Color get onErrorContainer;/// 情報状態
 Color get info; Color get onInfo; Color get infoContainer; Color get onInfoContainer;
/// Create a copy of StatusColors
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatusColorsCopyWith<StatusColors> get copyWith => _$StatusColorsCopyWithImpl<StatusColors>(this as StatusColors, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatusColors&&(identical(other.success, success) || other.success == success)&&(identical(other.onSuccess, onSuccess) || other.onSuccess == onSuccess)&&(identical(other.successContainer, successContainer) || other.successContainer == successContainer)&&(identical(other.onSuccessContainer, onSuccessContainer) || other.onSuccessContainer == onSuccessContainer)&&(identical(other.warning, warning) || other.warning == warning)&&(identical(other.onWarning, onWarning) || other.onWarning == onWarning)&&(identical(other.warningContainer, warningContainer) || other.warningContainer == warningContainer)&&(identical(other.onWarningContainer, onWarningContainer) || other.onWarningContainer == onWarningContainer)&&(identical(other.error, error) || other.error == error)&&(identical(other.onError, onError) || other.onError == onError)&&(identical(other.errorContainer, errorContainer) || other.errorContainer == errorContainer)&&(identical(other.onErrorContainer, onErrorContainer) || other.onErrorContainer == onErrorContainer)&&(identical(other.info, info) || other.info == info)&&(identical(other.onInfo, onInfo) || other.onInfo == onInfo)&&(identical(other.infoContainer, infoContainer) || other.infoContainer == infoContainer)&&(identical(other.onInfoContainer, onInfoContainer) || other.onInfoContainer == onInfoContainer));
}


@override
int get hashCode => Object.hash(runtimeType,success,onSuccess,successContainer,onSuccessContainer,warning,onWarning,warningContainer,onWarningContainer,error,onError,errorContainer,onErrorContainer,info,onInfo,infoContainer,onInfoContainer);

@override
String toString() {
  return 'StatusColors(success: $success, onSuccess: $onSuccess, successContainer: $successContainer, onSuccessContainer: $onSuccessContainer, warning: $warning, onWarning: $onWarning, warningContainer: $warningContainer, onWarningContainer: $onWarningContainer, error: $error, onError: $onError, errorContainer: $errorContainer, onErrorContainer: $onErrorContainer, info: $info, onInfo: $onInfo, infoContainer: $infoContainer, onInfoContainer: $onInfoContainer)';
}


}

/// @nodoc
abstract mixin class $StatusColorsCopyWith<$Res>  {
  factory $StatusColorsCopyWith(StatusColors value, $Res Function(StatusColors) _then) = _$StatusColorsCopyWithImpl;
@useResult
$Res call({
 Color success, Color onSuccess, Color successContainer, Color onSuccessContainer, Color warning, Color onWarning, Color warningContainer, Color onWarningContainer, Color error, Color onError, Color errorContainer, Color onErrorContainer, Color info, Color onInfo, Color infoContainer, Color onInfoContainer
});




}
/// @nodoc
class _$StatusColorsCopyWithImpl<$Res>
    implements $StatusColorsCopyWith<$Res> {
  _$StatusColorsCopyWithImpl(this._self, this._then);

  final StatusColors _self;
  final $Res Function(StatusColors) _then;

/// Create a copy of StatusColors
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? onSuccess = null,Object? successContainer = null,Object? onSuccessContainer = null,Object? warning = null,Object? onWarning = null,Object? warningContainer = null,Object? onWarningContainer = null,Object? error = null,Object? onError = null,Object? errorContainer = null,Object? onErrorContainer = null,Object? info = null,Object? onInfo = null,Object? infoContainer = null,Object? onInfoContainer = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as Color,onSuccess: null == onSuccess ? _self.onSuccess : onSuccess // ignore: cast_nullable_to_non_nullable
as Color,successContainer: null == successContainer ? _self.successContainer : successContainer // ignore: cast_nullable_to_non_nullable
as Color,onSuccessContainer: null == onSuccessContainer ? _self.onSuccessContainer : onSuccessContainer // ignore: cast_nullable_to_non_nullable
as Color,warning: null == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as Color,onWarning: null == onWarning ? _self.onWarning : onWarning // ignore: cast_nullable_to_non_nullable
as Color,warningContainer: null == warningContainer ? _self.warningContainer : warningContainer // ignore: cast_nullable_to_non_nullable
as Color,onWarningContainer: null == onWarningContainer ? _self.onWarningContainer : onWarningContainer // ignore: cast_nullable_to_non_nullable
as Color,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as Color,onError: null == onError ? _self.onError : onError // ignore: cast_nullable_to_non_nullable
as Color,errorContainer: null == errorContainer ? _self.errorContainer : errorContainer // ignore: cast_nullable_to_non_nullable
as Color,onErrorContainer: null == onErrorContainer ? _self.onErrorContainer : onErrorContainer // ignore: cast_nullable_to_non_nullable
as Color,info: null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as Color,onInfo: null == onInfo ? _self.onInfo : onInfo // ignore: cast_nullable_to_non_nullable
as Color,infoContainer: null == infoContainer ? _self.infoContainer : infoContainer // ignore: cast_nullable_to_non_nullable
as Color,onInfoContainer: null == onInfoContainer ? _self.onInfoContainer : onInfoContainer // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}

}


/// Adds pattern-matching-related methods to [StatusColors].
extension StatusColorsPatterns on StatusColors {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StatusColors value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatusColors() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StatusColors value)  $default,){
final _that = this;
switch (_that) {
case _StatusColors():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StatusColors value)?  $default,){
final _that = this;
switch (_that) {
case _StatusColors() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Color success,  Color onSuccess,  Color successContainer,  Color onSuccessContainer,  Color warning,  Color onWarning,  Color warningContainer,  Color onWarningContainer,  Color error,  Color onError,  Color errorContainer,  Color onErrorContainer,  Color info,  Color onInfo,  Color infoContainer,  Color onInfoContainer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StatusColors() when $default != null:
return $default(_that.success,_that.onSuccess,_that.successContainer,_that.onSuccessContainer,_that.warning,_that.onWarning,_that.warningContainer,_that.onWarningContainer,_that.error,_that.onError,_that.errorContainer,_that.onErrorContainer,_that.info,_that.onInfo,_that.infoContainer,_that.onInfoContainer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Color success,  Color onSuccess,  Color successContainer,  Color onSuccessContainer,  Color warning,  Color onWarning,  Color warningContainer,  Color onWarningContainer,  Color error,  Color onError,  Color errorContainer,  Color onErrorContainer,  Color info,  Color onInfo,  Color infoContainer,  Color onInfoContainer)  $default,) {final _that = this;
switch (_that) {
case _StatusColors():
return $default(_that.success,_that.onSuccess,_that.successContainer,_that.onSuccessContainer,_that.warning,_that.onWarning,_that.warningContainer,_that.onWarningContainer,_that.error,_that.onError,_that.errorContainer,_that.onErrorContainer,_that.info,_that.onInfo,_that.infoContainer,_that.onInfoContainer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Color success,  Color onSuccess,  Color successContainer,  Color onSuccessContainer,  Color warning,  Color onWarning,  Color warningContainer,  Color onWarningContainer,  Color error,  Color onError,  Color errorContainer,  Color onErrorContainer,  Color info,  Color onInfo,  Color infoContainer,  Color onInfoContainer)?  $default,) {final _that = this;
switch (_that) {
case _StatusColors() when $default != null:
return $default(_that.success,_that.onSuccess,_that.successContainer,_that.onSuccessContainer,_that.warning,_that.onWarning,_that.warningContainer,_that.onWarningContainer,_that.error,_that.onError,_that.errorContainer,_that.onErrorContainer,_that.info,_that.onInfo,_that.infoContainer,_that.onInfoContainer);case _:
  return null;

}
}

}

/// @nodoc


class _StatusColors implements StatusColors {
  const _StatusColors({required this.success, required this.onSuccess, required this.successContainer, required this.onSuccessContainer, required this.warning, required this.onWarning, required this.warningContainer, required this.onWarningContainer, required this.error, required this.onError, required this.errorContainer, required this.onErrorContainer, required this.info, required this.onInfo, required this.infoContainer, required this.onInfoContainer});
  

/// 成功状態
@override final  Color success;
@override final  Color onSuccess;
@override final  Color successContainer;
@override final  Color onSuccessContainer;
/// 警告状態
@override final  Color warning;
@override final  Color onWarning;
@override final  Color warningContainer;
@override final  Color onWarningContainer;
/// エラー状態
@override final  Color error;
@override final  Color onError;
@override final  Color errorContainer;
@override final  Color onErrorContainer;
/// 情報状態
@override final  Color info;
@override final  Color onInfo;
@override final  Color infoContainer;
@override final  Color onInfoContainer;

/// Create a copy of StatusColors
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatusColorsCopyWith<_StatusColors> get copyWith => __$StatusColorsCopyWithImpl<_StatusColors>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatusColors&&(identical(other.success, success) || other.success == success)&&(identical(other.onSuccess, onSuccess) || other.onSuccess == onSuccess)&&(identical(other.successContainer, successContainer) || other.successContainer == successContainer)&&(identical(other.onSuccessContainer, onSuccessContainer) || other.onSuccessContainer == onSuccessContainer)&&(identical(other.warning, warning) || other.warning == warning)&&(identical(other.onWarning, onWarning) || other.onWarning == onWarning)&&(identical(other.warningContainer, warningContainer) || other.warningContainer == warningContainer)&&(identical(other.onWarningContainer, onWarningContainer) || other.onWarningContainer == onWarningContainer)&&(identical(other.error, error) || other.error == error)&&(identical(other.onError, onError) || other.onError == onError)&&(identical(other.errorContainer, errorContainer) || other.errorContainer == errorContainer)&&(identical(other.onErrorContainer, onErrorContainer) || other.onErrorContainer == onErrorContainer)&&(identical(other.info, info) || other.info == info)&&(identical(other.onInfo, onInfo) || other.onInfo == onInfo)&&(identical(other.infoContainer, infoContainer) || other.infoContainer == infoContainer)&&(identical(other.onInfoContainer, onInfoContainer) || other.onInfoContainer == onInfoContainer));
}


@override
int get hashCode => Object.hash(runtimeType,success,onSuccess,successContainer,onSuccessContainer,warning,onWarning,warningContainer,onWarningContainer,error,onError,errorContainer,onErrorContainer,info,onInfo,infoContainer,onInfoContainer);

@override
String toString() {
  return 'StatusColors(success: $success, onSuccess: $onSuccess, successContainer: $successContainer, onSuccessContainer: $onSuccessContainer, warning: $warning, onWarning: $onWarning, warningContainer: $warningContainer, onWarningContainer: $onWarningContainer, error: $error, onError: $onError, errorContainer: $errorContainer, onErrorContainer: $onErrorContainer, info: $info, onInfo: $onInfo, infoContainer: $infoContainer, onInfoContainer: $onInfoContainer)';
}


}

/// @nodoc
abstract mixin class _$StatusColorsCopyWith<$Res> implements $StatusColorsCopyWith<$Res> {
  factory _$StatusColorsCopyWith(_StatusColors value, $Res Function(_StatusColors) _then) = __$StatusColorsCopyWithImpl;
@override @useResult
$Res call({
 Color success, Color onSuccess, Color successContainer, Color onSuccessContainer, Color warning, Color onWarning, Color warningContainer, Color onWarningContainer, Color error, Color onError, Color errorContainer, Color onErrorContainer, Color info, Color onInfo, Color infoContainer, Color onInfoContainer
});




}
/// @nodoc
class __$StatusColorsCopyWithImpl<$Res>
    implements _$StatusColorsCopyWith<$Res> {
  __$StatusColorsCopyWithImpl(this._self, this._then);

  final _StatusColors _self;
  final $Res Function(_StatusColors) _then;

/// Create a copy of StatusColors
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? onSuccess = null,Object? successContainer = null,Object? onSuccessContainer = null,Object? warning = null,Object? onWarning = null,Object? warningContainer = null,Object? onWarningContainer = null,Object? error = null,Object? onError = null,Object? errorContainer = null,Object? onErrorContainer = null,Object? info = null,Object? onInfo = null,Object? infoContainer = null,Object? onInfoContainer = null,}) {
  return _then(_StatusColors(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as Color,onSuccess: null == onSuccess ? _self.onSuccess : onSuccess // ignore: cast_nullable_to_non_nullable
as Color,successContainer: null == successContainer ? _self.successContainer : successContainer // ignore: cast_nullable_to_non_nullable
as Color,onSuccessContainer: null == onSuccessContainer ? _self.onSuccessContainer : onSuccessContainer // ignore: cast_nullable_to_non_nullable
as Color,warning: null == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as Color,onWarning: null == onWarning ? _self.onWarning : onWarning // ignore: cast_nullable_to_non_nullable
as Color,warningContainer: null == warningContainer ? _self.warningContainer : warningContainer // ignore: cast_nullable_to_non_nullable
as Color,onWarningContainer: null == onWarningContainer ? _self.onWarningContainer : onWarningContainer // ignore: cast_nullable_to_non_nullable
as Color,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as Color,onError: null == onError ? _self.onError : onError // ignore: cast_nullable_to_non_nullable
as Color,errorContainer: null == errorContainer ? _self.errorContainer : errorContainer // ignore: cast_nullable_to_non_nullable
as Color,onErrorContainer: null == onErrorContainer ? _self.onErrorContainer : onErrorContainer // ignore: cast_nullable_to_non_nullable
as Color,info: null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as Color,onInfo: null == onInfo ? _self.onInfo : onInfo // ignore: cast_nullable_to_non_nullable
as Color,infoContainer: null == infoContainer ? _self.infoContainer : infoContainer // ignore: cast_nullable_to_non_nullable
as Color,onInfoContainer: null == onInfoContainer ? _self.onInfoContainer : onInfoContainer // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}


}

/// @nodoc
mixin _$NeutralColors {

/// ニュートラルカラー段階
 Color get neutral0;// 純白/純黒
 Color get neutral10; Color get neutral20; Color get neutral30; Color get neutral40; Color get neutral50; Color get neutral60; Color get neutral70; Color get neutral80; Color get neutral90; Color get neutral95; Color get neutral99; Color get neutral100;// 純黒/純白
/// アウトライン用
 Color get outline; Color get outlineVariant;
/// Create a copy of NeutralColors
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NeutralColorsCopyWith<NeutralColors> get copyWith => _$NeutralColorsCopyWithImpl<NeutralColors>(this as NeutralColors, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NeutralColors&&(identical(other.neutral0, neutral0) || other.neutral0 == neutral0)&&(identical(other.neutral10, neutral10) || other.neutral10 == neutral10)&&(identical(other.neutral20, neutral20) || other.neutral20 == neutral20)&&(identical(other.neutral30, neutral30) || other.neutral30 == neutral30)&&(identical(other.neutral40, neutral40) || other.neutral40 == neutral40)&&(identical(other.neutral50, neutral50) || other.neutral50 == neutral50)&&(identical(other.neutral60, neutral60) || other.neutral60 == neutral60)&&(identical(other.neutral70, neutral70) || other.neutral70 == neutral70)&&(identical(other.neutral80, neutral80) || other.neutral80 == neutral80)&&(identical(other.neutral90, neutral90) || other.neutral90 == neutral90)&&(identical(other.neutral95, neutral95) || other.neutral95 == neutral95)&&(identical(other.neutral99, neutral99) || other.neutral99 == neutral99)&&(identical(other.neutral100, neutral100) || other.neutral100 == neutral100)&&(identical(other.outline, outline) || other.outline == outline)&&(identical(other.outlineVariant, outlineVariant) || other.outlineVariant == outlineVariant));
}


@override
int get hashCode => Object.hash(runtimeType,neutral0,neutral10,neutral20,neutral30,neutral40,neutral50,neutral60,neutral70,neutral80,neutral90,neutral95,neutral99,neutral100,outline,outlineVariant);

@override
String toString() {
  return 'NeutralColors(neutral0: $neutral0, neutral10: $neutral10, neutral20: $neutral20, neutral30: $neutral30, neutral40: $neutral40, neutral50: $neutral50, neutral60: $neutral60, neutral70: $neutral70, neutral80: $neutral80, neutral90: $neutral90, neutral95: $neutral95, neutral99: $neutral99, neutral100: $neutral100, outline: $outline, outlineVariant: $outlineVariant)';
}


}

/// @nodoc
abstract mixin class $NeutralColorsCopyWith<$Res>  {
  factory $NeutralColorsCopyWith(NeutralColors value, $Res Function(NeutralColors) _then) = _$NeutralColorsCopyWithImpl;
@useResult
$Res call({
 Color neutral0, Color neutral10, Color neutral20, Color neutral30, Color neutral40, Color neutral50, Color neutral60, Color neutral70, Color neutral80, Color neutral90, Color neutral95, Color neutral99, Color neutral100, Color outline, Color outlineVariant
});




}
/// @nodoc
class _$NeutralColorsCopyWithImpl<$Res>
    implements $NeutralColorsCopyWith<$Res> {
  _$NeutralColorsCopyWithImpl(this._self, this._then);

  final NeutralColors _self;
  final $Res Function(NeutralColors) _then;

/// Create a copy of NeutralColors
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? neutral0 = null,Object? neutral10 = null,Object? neutral20 = null,Object? neutral30 = null,Object? neutral40 = null,Object? neutral50 = null,Object? neutral60 = null,Object? neutral70 = null,Object? neutral80 = null,Object? neutral90 = null,Object? neutral95 = null,Object? neutral99 = null,Object? neutral100 = null,Object? outline = null,Object? outlineVariant = null,}) {
  return _then(_self.copyWith(
neutral0: null == neutral0 ? _self.neutral0 : neutral0 // ignore: cast_nullable_to_non_nullable
as Color,neutral10: null == neutral10 ? _self.neutral10 : neutral10 // ignore: cast_nullable_to_non_nullable
as Color,neutral20: null == neutral20 ? _self.neutral20 : neutral20 // ignore: cast_nullable_to_non_nullable
as Color,neutral30: null == neutral30 ? _self.neutral30 : neutral30 // ignore: cast_nullable_to_non_nullable
as Color,neutral40: null == neutral40 ? _self.neutral40 : neutral40 // ignore: cast_nullable_to_non_nullable
as Color,neutral50: null == neutral50 ? _self.neutral50 : neutral50 // ignore: cast_nullable_to_non_nullable
as Color,neutral60: null == neutral60 ? _self.neutral60 : neutral60 // ignore: cast_nullable_to_non_nullable
as Color,neutral70: null == neutral70 ? _self.neutral70 : neutral70 // ignore: cast_nullable_to_non_nullable
as Color,neutral80: null == neutral80 ? _self.neutral80 : neutral80 // ignore: cast_nullable_to_non_nullable
as Color,neutral90: null == neutral90 ? _self.neutral90 : neutral90 // ignore: cast_nullable_to_non_nullable
as Color,neutral95: null == neutral95 ? _self.neutral95 : neutral95 // ignore: cast_nullable_to_non_nullable
as Color,neutral99: null == neutral99 ? _self.neutral99 : neutral99 // ignore: cast_nullable_to_non_nullable
as Color,neutral100: null == neutral100 ? _self.neutral100 : neutral100 // ignore: cast_nullable_to_non_nullable
as Color,outline: null == outline ? _self.outline : outline // ignore: cast_nullable_to_non_nullable
as Color,outlineVariant: null == outlineVariant ? _self.outlineVariant : outlineVariant // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}

}


/// Adds pattern-matching-related methods to [NeutralColors].
extension NeutralColorsPatterns on NeutralColors {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NeutralColors value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NeutralColors() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NeutralColors value)  $default,){
final _that = this;
switch (_that) {
case _NeutralColors():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NeutralColors value)?  $default,){
final _that = this;
switch (_that) {
case _NeutralColors() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Color neutral0,  Color neutral10,  Color neutral20,  Color neutral30,  Color neutral40,  Color neutral50,  Color neutral60,  Color neutral70,  Color neutral80,  Color neutral90,  Color neutral95,  Color neutral99,  Color neutral100,  Color outline,  Color outlineVariant)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NeutralColors() when $default != null:
return $default(_that.neutral0,_that.neutral10,_that.neutral20,_that.neutral30,_that.neutral40,_that.neutral50,_that.neutral60,_that.neutral70,_that.neutral80,_that.neutral90,_that.neutral95,_that.neutral99,_that.neutral100,_that.outline,_that.outlineVariant);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Color neutral0,  Color neutral10,  Color neutral20,  Color neutral30,  Color neutral40,  Color neutral50,  Color neutral60,  Color neutral70,  Color neutral80,  Color neutral90,  Color neutral95,  Color neutral99,  Color neutral100,  Color outline,  Color outlineVariant)  $default,) {final _that = this;
switch (_that) {
case _NeutralColors():
return $default(_that.neutral0,_that.neutral10,_that.neutral20,_that.neutral30,_that.neutral40,_that.neutral50,_that.neutral60,_that.neutral70,_that.neutral80,_that.neutral90,_that.neutral95,_that.neutral99,_that.neutral100,_that.outline,_that.outlineVariant);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Color neutral0,  Color neutral10,  Color neutral20,  Color neutral30,  Color neutral40,  Color neutral50,  Color neutral60,  Color neutral70,  Color neutral80,  Color neutral90,  Color neutral95,  Color neutral99,  Color neutral100,  Color outline,  Color outlineVariant)?  $default,) {final _that = this;
switch (_that) {
case _NeutralColors() when $default != null:
return $default(_that.neutral0,_that.neutral10,_that.neutral20,_that.neutral30,_that.neutral40,_that.neutral50,_that.neutral60,_that.neutral70,_that.neutral80,_that.neutral90,_that.neutral95,_that.neutral99,_that.neutral100,_that.outline,_that.outlineVariant);case _:
  return null;

}
}

}

/// @nodoc


class _NeutralColors implements NeutralColors {
  const _NeutralColors({required this.neutral0, required this.neutral10, required this.neutral20, required this.neutral30, required this.neutral40, required this.neutral50, required this.neutral60, required this.neutral70, required this.neutral80, required this.neutral90, required this.neutral95, required this.neutral99, required this.neutral100, required this.outline, required this.outlineVariant});
  

/// ニュートラルカラー段階
@override final  Color neutral0;
// 純白/純黒
@override final  Color neutral10;
@override final  Color neutral20;
@override final  Color neutral30;
@override final  Color neutral40;
@override final  Color neutral50;
@override final  Color neutral60;
@override final  Color neutral70;
@override final  Color neutral80;
@override final  Color neutral90;
@override final  Color neutral95;
@override final  Color neutral99;
@override final  Color neutral100;
// 純黒/純白
/// アウトライン用
@override final  Color outline;
@override final  Color outlineVariant;

/// Create a copy of NeutralColors
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NeutralColorsCopyWith<_NeutralColors> get copyWith => __$NeutralColorsCopyWithImpl<_NeutralColors>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NeutralColors&&(identical(other.neutral0, neutral0) || other.neutral0 == neutral0)&&(identical(other.neutral10, neutral10) || other.neutral10 == neutral10)&&(identical(other.neutral20, neutral20) || other.neutral20 == neutral20)&&(identical(other.neutral30, neutral30) || other.neutral30 == neutral30)&&(identical(other.neutral40, neutral40) || other.neutral40 == neutral40)&&(identical(other.neutral50, neutral50) || other.neutral50 == neutral50)&&(identical(other.neutral60, neutral60) || other.neutral60 == neutral60)&&(identical(other.neutral70, neutral70) || other.neutral70 == neutral70)&&(identical(other.neutral80, neutral80) || other.neutral80 == neutral80)&&(identical(other.neutral90, neutral90) || other.neutral90 == neutral90)&&(identical(other.neutral95, neutral95) || other.neutral95 == neutral95)&&(identical(other.neutral99, neutral99) || other.neutral99 == neutral99)&&(identical(other.neutral100, neutral100) || other.neutral100 == neutral100)&&(identical(other.outline, outline) || other.outline == outline)&&(identical(other.outlineVariant, outlineVariant) || other.outlineVariant == outlineVariant));
}


@override
int get hashCode => Object.hash(runtimeType,neutral0,neutral10,neutral20,neutral30,neutral40,neutral50,neutral60,neutral70,neutral80,neutral90,neutral95,neutral99,neutral100,outline,outlineVariant);

@override
String toString() {
  return 'NeutralColors(neutral0: $neutral0, neutral10: $neutral10, neutral20: $neutral20, neutral30: $neutral30, neutral40: $neutral40, neutral50: $neutral50, neutral60: $neutral60, neutral70: $neutral70, neutral80: $neutral80, neutral90: $neutral90, neutral95: $neutral95, neutral99: $neutral99, neutral100: $neutral100, outline: $outline, outlineVariant: $outlineVariant)';
}


}

/// @nodoc
abstract mixin class _$NeutralColorsCopyWith<$Res> implements $NeutralColorsCopyWith<$Res> {
  factory _$NeutralColorsCopyWith(_NeutralColors value, $Res Function(_NeutralColors) _then) = __$NeutralColorsCopyWithImpl;
@override @useResult
$Res call({
 Color neutral0, Color neutral10, Color neutral20, Color neutral30, Color neutral40, Color neutral50, Color neutral60, Color neutral70, Color neutral80, Color neutral90, Color neutral95, Color neutral99, Color neutral100, Color outline, Color outlineVariant
});




}
/// @nodoc
class __$NeutralColorsCopyWithImpl<$Res>
    implements _$NeutralColorsCopyWith<$Res> {
  __$NeutralColorsCopyWithImpl(this._self, this._then);

  final _NeutralColors _self;
  final $Res Function(_NeutralColors) _then;

/// Create a copy of NeutralColors
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? neutral0 = null,Object? neutral10 = null,Object? neutral20 = null,Object? neutral30 = null,Object? neutral40 = null,Object? neutral50 = null,Object? neutral60 = null,Object? neutral70 = null,Object? neutral80 = null,Object? neutral90 = null,Object? neutral95 = null,Object? neutral99 = null,Object? neutral100 = null,Object? outline = null,Object? outlineVariant = null,}) {
  return _then(_NeutralColors(
neutral0: null == neutral0 ? _self.neutral0 : neutral0 // ignore: cast_nullable_to_non_nullable
as Color,neutral10: null == neutral10 ? _self.neutral10 : neutral10 // ignore: cast_nullable_to_non_nullable
as Color,neutral20: null == neutral20 ? _self.neutral20 : neutral20 // ignore: cast_nullable_to_non_nullable
as Color,neutral30: null == neutral30 ? _self.neutral30 : neutral30 // ignore: cast_nullable_to_non_nullable
as Color,neutral40: null == neutral40 ? _self.neutral40 : neutral40 // ignore: cast_nullable_to_non_nullable
as Color,neutral50: null == neutral50 ? _self.neutral50 : neutral50 // ignore: cast_nullable_to_non_nullable
as Color,neutral60: null == neutral60 ? _self.neutral60 : neutral60 // ignore: cast_nullable_to_non_nullable
as Color,neutral70: null == neutral70 ? _self.neutral70 : neutral70 // ignore: cast_nullable_to_non_nullable
as Color,neutral80: null == neutral80 ? _self.neutral80 : neutral80 // ignore: cast_nullable_to_non_nullable
as Color,neutral90: null == neutral90 ? _self.neutral90 : neutral90 // ignore: cast_nullable_to_non_nullable
as Color,neutral95: null == neutral95 ? _self.neutral95 : neutral95 // ignore: cast_nullable_to_non_nullable
as Color,neutral99: null == neutral99 ? _self.neutral99 : neutral99 // ignore: cast_nullable_to_non_nullable
as Color,neutral100: null == neutral100 ? _self.neutral100 : neutral100 // ignore: cast_nullable_to_non_nullable
as Color,outline: null == outline ? _self.outline : outline // ignore: cast_nullable_to_non_nullable
as Color,outlineVariant: null == outlineVariant ? _self.outlineVariant : outlineVariant // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}


}

/// @nodoc
mixin _$SurfaceColors {

/// 背景色
 Color get background; Color get onBackground;/// サーフェス色
 Color get surface; Color get onSurface; Color get surfaceVariant; Color get onSurfaceVariant;/// サーフェス段階
 Color get surfaceDim; Color get surfaceBright; Color get surfaceContainerLowest; Color get surfaceContainerLow; Color get surfaceContainer; Color get surfaceContainerHigh; Color get surfaceContainerHighest;/// インバースサーフェス
 Color get inverseSurface; Color get onInverseSurface; Color get inversePrimary;/// シャドウとスクリム
 Color get shadow; Color get scrim;
/// Create a copy of SurfaceColors
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurfaceColorsCopyWith<SurfaceColors> get copyWith => _$SurfaceColorsCopyWithImpl<SurfaceColors>(this as SurfaceColors, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SurfaceColors&&(identical(other.background, background) || other.background == background)&&(identical(other.onBackground, onBackground) || other.onBackground == onBackground)&&(identical(other.surface, surface) || other.surface == surface)&&(identical(other.onSurface, onSurface) || other.onSurface == onSurface)&&(identical(other.surfaceVariant, surfaceVariant) || other.surfaceVariant == surfaceVariant)&&(identical(other.onSurfaceVariant, onSurfaceVariant) || other.onSurfaceVariant == onSurfaceVariant)&&(identical(other.surfaceDim, surfaceDim) || other.surfaceDim == surfaceDim)&&(identical(other.surfaceBright, surfaceBright) || other.surfaceBright == surfaceBright)&&(identical(other.surfaceContainerLowest, surfaceContainerLowest) || other.surfaceContainerLowest == surfaceContainerLowest)&&(identical(other.surfaceContainerLow, surfaceContainerLow) || other.surfaceContainerLow == surfaceContainerLow)&&(identical(other.surfaceContainer, surfaceContainer) || other.surfaceContainer == surfaceContainer)&&(identical(other.surfaceContainerHigh, surfaceContainerHigh) || other.surfaceContainerHigh == surfaceContainerHigh)&&(identical(other.surfaceContainerHighest, surfaceContainerHighest) || other.surfaceContainerHighest == surfaceContainerHighest)&&(identical(other.inverseSurface, inverseSurface) || other.inverseSurface == inverseSurface)&&(identical(other.onInverseSurface, onInverseSurface) || other.onInverseSurface == onInverseSurface)&&(identical(other.inversePrimary, inversePrimary) || other.inversePrimary == inversePrimary)&&(identical(other.shadow, shadow) || other.shadow == shadow)&&(identical(other.scrim, scrim) || other.scrim == scrim));
}


@override
int get hashCode => Object.hash(runtimeType,background,onBackground,surface,onSurface,surfaceVariant,onSurfaceVariant,surfaceDim,surfaceBright,surfaceContainerLowest,surfaceContainerLow,surfaceContainer,surfaceContainerHigh,surfaceContainerHighest,inverseSurface,onInverseSurface,inversePrimary,shadow,scrim);

@override
String toString() {
  return 'SurfaceColors(background: $background, onBackground: $onBackground, surface: $surface, onSurface: $onSurface, surfaceVariant: $surfaceVariant, onSurfaceVariant: $onSurfaceVariant, surfaceDim: $surfaceDim, surfaceBright: $surfaceBright, surfaceContainerLowest: $surfaceContainerLowest, surfaceContainerLow: $surfaceContainerLow, surfaceContainer: $surfaceContainer, surfaceContainerHigh: $surfaceContainerHigh, surfaceContainerHighest: $surfaceContainerHighest, inverseSurface: $inverseSurface, onInverseSurface: $onInverseSurface, inversePrimary: $inversePrimary, shadow: $shadow, scrim: $scrim)';
}


}

/// @nodoc
abstract mixin class $SurfaceColorsCopyWith<$Res>  {
  factory $SurfaceColorsCopyWith(SurfaceColors value, $Res Function(SurfaceColors) _then) = _$SurfaceColorsCopyWithImpl;
@useResult
$Res call({
 Color background, Color onBackground, Color surface, Color onSurface, Color surfaceVariant, Color onSurfaceVariant, Color surfaceDim, Color surfaceBright, Color surfaceContainerLowest, Color surfaceContainerLow, Color surfaceContainer, Color surfaceContainerHigh, Color surfaceContainerHighest, Color inverseSurface, Color onInverseSurface, Color inversePrimary, Color shadow, Color scrim
});




}
/// @nodoc
class _$SurfaceColorsCopyWithImpl<$Res>
    implements $SurfaceColorsCopyWith<$Res> {
  _$SurfaceColorsCopyWithImpl(this._self, this._then);

  final SurfaceColors _self;
  final $Res Function(SurfaceColors) _then;

/// Create a copy of SurfaceColors
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? background = null,Object? onBackground = null,Object? surface = null,Object? onSurface = null,Object? surfaceVariant = null,Object? onSurfaceVariant = null,Object? surfaceDim = null,Object? surfaceBright = null,Object? surfaceContainerLowest = null,Object? surfaceContainerLow = null,Object? surfaceContainer = null,Object? surfaceContainerHigh = null,Object? surfaceContainerHighest = null,Object? inverseSurface = null,Object? onInverseSurface = null,Object? inversePrimary = null,Object? shadow = null,Object? scrim = null,}) {
  return _then(_self.copyWith(
background: null == background ? _self.background : background // ignore: cast_nullable_to_non_nullable
as Color,onBackground: null == onBackground ? _self.onBackground : onBackground // ignore: cast_nullable_to_non_nullable
as Color,surface: null == surface ? _self.surface : surface // ignore: cast_nullable_to_non_nullable
as Color,onSurface: null == onSurface ? _self.onSurface : onSurface // ignore: cast_nullable_to_non_nullable
as Color,surfaceVariant: null == surfaceVariant ? _self.surfaceVariant : surfaceVariant // ignore: cast_nullable_to_non_nullable
as Color,onSurfaceVariant: null == onSurfaceVariant ? _self.onSurfaceVariant : onSurfaceVariant // ignore: cast_nullable_to_non_nullable
as Color,surfaceDim: null == surfaceDim ? _self.surfaceDim : surfaceDim // ignore: cast_nullable_to_non_nullable
as Color,surfaceBright: null == surfaceBright ? _self.surfaceBright : surfaceBright // ignore: cast_nullable_to_non_nullable
as Color,surfaceContainerLowest: null == surfaceContainerLowest ? _self.surfaceContainerLowest : surfaceContainerLowest // ignore: cast_nullable_to_non_nullable
as Color,surfaceContainerLow: null == surfaceContainerLow ? _self.surfaceContainerLow : surfaceContainerLow // ignore: cast_nullable_to_non_nullable
as Color,surfaceContainer: null == surfaceContainer ? _self.surfaceContainer : surfaceContainer // ignore: cast_nullable_to_non_nullable
as Color,surfaceContainerHigh: null == surfaceContainerHigh ? _self.surfaceContainerHigh : surfaceContainerHigh // ignore: cast_nullable_to_non_nullable
as Color,surfaceContainerHighest: null == surfaceContainerHighest ? _self.surfaceContainerHighest : surfaceContainerHighest // ignore: cast_nullable_to_non_nullable
as Color,inverseSurface: null == inverseSurface ? _self.inverseSurface : inverseSurface // ignore: cast_nullable_to_non_nullable
as Color,onInverseSurface: null == onInverseSurface ? _self.onInverseSurface : onInverseSurface // ignore: cast_nullable_to_non_nullable
as Color,inversePrimary: null == inversePrimary ? _self.inversePrimary : inversePrimary // ignore: cast_nullable_to_non_nullable
as Color,shadow: null == shadow ? _self.shadow : shadow // ignore: cast_nullable_to_non_nullable
as Color,scrim: null == scrim ? _self.scrim : scrim // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}

}


/// Adds pattern-matching-related methods to [SurfaceColors].
extension SurfaceColorsPatterns on SurfaceColors {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SurfaceColors value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SurfaceColors() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SurfaceColors value)  $default,){
final _that = this;
switch (_that) {
case _SurfaceColors():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SurfaceColors value)?  $default,){
final _that = this;
switch (_that) {
case _SurfaceColors() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Color background,  Color onBackground,  Color surface,  Color onSurface,  Color surfaceVariant,  Color onSurfaceVariant,  Color surfaceDim,  Color surfaceBright,  Color surfaceContainerLowest,  Color surfaceContainerLow,  Color surfaceContainer,  Color surfaceContainerHigh,  Color surfaceContainerHighest,  Color inverseSurface,  Color onInverseSurface,  Color inversePrimary,  Color shadow,  Color scrim)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SurfaceColors() when $default != null:
return $default(_that.background,_that.onBackground,_that.surface,_that.onSurface,_that.surfaceVariant,_that.onSurfaceVariant,_that.surfaceDim,_that.surfaceBright,_that.surfaceContainerLowest,_that.surfaceContainerLow,_that.surfaceContainer,_that.surfaceContainerHigh,_that.surfaceContainerHighest,_that.inverseSurface,_that.onInverseSurface,_that.inversePrimary,_that.shadow,_that.scrim);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Color background,  Color onBackground,  Color surface,  Color onSurface,  Color surfaceVariant,  Color onSurfaceVariant,  Color surfaceDim,  Color surfaceBright,  Color surfaceContainerLowest,  Color surfaceContainerLow,  Color surfaceContainer,  Color surfaceContainerHigh,  Color surfaceContainerHighest,  Color inverseSurface,  Color onInverseSurface,  Color inversePrimary,  Color shadow,  Color scrim)  $default,) {final _that = this;
switch (_that) {
case _SurfaceColors():
return $default(_that.background,_that.onBackground,_that.surface,_that.onSurface,_that.surfaceVariant,_that.onSurfaceVariant,_that.surfaceDim,_that.surfaceBright,_that.surfaceContainerLowest,_that.surfaceContainerLow,_that.surfaceContainer,_that.surfaceContainerHigh,_that.surfaceContainerHighest,_that.inverseSurface,_that.onInverseSurface,_that.inversePrimary,_that.shadow,_that.scrim);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Color background,  Color onBackground,  Color surface,  Color onSurface,  Color surfaceVariant,  Color onSurfaceVariant,  Color surfaceDim,  Color surfaceBright,  Color surfaceContainerLowest,  Color surfaceContainerLow,  Color surfaceContainer,  Color surfaceContainerHigh,  Color surfaceContainerHighest,  Color inverseSurface,  Color onInverseSurface,  Color inversePrimary,  Color shadow,  Color scrim)?  $default,) {final _that = this;
switch (_that) {
case _SurfaceColors() when $default != null:
return $default(_that.background,_that.onBackground,_that.surface,_that.onSurface,_that.surfaceVariant,_that.onSurfaceVariant,_that.surfaceDim,_that.surfaceBright,_that.surfaceContainerLowest,_that.surfaceContainerLow,_that.surfaceContainer,_that.surfaceContainerHigh,_that.surfaceContainerHighest,_that.inverseSurface,_that.onInverseSurface,_that.inversePrimary,_that.shadow,_that.scrim);case _:
  return null;

}
}

}

/// @nodoc


class _SurfaceColors implements SurfaceColors {
  const _SurfaceColors({required this.background, required this.onBackground, required this.surface, required this.onSurface, required this.surfaceVariant, required this.onSurfaceVariant, required this.surfaceDim, required this.surfaceBright, required this.surfaceContainerLowest, required this.surfaceContainerLow, required this.surfaceContainer, required this.surfaceContainerHigh, required this.surfaceContainerHighest, required this.inverseSurface, required this.onInverseSurface, required this.inversePrimary, required this.shadow, required this.scrim});
  

/// 背景色
@override final  Color background;
@override final  Color onBackground;
/// サーフェス色
@override final  Color surface;
@override final  Color onSurface;
@override final  Color surfaceVariant;
@override final  Color onSurfaceVariant;
/// サーフェス段階
@override final  Color surfaceDim;
@override final  Color surfaceBright;
@override final  Color surfaceContainerLowest;
@override final  Color surfaceContainerLow;
@override final  Color surfaceContainer;
@override final  Color surfaceContainerHigh;
@override final  Color surfaceContainerHighest;
/// インバースサーフェス
@override final  Color inverseSurface;
@override final  Color onInverseSurface;
@override final  Color inversePrimary;
/// シャドウとスクリム
@override final  Color shadow;
@override final  Color scrim;

/// Create a copy of SurfaceColors
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurfaceColorsCopyWith<_SurfaceColors> get copyWith => __$SurfaceColorsCopyWithImpl<_SurfaceColors>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SurfaceColors&&(identical(other.background, background) || other.background == background)&&(identical(other.onBackground, onBackground) || other.onBackground == onBackground)&&(identical(other.surface, surface) || other.surface == surface)&&(identical(other.onSurface, onSurface) || other.onSurface == onSurface)&&(identical(other.surfaceVariant, surfaceVariant) || other.surfaceVariant == surfaceVariant)&&(identical(other.onSurfaceVariant, onSurfaceVariant) || other.onSurfaceVariant == onSurfaceVariant)&&(identical(other.surfaceDim, surfaceDim) || other.surfaceDim == surfaceDim)&&(identical(other.surfaceBright, surfaceBright) || other.surfaceBright == surfaceBright)&&(identical(other.surfaceContainerLowest, surfaceContainerLowest) || other.surfaceContainerLowest == surfaceContainerLowest)&&(identical(other.surfaceContainerLow, surfaceContainerLow) || other.surfaceContainerLow == surfaceContainerLow)&&(identical(other.surfaceContainer, surfaceContainer) || other.surfaceContainer == surfaceContainer)&&(identical(other.surfaceContainerHigh, surfaceContainerHigh) || other.surfaceContainerHigh == surfaceContainerHigh)&&(identical(other.surfaceContainerHighest, surfaceContainerHighest) || other.surfaceContainerHighest == surfaceContainerHighest)&&(identical(other.inverseSurface, inverseSurface) || other.inverseSurface == inverseSurface)&&(identical(other.onInverseSurface, onInverseSurface) || other.onInverseSurface == onInverseSurface)&&(identical(other.inversePrimary, inversePrimary) || other.inversePrimary == inversePrimary)&&(identical(other.shadow, shadow) || other.shadow == shadow)&&(identical(other.scrim, scrim) || other.scrim == scrim));
}


@override
int get hashCode => Object.hash(runtimeType,background,onBackground,surface,onSurface,surfaceVariant,onSurfaceVariant,surfaceDim,surfaceBright,surfaceContainerLowest,surfaceContainerLow,surfaceContainer,surfaceContainerHigh,surfaceContainerHighest,inverseSurface,onInverseSurface,inversePrimary,shadow,scrim);

@override
String toString() {
  return 'SurfaceColors(background: $background, onBackground: $onBackground, surface: $surface, onSurface: $onSurface, surfaceVariant: $surfaceVariant, onSurfaceVariant: $onSurfaceVariant, surfaceDim: $surfaceDim, surfaceBright: $surfaceBright, surfaceContainerLowest: $surfaceContainerLowest, surfaceContainerLow: $surfaceContainerLow, surfaceContainer: $surfaceContainer, surfaceContainerHigh: $surfaceContainerHigh, surfaceContainerHighest: $surfaceContainerHighest, inverseSurface: $inverseSurface, onInverseSurface: $onInverseSurface, inversePrimary: $inversePrimary, shadow: $shadow, scrim: $scrim)';
}


}

/// @nodoc
abstract mixin class _$SurfaceColorsCopyWith<$Res> implements $SurfaceColorsCopyWith<$Res> {
  factory _$SurfaceColorsCopyWith(_SurfaceColors value, $Res Function(_SurfaceColors) _then) = __$SurfaceColorsCopyWithImpl;
@override @useResult
$Res call({
 Color background, Color onBackground, Color surface, Color onSurface, Color surfaceVariant, Color onSurfaceVariant, Color surfaceDim, Color surfaceBright, Color surfaceContainerLowest, Color surfaceContainerLow, Color surfaceContainer, Color surfaceContainerHigh, Color surfaceContainerHighest, Color inverseSurface, Color onInverseSurface, Color inversePrimary, Color shadow, Color scrim
});




}
/// @nodoc
class __$SurfaceColorsCopyWithImpl<$Res>
    implements _$SurfaceColorsCopyWith<$Res> {
  __$SurfaceColorsCopyWithImpl(this._self, this._then);

  final _SurfaceColors _self;
  final $Res Function(_SurfaceColors) _then;

/// Create a copy of SurfaceColors
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? background = null,Object? onBackground = null,Object? surface = null,Object? onSurface = null,Object? surfaceVariant = null,Object? onSurfaceVariant = null,Object? surfaceDim = null,Object? surfaceBright = null,Object? surfaceContainerLowest = null,Object? surfaceContainerLow = null,Object? surfaceContainer = null,Object? surfaceContainerHigh = null,Object? surfaceContainerHighest = null,Object? inverseSurface = null,Object? onInverseSurface = null,Object? inversePrimary = null,Object? shadow = null,Object? scrim = null,}) {
  return _then(_SurfaceColors(
background: null == background ? _self.background : background // ignore: cast_nullable_to_non_nullable
as Color,onBackground: null == onBackground ? _self.onBackground : onBackground // ignore: cast_nullable_to_non_nullable
as Color,surface: null == surface ? _self.surface : surface // ignore: cast_nullable_to_non_nullable
as Color,onSurface: null == onSurface ? _self.onSurface : onSurface // ignore: cast_nullable_to_non_nullable
as Color,surfaceVariant: null == surfaceVariant ? _self.surfaceVariant : surfaceVariant // ignore: cast_nullable_to_non_nullable
as Color,onSurfaceVariant: null == onSurfaceVariant ? _self.onSurfaceVariant : onSurfaceVariant // ignore: cast_nullable_to_non_nullable
as Color,surfaceDim: null == surfaceDim ? _self.surfaceDim : surfaceDim // ignore: cast_nullable_to_non_nullable
as Color,surfaceBright: null == surfaceBright ? _self.surfaceBright : surfaceBright // ignore: cast_nullable_to_non_nullable
as Color,surfaceContainerLowest: null == surfaceContainerLowest ? _self.surfaceContainerLowest : surfaceContainerLowest // ignore: cast_nullable_to_non_nullable
as Color,surfaceContainerLow: null == surfaceContainerLow ? _self.surfaceContainerLow : surfaceContainerLow // ignore: cast_nullable_to_non_nullable
as Color,surfaceContainer: null == surfaceContainer ? _self.surfaceContainer : surfaceContainer // ignore: cast_nullable_to_non_nullable
as Color,surfaceContainerHigh: null == surfaceContainerHigh ? _self.surfaceContainerHigh : surfaceContainerHigh // ignore: cast_nullable_to_non_nullable
as Color,surfaceContainerHighest: null == surfaceContainerHighest ? _self.surfaceContainerHighest : surfaceContainerHighest // ignore: cast_nullable_to_non_nullable
as Color,inverseSurface: null == inverseSurface ? _self.inverseSurface : inverseSurface // ignore: cast_nullable_to_non_nullable
as Color,onInverseSurface: null == onInverseSurface ? _self.onInverseSurface : onInverseSurface // ignore: cast_nullable_to_non_nullable
as Color,inversePrimary: null == inversePrimary ? _self.inversePrimary : inversePrimary // ignore: cast_nullable_to_non_nullable
as Color,shadow: null == shadow ? _self.shadow : shadow // ignore: cast_nullable_to_non_nullable
as Color,scrim: null == scrim ? _self.scrim : scrim // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}


}

// dart format on
