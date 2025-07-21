// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spacing_tokens.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SpacingTokens {

/// 基本スペーシング値（8px）
 double get baseUnit;/// 微小スペース（2px）
 double get space025;/// 極小スペース（4px）
 double get space05;/// 小スペース（8px = 1 unit）
 double get space1;/// 標準スペース（12px = 1.5 units）
 double get space15;/// 中スペース（16px = 2 units）
 double get space2;/// 中大スペース（20px = 2.5 units）
 double get space25;/// 大スペース（24px = 3 units）
 double get space3;/// 特大スペース（32px = 4 units）
 double get space4;/// 超大スペース（40px = 5 units）
 double get space5;/// 巨大スペース（48px = 6 units）
 double get space6;/// 最大スペース（64px = 8 units）
 double get space8;
/// Create a copy of SpacingTokens
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpacingTokensCopyWith<SpacingTokens> get copyWith => _$SpacingTokensCopyWithImpl<SpacingTokens>(this as SpacingTokens, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpacingTokens&&(identical(other.baseUnit, baseUnit) || other.baseUnit == baseUnit)&&(identical(other.space025, space025) || other.space025 == space025)&&(identical(other.space05, space05) || other.space05 == space05)&&(identical(other.space1, space1) || other.space1 == space1)&&(identical(other.space15, space15) || other.space15 == space15)&&(identical(other.space2, space2) || other.space2 == space2)&&(identical(other.space25, space25) || other.space25 == space25)&&(identical(other.space3, space3) || other.space3 == space3)&&(identical(other.space4, space4) || other.space4 == space4)&&(identical(other.space5, space5) || other.space5 == space5)&&(identical(other.space6, space6) || other.space6 == space6)&&(identical(other.space8, space8) || other.space8 == space8));
}


@override
int get hashCode => Object.hash(runtimeType,baseUnit,space025,space05,space1,space15,space2,space25,space3,space4,space5,space6,space8);

@override
String toString() {
  return 'SpacingTokens(baseUnit: $baseUnit, space025: $space025, space05: $space05, space1: $space1, space15: $space15, space2: $space2, space25: $space25, space3: $space3, space4: $space4, space5: $space5, space6: $space6, space8: $space8)';
}


}

/// @nodoc
abstract mixin class $SpacingTokensCopyWith<$Res>  {
  factory $SpacingTokensCopyWith(SpacingTokens value, $Res Function(SpacingTokens) _then) = _$SpacingTokensCopyWithImpl;
@useResult
$Res call({
 double baseUnit, double space025, double space05, double space1, double space15, double space2, double space25, double space3, double space4, double space5, double space6, double space8
});




}
/// @nodoc
class _$SpacingTokensCopyWithImpl<$Res>
    implements $SpacingTokensCopyWith<$Res> {
  _$SpacingTokensCopyWithImpl(this._self, this._then);

  final SpacingTokens _self;
  final $Res Function(SpacingTokens) _then;

/// Create a copy of SpacingTokens
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? baseUnit = null,Object? space025 = null,Object? space05 = null,Object? space1 = null,Object? space15 = null,Object? space2 = null,Object? space25 = null,Object? space3 = null,Object? space4 = null,Object? space5 = null,Object? space6 = null,Object? space8 = null,}) {
  return _then(_self.copyWith(
baseUnit: null == baseUnit ? _self.baseUnit : baseUnit // ignore: cast_nullable_to_non_nullable
as double,space025: null == space025 ? _self.space025 : space025 // ignore: cast_nullable_to_non_nullable
as double,space05: null == space05 ? _self.space05 : space05 // ignore: cast_nullable_to_non_nullable
as double,space1: null == space1 ? _self.space1 : space1 // ignore: cast_nullable_to_non_nullable
as double,space15: null == space15 ? _self.space15 : space15 // ignore: cast_nullable_to_non_nullable
as double,space2: null == space2 ? _self.space2 : space2 // ignore: cast_nullable_to_non_nullable
as double,space25: null == space25 ? _self.space25 : space25 // ignore: cast_nullable_to_non_nullable
as double,space3: null == space3 ? _self.space3 : space3 // ignore: cast_nullable_to_non_nullable
as double,space4: null == space4 ? _self.space4 : space4 // ignore: cast_nullable_to_non_nullable
as double,space5: null == space5 ? _self.space5 : space5 // ignore: cast_nullable_to_non_nullable
as double,space6: null == space6 ? _self.space6 : space6 // ignore: cast_nullable_to_non_nullable
as double,space8: null == space8 ? _self.space8 : space8 // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SpacingTokens].
extension SpacingTokensPatterns on SpacingTokens {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpacingTokens value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpacingTokens() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpacingTokens value)  $default,){
final _that = this;
switch (_that) {
case _SpacingTokens():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpacingTokens value)?  $default,){
final _that = this;
switch (_that) {
case _SpacingTokens() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double baseUnit,  double space025,  double space05,  double space1,  double space15,  double space2,  double space25,  double space3,  double space4,  double space5,  double space6,  double space8)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpacingTokens() when $default != null:
return $default(_that.baseUnit,_that.space025,_that.space05,_that.space1,_that.space15,_that.space2,_that.space25,_that.space3,_that.space4,_that.space5,_that.space6,_that.space8);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double baseUnit,  double space025,  double space05,  double space1,  double space15,  double space2,  double space25,  double space3,  double space4,  double space5,  double space6,  double space8)  $default,) {final _that = this;
switch (_that) {
case _SpacingTokens():
return $default(_that.baseUnit,_that.space025,_that.space05,_that.space1,_that.space15,_that.space2,_that.space25,_that.space3,_that.space4,_that.space5,_that.space6,_that.space8);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double baseUnit,  double space025,  double space05,  double space1,  double space15,  double space2,  double space25,  double space3,  double space4,  double space5,  double space6,  double space8)?  $default,) {final _that = this;
switch (_that) {
case _SpacingTokens() when $default != null:
return $default(_that.baseUnit,_that.space025,_that.space05,_that.space1,_that.space15,_that.space2,_that.space25,_that.space3,_that.space4,_that.space5,_that.space6,_that.space8);case _:
  return null;

}
}

}

/// @nodoc


class _SpacingTokens implements SpacingTokens {
  const _SpacingTokens({required this.baseUnit, required this.space025, required this.space05, required this.space1, required this.space15, required this.space2, required this.space25, required this.space3, required this.space4, required this.space5, required this.space6, required this.space8});
  

/// 基本スペーシング値（8px）
@override final  double baseUnit;
/// 微小スペース（2px）
@override final  double space025;
/// 極小スペース（4px）
@override final  double space05;
/// 小スペース（8px = 1 unit）
@override final  double space1;
/// 標準スペース（12px = 1.5 units）
@override final  double space15;
/// 中スペース（16px = 2 units）
@override final  double space2;
/// 中大スペース（20px = 2.5 units）
@override final  double space25;
/// 大スペース（24px = 3 units）
@override final  double space3;
/// 特大スペース（32px = 4 units）
@override final  double space4;
/// 超大スペース（40px = 5 units）
@override final  double space5;
/// 巨大スペース（48px = 6 units）
@override final  double space6;
/// 最大スペース（64px = 8 units）
@override final  double space8;

/// Create a copy of SpacingTokens
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpacingTokensCopyWith<_SpacingTokens> get copyWith => __$SpacingTokensCopyWithImpl<_SpacingTokens>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpacingTokens&&(identical(other.baseUnit, baseUnit) || other.baseUnit == baseUnit)&&(identical(other.space025, space025) || other.space025 == space025)&&(identical(other.space05, space05) || other.space05 == space05)&&(identical(other.space1, space1) || other.space1 == space1)&&(identical(other.space15, space15) || other.space15 == space15)&&(identical(other.space2, space2) || other.space2 == space2)&&(identical(other.space25, space25) || other.space25 == space25)&&(identical(other.space3, space3) || other.space3 == space3)&&(identical(other.space4, space4) || other.space4 == space4)&&(identical(other.space5, space5) || other.space5 == space5)&&(identical(other.space6, space6) || other.space6 == space6)&&(identical(other.space8, space8) || other.space8 == space8));
}


@override
int get hashCode => Object.hash(runtimeType,baseUnit,space025,space05,space1,space15,space2,space25,space3,space4,space5,space6,space8);

@override
String toString() {
  return 'SpacingTokens(baseUnit: $baseUnit, space025: $space025, space05: $space05, space1: $space1, space15: $space15, space2: $space2, space25: $space25, space3: $space3, space4: $space4, space5: $space5, space6: $space6, space8: $space8)';
}


}

/// @nodoc
abstract mixin class _$SpacingTokensCopyWith<$Res> implements $SpacingTokensCopyWith<$Res> {
  factory _$SpacingTokensCopyWith(_SpacingTokens value, $Res Function(_SpacingTokens) _then) = __$SpacingTokensCopyWithImpl;
@override @useResult
$Res call({
 double baseUnit, double space025, double space05, double space1, double space15, double space2, double space25, double space3, double space4, double space5, double space6, double space8
});




}
/// @nodoc
class __$SpacingTokensCopyWithImpl<$Res>
    implements _$SpacingTokensCopyWith<$Res> {
  __$SpacingTokensCopyWithImpl(this._self, this._then);

  final _SpacingTokens _self;
  final $Res Function(_SpacingTokens) _then;

/// Create a copy of SpacingTokens
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? baseUnit = null,Object? space025 = null,Object? space05 = null,Object? space1 = null,Object? space15 = null,Object? space2 = null,Object? space25 = null,Object? space3 = null,Object? space4 = null,Object? space5 = null,Object? space6 = null,Object? space8 = null,}) {
  return _then(_SpacingTokens(
baseUnit: null == baseUnit ? _self.baseUnit : baseUnit // ignore: cast_nullable_to_non_nullable
as double,space025: null == space025 ? _self.space025 : space025 // ignore: cast_nullable_to_non_nullable
as double,space05: null == space05 ? _self.space05 : space05 // ignore: cast_nullable_to_non_nullable
as double,space1: null == space1 ? _self.space1 : space1 // ignore: cast_nullable_to_non_nullable
as double,space15: null == space15 ? _self.space15 : space15 // ignore: cast_nullable_to_non_nullable
as double,space2: null == space2 ? _self.space2 : space2 // ignore: cast_nullable_to_non_nullable
as double,space25: null == space25 ? _self.space25 : space25 // ignore: cast_nullable_to_non_nullable
as double,space3: null == space3 ? _self.space3 : space3 // ignore: cast_nullable_to_non_nullable
as double,space4: null == space4 ? _self.space4 : space4 // ignore: cast_nullable_to_non_nullable
as double,space5: null == space5 ? _self.space5 : space5 // ignore: cast_nullable_to_non_nullable
as double,space6: null == space6 ? _self.space6 : space6 // ignore: cast_nullable_to_non_nullable
as double,space8: null == space8 ? _self.space8 : space8 // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$InsetTokens {

/// 極小インセット（垂直方向）
 EdgeInsets get none;/// 極小インセット（垂直方向）
 EdgeInsets get xs;/// 小インセット
 EdgeInsets get sm;/// 標準インセット
 EdgeInsets get md;/// 大インセット
 EdgeInsets get lg;/// 特大インセット
 EdgeInsets get xl;/// 超大インセット
 EdgeInsets get xxl;/// ページレベルのインセット
 EdgeInsets get page;/// カードのインセット
 EdgeInsets get card;/// ボタンのインセット
 EdgeInsets get button;/// リストアイテムのインセット
 EdgeInsets get listItem;/// セクション間のインセット
 EdgeInsets get section;
/// Create a copy of InsetTokens
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InsetTokensCopyWith<InsetTokens> get copyWith => _$InsetTokensCopyWithImpl<InsetTokens>(this as InsetTokens, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InsetTokens&&(identical(other.none, none) || other.none == none)&&(identical(other.xs, xs) || other.xs == xs)&&(identical(other.sm, sm) || other.sm == sm)&&(identical(other.md, md) || other.md == md)&&(identical(other.lg, lg) || other.lg == lg)&&(identical(other.xl, xl) || other.xl == xl)&&(identical(other.xxl, xxl) || other.xxl == xxl)&&(identical(other.page, page) || other.page == page)&&(identical(other.card, card) || other.card == card)&&(identical(other.button, button) || other.button == button)&&(identical(other.listItem, listItem) || other.listItem == listItem)&&(identical(other.section, section) || other.section == section));
}


@override
int get hashCode => Object.hash(runtimeType,none,xs,sm,md,lg,xl,xxl,page,card,button,listItem,section);

@override
String toString() {
  return 'InsetTokens(none: $none, xs: $xs, sm: $sm, md: $md, lg: $lg, xl: $xl, xxl: $xxl, page: $page, card: $card, button: $button, listItem: $listItem, section: $section)';
}


}

/// @nodoc
abstract mixin class $InsetTokensCopyWith<$Res>  {
  factory $InsetTokensCopyWith(InsetTokens value, $Res Function(InsetTokens) _then) = _$InsetTokensCopyWithImpl;
@useResult
$Res call({
 EdgeInsets none, EdgeInsets xs, EdgeInsets sm, EdgeInsets md, EdgeInsets lg, EdgeInsets xl, EdgeInsets xxl, EdgeInsets page, EdgeInsets card, EdgeInsets button, EdgeInsets listItem, EdgeInsets section
});




}
/// @nodoc
class _$InsetTokensCopyWithImpl<$Res>
    implements $InsetTokensCopyWith<$Res> {
  _$InsetTokensCopyWithImpl(this._self, this._then);

  final InsetTokens _self;
  final $Res Function(InsetTokens) _then;

/// Create a copy of InsetTokens
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? none = null,Object? xs = null,Object? sm = null,Object? md = null,Object? lg = null,Object? xl = null,Object? xxl = null,Object? page = null,Object? card = null,Object? button = null,Object? listItem = null,Object? section = null,}) {
  return _then(_self.copyWith(
none: null == none ? _self.none : none // ignore: cast_nullable_to_non_nullable
as EdgeInsets,xs: null == xs ? _self.xs : xs // ignore: cast_nullable_to_non_nullable
as EdgeInsets,sm: null == sm ? _self.sm : sm // ignore: cast_nullable_to_non_nullable
as EdgeInsets,md: null == md ? _self.md : md // ignore: cast_nullable_to_non_nullable
as EdgeInsets,lg: null == lg ? _self.lg : lg // ignore: cast_nullable_to_non_nullable
as EdgeInsets,xl: null == xl ? _self.xl : xl // ignore: cast_nullable_to_non_nullable
as EdgeInsets,xxl: null == xxl ? _self.xxl : xxl // ignore: cast_nullable_to_non_nullable
as EdgeInsets,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as EdgeInsets,card: null == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as EdgeInsets,button: null == button ? _self.button : button // ignore: cast_nullable_to_non_nullable
as EdgeInsets,listItem: null == listItem ? _self.listItem : listItem // ignore: cast_nullable_to_non_nullable
as EdgeInsets,section: null == section ? _self.section : section // ignore: cast_nullable_to_non_nullable
as EdgeInsets,
  ));
}

}


/// Adds pattern-matching-related methods to [InsetTokens].
extension InsetTokensPatterns on InsetTokens {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InsetTokens value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InsetTokens() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InsetTokens value)  $default,){
final _that = this;
switch (_that) {
case _InsetTokens():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InsetTokens value)?  $default,){
final _that = this;
switch (_that) {
case _InsetTokens() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EdgeInsets none,  EdgeInsets xs,  EdgeInsets sm,  EdgeInsets md,  EdgeInsets lg,  EdgeInsets xl,  EdgeInsets xxl,  EdgeInsets page,  EdgeInsets card,  EdgeInsets button,  EdgeInsets listItem,  EdgeInsets section)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InsetTokens() when $default != null:
return $default(_that.none,_that.xs,_that.sm,_that.md,_that.lg,_that.xl,_that.xxl,_that.page,_that.card,_that.button,_that.listItem,_that.section);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EdgeInsets none,  EdgeInsets xs,  EdgeInsets sm,  EdgeInsets md,  EdgeInsets lg,  EdgeInsets xl,  EdgeInsets xxl,  EdgeInsets page,  EdgeInsets card,  EdgeInsets button,  EdgeInsets listItem,  EdgeInsets section)  $default,) {final _that = this;
switch (_that) {
case _InsetTokens():
return $default(_that.none,_that.xs,_that.sm,_that.md,_that.lg,_that.xl,_that.xxl,_that.page,_that.card,_that.button,_that.listItem,_that.section);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EdgeInsets none,  EdgeInsets xs,  EdgeInsets sm,  EdgeInsets md,  EdgeInsets lg,  EdgeInsets xl,  EdgeInsets xxl,  EdgeInsets page,  EdgeInsets card,  EdgeInsets button,  EdgeInsets listItem,  EdgeInsets section)?  $default,) {final _that = this;
switch (_that) {
case _InsetTokens() when $default != null:
return $default(_that.none,_that.xs,_that.sm,_that.md,_that.lg,_that.xl,_that.xxl,_that.page,_that.card,_that.button,_that.listItem,_that.section);case _:
  return null;

}
}

}

/// @nodoc


class _InsetTokens implements InsetTokens {
  const _InsetTokens({required this.none, required this.xs, required this.sm, required this.md, required this.lg, required this.xl, required this.xxl, required this.page, required this.card, required this.button, required this.listItem, required this.section});
  

/// 極小インセット（垂直方向）
@override final  EdgeInsets none;
/// 極小インセット（垂直方向）
@override final  EdgeInsets xs;
/// 小インセット
@override final  EdgeInsets sm;
/// 標準インセット
@override final  EdgeInsets md;
/// 大インセット
@override final  EdgeInsets lg;
/// 特大インセット
@override final  EdgeInsets xl;
/// 超大インセット
@override final  EdgeInsets xxl;
/// ページレベルのインセット
@override final  EdgeInsets page;
/// カードのインセット
@override final  EdgeInsets card;
/// ボタンのインセット
@override final  EdgeInsets button;
/// リストアイテムのインセット
@override final  EdgeInsets listItem;
/// セクション間のインセット
@override final  EdgeInsets section;

/// Create a copy of InsetTokens
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InsetTokensCopyWith<_InsetTokens> get copyWith => __$InsetTokensCopyWithImpl<_InsetTokens>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InsetTokens&&(identical(other.none, none) || other.none == none)&&(identical(other.xs, xs) || other.xs == xs)&&(identical(other.sm, sm) || other.sm == sm)&&(identical(other.md, md) || other.md == md)&&(identical(other.lg, lg) || other.lg == lg)&&(identical(other.xl, xl) || other.xl == xl)&&(identical(other.xxl, xxl) || other.xxl == xxl)&&(identical(other.page, page) || other.page == page)&&(identical(other.card, card) || other.card == card)&&(identical(other.button, button) || other.button == button)&&(identical(other.listItem, listItem) || other.listItem == listItem)&&(identical(other.section, section) || other.section == section));
}


@override
int get hashCode => Object.hash(runtimeType,none,xs,sm,md,lg,xl,xxl,page,card,button,listItem,section);

@override
String toString() {
  return 'InsetTokens(none: $none, xs: $xs, sm: $sm, md: $md, lg: $lg, xl: $xl, xxl: $xxl, page: $page, card: $card, button: $button, listItem: $listItem, section: $section)';
}


}

/// @nodoc
abstract mixin class _$InsetTokensCopyWith<$Res> implements $InsetTokensCopyWith<$Res> {
  factory _$InsetTokensCopyWith(_InsetTokens value, $Res Function(_InsetTokens) _then) = __$InsetTokensCopyWithImpl;
@override @useResult
$Res call({
 EdgeInsets none, EdgeInsets xs, EdgeInsets sm, EdgeInsets md, EdgeInsets lg, EdgeInsets xl, EdgeInsets xxl, EdgeInsets page, EdgeInsets card, EdgeInsets button, EdgeInsets listItem, EdgeInsets section
});




}
/// @nodoc
class __$InsetTokensCopyWithImpl<$Res>
    implements _$InsetTokensCopyWith<$Res> {
  __$InsetTokensCopyWithImpl(this._self, this._then);

  final _InsetTokens _self;
  final $Res Function(_InsetTokens) _then;

/// Create a copy of InsetTokens
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? none = null,Object? xs = null,Object? sm = null,Object? md = null,Object? lg = null,Object? xl = null,Object? xxl = null,Object? page = null,Object? card = null,Object? button = null,Object? listItem = null,Object? section = null,}) {
  return _then(_InsetTokens(
none: null == none ? _self.none : none // ignore: cast_nullable_to_non_nullable
as EdgeInsets,xs: null == xs ? _self.xs : xs // ignore: cast_nullable_to_non_nullable
as EdgeInsets,sm: null == sm ? _self.sm : sm // ignore: cast_nullable_to_non_nullable
as EdgeInsets,md: null == md ? _self.md : md // ignore: cast_nullable_to_non_nullable
as EdgeInsets,lg: null == lg ? _self.lg : lg // ignore: cast_nullable_to_non_nullable
as EdgeInsets,xl: null == xl ? _self.xl : xl // ignore: cast_nullable_to_non_nullable
as EdgeInsets,xxl: null == xxl ? _self.xxl : xxl // ignore: cast_nullable_to_non_nullable
as EdgeInsets,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as EdgeInsets,card: null == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as EdgeInsets,button: null == button ? _self.button : button // ignore: cast_nullable_to_non_nullable
as EdgeInsets,listItem: null == listItem ? _self.listItem : listItem // ignore: cast_nullable_to_non_nullable
as EdgeInsets,section: null == section ? _self.section : section // ignore: cast_nullable_to_non_nullable
as EdgeInsets,
  ));
}


}

/// @nodoc
mixin _$GridTokens {

/// グリッドの基本単位
 double get gridUnit;/// カラム間のガター
 double get columnGap;/// 行間のガター
 double get rowGap;/// コンテナの最大幅
 double get maxContentWidth;/// ナビゲーションバーの高さ
 double get navBarHeight;/// ツールバーの高さ
 double get toolbarHeight;/// フッターの高さ
 double get footerHeight;/// サイドバーの幅
 double get sidebarWidth;
/// Create a copy of GridTokens
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GridTokensCopyWith<GridTokens> get copyWith => _$GridTokensCopyWithImpl<GridTokens>(this as GridTokens, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GridTokens&&(identical(other.gridUnit, gridUnit) || other.gridUnit == gridUnit)&&(identical(other.columnGap, columnGap) || other.columnGap == columnGap)&&(identical(other.rowGap, rowGap) || other.rowGap == rowGap)&&(identical(other.maxContentWidth, maxContentWidth) || other.maxContentWidth == maxContentWidth)&&(identical(other.navBarHeight, navBarHeight) || other.navBarHeight == navBarHeight)&&(identical(other.toolbarHeight, toolbarHeight) || other.toolbarHeight == toolbarHeight)&&(identical(other.footerHeight, footerHeight) || other.footerHeight == footerHeight)&&(identical(other.sidebarWidth, sidebarWidth) || other.sidebarWidth == sidebarWidth));
}


@override
int get hashCode => Object.hash(runtimeType,gridUnit,columnGap,rowGap,maxContentWidth,navBarHeight,toolbarHeight,footerHeight,sidebarWidth);

@override
String toString() {
  return 'GridTokens(gridUnit: $gridUnit, columnGap: $columnGap, rowGap: $rowGap, maxContentWidth: $maxContentWidth, navBarHeight: $navBarHeight, toolbarHeight: $toolbarHeight, footerHeight: $footerHeight, sidebarWidth: $sidebarWidth)';
}


}

/// @nodoc
abstract mixin class $GridTokensCopyWith<$Res>  {
  factory $GridTokensCopyWith(GridTokens value, $Res Function(GridTokens) _then) = _$GridTokensCopyWithImpl;
@useResult
$Res call({
 double gridUnit, double columnGap, double rowGap, double maxContentWidth, double navBarHeight, double toolbarHeight, double footerHeight, double sidebarWidth
});




}
/// @nodoc
class _$GridTokensCopyWithImpl<$Res>
    implements $GridTokensCopyWith<$Res> {
  _$GridTokensCopyWithImpl(this._self, this._then);

  final GridTokens _self;
  final $Res Function(GridTokens) _then;

/// Create a copy of GridTokens
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? gridUnit = null,Object? columnGap = null,Object? rowGap = null,Object? maxContentWidth = null,Object? navBarHeight = null,Object? toolbarHeight = null,Object? footerHeight = null,Object? sidebarWidth = null,}) {
  return _then(_self.copyWith(
gridUnit: null == gridUnit ? _self.gridUnit : gridUnit // ignore: cast_nullable_to_non_nullable
as double,columnGap: null == columnGap ? _self.columnGap : columnGap // ignore: cast_nullable_to_non_nullable
as double,rowGap: null == rowGap ? _self.rowGap : rowGap // ignore: cast_nullable_to_non_nullable
as double,maxContentWidth: null == maxContentWidth ? _self.maxContentWidth : maxContentWidth // ignore: cast_nullable_to_non_nullable
as double,navBarHeight: null == navBarHeight ? _self.navBarHeight : navBarHeight // ignore: cast_nullable_to_non_nullable
as double,toolbarHeight: null == toolbarHeight ? _self.toolbarHeight : toolbarHeight // ignore: cast_nullable_to_non_nullable
as double,footerHeight: null == footerHeight ? _self.footerHeight : footerHeight // ignore: cast_nullable_to_non_nullable
as double,sidebarWidth: null == sidebarWidth ? _self.sidebarWidth : sidebarWidth // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [GridTokens].
extension GridTokensPatterns on GridTokens {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GridTokens value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GridTokens() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GridTokens value)  $default,){
final _that = this;
switch (_that) {
case _GridTokens():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GridTokens value)?  $default,){
final _that = this;
switch (_that) {
case _GridTokens() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double gridUnit,  double columnGap,  double rowGap,  double maxContentWidth,  double navBarHeight,  double toolbarHeight,  double footerHeight,  double sidebarWidth)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GridTokens() when $default != null:
return $default(_that.gridUnit,_that.columnGap,_that.rowGap,_that.maxContentWidth,_that.navBarHeight,_that.toolbarHeight,_that.footerHeight,_that.sidebarWidth);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double gridUnit,  double columnGap,  double rowGap,  double maxContentWidth,  double navBarHeight,  double toolbarHeight,  double footerHeight,  double sidebarWidth)  $default,) {final _that = this;
switch (_that) {
case _GridTokens():
return $default(_that.gridUnit,_that.columnGap,_that.rowGap,_that.maxContentWidth,_that.navBarHeight,_that.toolbarHeight,_that.footerHeight,_that.sidebarWidth);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double gridUnit,  double columnGap,  double rowGap,  double maxContentWidth,  double navBarHeight,  double toolbarHeight,  double footerHeight,  double sidebarWidth)?  $default,) {final _that = this;
switch (_that) {
case _GridTokens() when $default != null:
return $default(_that.gridUnit,_that.columnGap,_that.rowGap,_that.maxContentWidth,_that.navBarHeight,_that.toolbarHeight,_that.footerHeight,_that.sidebarWidth);case _:
  return null;

}
}

}

/// @nodoc


class _GridTokens implements GridTokens {
  const _GridTokens({required this.gridUnit, required this.columnGap, required this.rowGap, required this.maxContentWidth, required this.navBarHeight, required this.toolbarHeight, required this.footerHeight, required this.sidebarWidth});
  

/// グリッドの基本単位
@override final  double gridUnit;
/// カラム間のガター
@override final  double columnGap;
/// 行間のガター
@override final  double rowGap;
/// コンテナの最大幅
@override final  double maxContentWidth;
/// ナビゲーションバーの高さ
@override final  double navBarHeight;
/// ツールバーの高さ
@override final  double toolbarHeight;
/// フッターの高さ
@override final  double footerHeight;
/// サイドバーの幅
@override final  double sidebarWidth;

/// Create a copy of GridTokens
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GridTokensCopyWith<_GridTokens> get copyWith => __$GridTokensCopyWithImpl<_GridTokens>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GridTokens&&(identical(other.gridUnit, gridUnit) || other.gridUnit == gridUnit)&&(identical(other.columnGap, columnGap) || other.columnGap == columnGap)&&(identical(other.rowGap, rowGap) || other.rowGap == rowGap)&&(identical(other.maxContentWidth, maxContentWidth) || other.maxContentWidth == maxContentWidth)&&(identical(other.navBarHeight, navBarHeight) || other.navBarHeight == navBarHeight)&&(identical(other.toolbarHeight, toolbarHeight) || other.toolbarHeight == toolbarHeight)&&(identical(other.footerHeight, footerHeight) || other.footerHeight == footerHeight)&&(identical(other.sidebarWidth, sidebarWidth) || other.sidebarWidth == sidebarWidth));
}


@override
int get hashCode => Object.hash(runtimeType,gridUnit,columnGap,rowGap,maxContentWidth,navBarHeight,toolbarHeight,footerHeight,sidebarWidth);

@override
String toString() {
  return 'GridTokens(gridUnit: $gridUnit, columnGap: $columnGap, rowGap: $rowGap, maxContentWidth: $maxContentWidth, navBarHeight: $navBarHeight, toolbarHeight: $toolbarHeight, footerHeight: $footerHeight, sidebarWidth: $sidebarWidth)';
}


}

/// @nodoc
abstract mixin class _$GridTokensCopyWith<$Res> implements $GridTokensCopyWith<$Res> {
  factory _$GridTokensCopyWith(_GridTokens value, $Res Function(_GridTokens) _then) = __$GridTokensCopyWithImpl;
@override @useResult
$Res call({
 double gridUnit, double columnGap, double rowGap, double maxContentWidth, double navBarHeight, double toolbarHeight, double footerHeight, double sidebarWidth
});




}
/// @nodoc
class __$GridTokensCopyWithImpl<$Res>
    implements _$GridTokensCopyWith<$Res> {
  __$GridTokensCopyWithImpl(this._self, this._then);

  final _GridTokens _self;
  final $Res Function(_GridTokens) _then;

/// Create a copy of GridTokens
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? gridUnit = null,Object? columnGap = null,Object? rowGap = null,Object? maxContentWidth = null,Object? navBarHeight = null,Object? toolbarHeight = null,Object? footerHeight = null,Object? sidebarWidth = null,}) {
  return _then(_GridTokens(
gridUnit: null == gridUnit ? _self.gridUnit : gridUnit // ignore: cast_nullable_to_non_nullable
as double,columnGap: null == columnGap ? _self.columnGap : columnGap // ignore: cast_nullable_to_non_nullable
as double,rowGap: null == rowGap ? _self.rowGap : rowGap // ignore: cast_nullable_to_non_nullable
as double,maxContentWidth: null == maxContentWidth ? _self.maxContentWidth : maxContentWidth // ignore: cast_nullable_to_non_nullable
as double,navBarHeight: null == navBarHeight ? _self.navBarHeight : navBarHeight // ignore: cast_nullable_to_non_nullable
as double,toolbarHeight: null == toolbarHeight ? _self.toolbarHeight : toolbarHeight // ignore: cast_nullable_to_non_nullable
as double,footerHeight: null == footerHeight ? _self.footerHeight : footerHeight // ignore: cast_nullable_to_non_nullable
as double,sidebarWidth: null == sidebarWidth ? _self.sidebarWidth : sidebarWidth // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
