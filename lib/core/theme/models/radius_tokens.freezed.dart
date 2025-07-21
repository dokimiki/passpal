// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'radius_tokens.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RadiusTokens {

/// 角丸なし
 double get none;/// 極小角丸（2px）
 double get xs;/// 小角丸（4px）
 double get sm;/// 標準角丸（8px）
 double get md;/// 大角丸（12px）
 double get lg;/// 特大角丸（16px）
 double get xl;/// 超大角丸（20px）
 double get xxl;/// 巨大角丸（28px）
 double get xxxl;/// 円形（50%）
 double get full;
/// Create a copy of RadiusTokens
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RadiusTokensCopyWith<RadiusTokens> get copyWith => _$RadiusTokensCopyWithImpl<RadiusTokens>(this as RadiusTokens, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RadiusTokens&&(identical(other.none, none) || other.none == none)&&(identical(other.xs, xs) || other.xs == xs)&&(identical(other.sm, sm) || other.sm == sm)&&(identical(other.md, md) || other.md == md)&&(identical(other.lg, lg) || other.lg == lg)&&(identical(other.xl, xl) || other.xl == xl)&&(identical(other.xxl, xxl) || other.xxl == xxl)&&(identical(other.xxxl, xxxl) || other.xxxl == xxxl)&&(identical(other.full, full) || other.full == full));
}


@override
int get hashCode => Object.hash(runtimeType,none,xs,sm,md,lg,xl,xxl,xxxl,full);

@override
String toString() {
  return 'RadiusTokens(none: $none, xs: $xs, sm: $sm, md: $md, lg: $lg, xl: $xl, xxl: $xxl, xxxl: $xxxl, full: $full)';
}


}

/// @nodoc
abstract mixin class $RadiusTokensCopyWith<$Res>  {
  factory $RadiusTokensCopyWith(RadiusTokens value, $Res Function(RadiusTokens) _then) = _$RadiusTokensCopyWithImpl;
@useResult
$Res call({
 double none, double xs, double sm, double md, double lg, double xl, double xxl, double xxxl, double full
});




}
/// @nodoc
class _$RadiusTokensCopyWithImpl<$Res>
    implements $RadiusTokensCopyWith<$Res> {
  _$RadiusTokensCopyWithImpl(this._self, this._then);

  final RadiusTokens _self;
  final $Res Function(RadiusTokens) _then;

/// Create a copy of RadiusTokens
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? none = null,Object? xs = null,Object? sm = null,Object? md = null,Object? lg = null,Object? xl = null,Object? xxl = null,Object? xxxl = null,Object? full = null,}) {
  return _then(_self.copyWith(
none: null == none ? _self.none : none // ignore: cast_nullable_to_non_nullable
as double,xs: null == xs ? _self.xs : xs // ignore: cast_nullable_to_non_nullable
as double,sm: null == sm ? _self.sm : sm // ignore: cast_nullable_to_non_nullable
as double,md: null == md ? _self.md : md // ignore: cast_nullable_to_non_nullable
as double,lg: null == lg ? _self.lg : lg // ignore: cast_nullable_to_non_nullable
as double,xl: null == xl ? _self.xl : xl // ignore: cast_nullable_to_non_nullable
as double,xxl: null == xxl ? _self.xxl : xxl // ignore: cast_nullable_to_non_nullable
as double,xxxl: null == xxxl ? _self.xxxl : xxxl // ignore: cast_nullable_to_non_nullable
as double,full: null == full ? _self.full : full // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [RadiusTokens].
extension RadiusTokensPatterns on RadiusTokens {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RadiusTokens value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RadiusTokens() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RadiusTokens value)  $default,){
final _that = this;
switch (_that) {
case _RadiusTokens():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RadiusTokens value)?  $default,){
final _that = this;
switch (_that) {
case _RadiusTokens() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double none,  double xs,  double sm,  double md,  double lg,  double xl,  double xxl,  double xxxl,  double full)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RadiusTokens() when $default != null:
return $default(_that.none,_that.xs,_that.sm,_that.md,_that.lg,_that.xl,_that.xxl,_that.xxxl,_that.full);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double none,  double xs,  double sm,  double md,  double lg,  double xl,  double xxl,  double xxxl,  double full)  $default,) {final _that = this;
switch (_that) {
case _RadiusTokens():
return $default(_that.none,_that.xs,_that.sm,_that.md,_that.lg,_that.xl,_that.xxl,_that.xxxl,_that.full);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double none,  double xs,  double sm,  double md,  double lg,  double xl,  double xxl,  double xxxl,  double full)?  $default,) {final _that = this;
switch (_that) {
case _RadiusTokens() when $default != null:
return $default(_that.none,_that.xs,_that.sm,_that.md,_that.lg,_that.xl,_that.xxl,_that.xxxl,_that.full);case _:
  return null;

}
}

}

/// @nodoc


class _RadiusTokens implements RadiusTokens {
  const _RadiusTokens({required this.none, required this.xs, required this.sm, required this.md, required this.lg, required this.xl, required this.xxl, required this.xxxl, required this.full});
  

/// 角丸なし
@override final  double none;
/// 極小角丸（2px）
@override final  double xs;
/// 小角丸（4px）
@override final  double sm;
/// 標準角丸（8px）
@override final  double md;
/// 大角丸（12px）
@override final  double lg;
/// 特大角丸（16px）
@override final  double xl;
/// 超大角丸（20px）
@override final  double xxl;
/// 巨大角丸（28px）
@override final  double xxxl;
/// 円形（50%）
@override final  double full;

/// Create a copy of RadiusTokens
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RadiusTokensCopyWith<_RadiusTokens> get copyWith => __$RadiusTokensCopyWithImpl<_RadiusTokens>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RadiusTokens&&(identical(other.none, none) || other.none == none)&&(identical(other.xs, xs) || other.xs == xs)&&(identical(other.sm, sm) || other.sm == sm)&&(identical(other.md, md) || other.md == md)&&(identical(other.lg, lg) || other.lg == lg)&&(identical(other.xl, xl) || other.xl == xl)&&(identical(other.xxl, xxl) || other.xxl == xxl)&&(identical(other.xxxl, xxxl) || other.xxxl == xxxl)&&(identical(other.full, full) || other.full == full));
}


@override
int get hashCode => Object.hash(runtimeType,none,xs,sm,md,lg,xl,xxl,xxxl,full);

@override
String toString() {
  return 'RadiusTokens(none: $none, xs: $xs, sm: $sm, md: $md, lg: $lg, xl: $xl, xxl: $xxl, xxxl: $xxxl, full: $full)';
}


}

/// @nodoc
abstract mixin class _$RadiusTokensCopyWith<$Res> implements $RadiusTokensCopyWith<$Res> {
  factory _$RadiusTokensCopyWith(_RadiusTokens value, $Res Function(_RadiusTokens) _then) = __$RadiusTokensCopyWithImpl;
@override @useResult
$Res call({
 double none, double xs, double sm, double md, double lg, double xl, double xxl, double xxxl, double full
});




}
/// @nodoc
class __$RadiusTokensCopyWithImpl<$Res>
    implements _$RadiusTokensCopyWith<$Res> {
  __$RadiusTokensCopyWithImpl(this._self, this._then);

  final _RadiusTokens _self;
  final $Res Function(_RadiusTokens) _then;

/// Create a copy of RadiusTokens
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? none = null,Object? xs = null,Object? sm = null,Object? md = null,Object? lg = null,Object? xl = null,Object? xxl = null,Object? xxxl = null,Object? full = null,}) {
  return _then(_RadiusTokens(
none: null == none ? _self.none : none // ignore: cast_nullable_to_non_nullable
as double,xs: null == xs ? _self.xs : xs // ignore: cast_nullable_to_non_nullable
as double,sm: null == sm ? _self.sm : sm // ignore: cast_nullable_to_non_nullable
as double,md: null == md ? _self.md : md // ignore: cast_nullable_to_non_nullable
as double,lg: null == lg ? _self.lg : lg // ignore: cast_nullable_to_non_nullable
as double,xl: null == xl ? _self.xl : xl // ignore: cast_nullable_to_non_nullable
as double,xxl: null == xxl ? _self.xxl : xxl // ignore: cast_nullable_to_non_nullable
as double,xxxl: null == xxxl ? _self.xxxl : xxxl // ignore: cast_nullable_to_non_nullable
as double,full: null == full ? _self.full : full // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$ComponentRadiusTokens {

/// ボタンの角丸
 BorderRadius get button;/// カードの角丸
 BorderRadius get card;/// チップの角丸
 BorderRadius get chip;/// インプットフィールドの角丸
 BorderRadius get input;/// モーダル・ダイアログの角丸
 BorderRadius get modal;/// ボトムシートの角丸
 BorderRadius get bottomSheet;/// FABの角丸
 BorderRadius get fab;/// アバターの角丸
 BorderRadius get avatar;/// イメージの角丸
 BorderRadius get image;/// ナビゲーションの角丸
 BorderRadius get navigation;/// バッジの角丸
 BorderRadius get badge;/// プログレスインジケータの角丸
 BorderRadius get progress;
/// Create a copy of ComponentRadiusTokens
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComponentRadiusTokensCopyWith<ComponentRadiusTokens> get copyWith => _$ComponentRadiusTokensCopyWithImpl<ComponentRadiusTokens>(this as ComponentRadiusTokens, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComponentRadiusTokens&&(identical(other.button, button) || other.button == button)&&(identical(other.card, card) || other.card == card)&&(identical(other.chip, chip) || other.chip == chip)&&(identical(other.input, input) || other.input == input)&&(identical(other.modal, modal) || other.modal == modal)&&(identical(other.bottomSheet, bottomSheet) || other.bottomSheet == bottomSheet)&&(identical(other.fab, fab) || other.fab == fab)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.image, image) || other.image == image)&&(identical(other.navigation, navigation) || other.navigation == navigation)&&(identical(other.badge, badge) || other.badge == badge)&&(identical(other.progress, progress) || other.progress == progress));
}


@override
int get hashCode => Object.hash(runtimeType,button,card,chip,input,modal,bottomSheet,fab,avatar,image,navigation,badge,progress);

@override
String toString() {
  return 'ComponentRadiusTokens(button: $button, card: $card, chip: $chip, input: $input, modal: $modal, bottomSheet: $bottomSheet, fab: $fab, avatar: $avatar, image: $image, navigation: $navigation, badge: $badge, progress: $progress)';
}


}

/// @nodoc
abstract mixin class $ComponentRadiusTokensCopyWith<$Res>  {
  factory $ComponentRadiusTokensCopyWith(ComponentRadiusTokens value, $Res Function(ComponentRadiusTokens) _then) = _$ComponentRadiusTokensCopyWithImpl;
@useResult
$Res call({
 BorderRadius button, BorderRadius card, BorderRadius chip, BorderRadius input, BorderRadius modal, BorderRadius bottomSheet, BorderRadius fab, BorderRadius avatar, BorderRadius image, BorderRadius navigation, BorderRadius badge, BorderRadius progress
});




}
/// @nodoc
class _$ComponentRadiusTokensCopyWithImpl<$Res>
    implements $ComponentRadiusTokensCopyWith<$Res> {
  _$ComponentRadiusTokensCopyWithImpl(this._self, this._then);

  final ComponentRadiusTokens _self;
  final $Res Function(ComponentRadiusTokens) _then;

/// Create a copy of ComponentRadiusTokens
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? button = null,Object? card = null,Object? chip = null,Object? input = null,Object? modal = null,Object? bottomSheet = null,Object? fab = null,Object? avatar = null,Object? image = null,Object? navigation = null,Object? badge = null,Object? progress = null,}) {
  return _then(_self.copyWith(
button: null == button ? _self.button : button // ignore: cast_nullable_to_non_nullable
as BorderRadius,card: null == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as BorderRadius,chip: null == chip ? _self.chip : chip // ignore: cast_nullable_to_non_nullable
as BorderRadius,input: null == input ? _self.input : input // ignore: cast_nullable_to_non_nullable
as BorderRadius,modal: null == modal ? _self.modal : modal // ignore: cast_nullable_to_non_nullable
as BorderRadius,bottomSheet: null == bottomSheet ? _self.bottomSheet : bottomSheet // ignore: cast_nullable_to_non_nullable
as BorderRadius,fab: null == fab ? _self.fab : fab // ignore: cast_nullable_to_non_nullable
as BorderRadius,avatar: null == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as BorderRadius,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as BorderRadius,navigation: null == navigation ? _self.navigation : navigation // ignore: cast_nullable_to_non_nullable
as BorderRadius,badge: null == badge ? _self.badge : badge // ignore: cast_nullable_to_non_nullable
as BorderRadius,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as BorderRadius,
  ));
}

}


/// Adds pattern-matching-related methods to [ComponentRadiusTokens].
extension ComponentRadiusTokensPatterns on ComponentRadiusTokens {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ComponentRadiusTokens value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ComponentRadiusTokens() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ComponentRadiusTokens value)  $default,){
final _that = this;
switch (_that) {
case _ComponentRadiusTokens():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ComponentRadiusTokens value)?  $default,){
final _that = this;
switch (_that) {
case _ComponentRadiusTokens() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BorderRadius button,  BorderRadius card,  BorderRadius chip,  BorderRadius input,  BorderRadius modal,  BorderRadius bottomSheet,  BorderRadius fab,  BorderRadius avatar,  BorderRadius image,  BorderRadius navigation,  BorderRadius badge,  BorderRadius progress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ComponentRadiusTokens() when $default != null:
return $default(_that.button,_that.card,_that.chip,_that.input,_that.modal,_that.bottomSheet,_that.fab,_that.avatar,_that.image,_that.navigation,_that.badge,_that.progress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BorderRadius button,  BorderRadius card,  BorderRadius chip,  BorderRadius input,  BorderRadius modal,  BorderRadius bottomSheet,  BorderRadius fab,  BorderRadius avatar,  BorderRadius image,  BorderRadius navigation,  BorderRadius badge,  BorderRadius progress)  $default,) {final _that = this;
switch (_that) {
case _ComponentRadiusTokens():
return $default(_that.button,_that.card,_that.chip,_that.input,_that.modal,_that.bottomSheet,_that.fab,_that.avatar,_that.image,_that.navigation,_that.badge,_that.progress);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BorderRadius button,  BorderRadius card,  BorderRadius chip,  BorderRadius input,  BorderRadius modal,  BorderRadius bottomSheet,  BorderRadius fab,  BorderRadius avatar,  BorderRadius image,  BorderRadius navigation,  BorderRadius badge,  BorderRadius progress)?  $default,) {final _that = this;
switch (_that) {
case _ComponentRadiusTokens() when $default != null:
return $default(_that.button,_that.card,_that.chip,_that.input,_that.modal,_that.bottomSheet,_that.fab,_that.avatar,_that.image,_that.navigation,_that.badge,_that.progress);case _:
  return null;

}
}

}

/// @nodoc


class _ComponentRadiusTokens implements ComponentRadiusTokens {
  const _ComponentRadiusTokens({required this.button, required this.card, required this.chip, required this.input, required this.modal, required this.bottomSheet, required this.fab, required this.avatar, required this.image, required this.navigation, required this.badge, required this.progress});
  

/// ボタンの角丸
@override final  BorderRadius button;
/// カードの角丸
@override final  BorderRadius card;
/// チップの角丸
@override final  BorderRadius chip;
/// インプットフィールドの角丸
@override final  BorderRadius input;
/// モーダル・ダイアログの角丸
@override final  BorderRadius modal;
/// ボトムシートの角丸
@override final  BorderRadius bottomSheet;
/// FABの角丸
@override final  BorderRadius fab;
/// アバターの角丸
@override final  BorderRadius avatar;
/// イメージの角丸
@override final  BorderRadius image;
/// ナビゲーションの角丸
@override final  BorderRadius navigation;
/// バッジの角丸
@override final  BorderRadius badge;
/// プログレスインジケータの角丸
@override final  BorderRadius progress;

/// Create a copy of ComponentRadiusTokens
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ComponentRadiusTokensCopyWith<_ComponentRadiusTokens> get copyWith => __$ComponentRadiusTokensCopyWithImpl<_ComponentRadiusTokens>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ComponentRadiusTokens&&(identical(other.button, button) || other.button == button)&&(identical(other.card, card) || other.card == card)&&(identical(other.chip, chip) || other.chip == chip)&&(identical(other.input, input) || other.input == input)&&(identical(other.modal, modal) || other.modal == modal)&&(identical(other.bottomSheet, bottomSheet) || other.bottomSheet == bottomSheet)&&(identical(other.fab, fab) || other.fab == fab)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.image, image) || other.image == image)&&(identical(other.navigation, navigation) || other.navigation == navigation)&&(identical(other.badge, badge) || other.badge == badge)&&(identical(other.progress, progress) || other.progress == progress));
}


@override
int get hashCode => Object.hash(runtimeType,button,card,chip,input,modal,bottomSheet,fab,avatar,image,navigation,badge,progress);

@override
String toString() {
  return 'ComponentRadiusTokens(button: $button, card: $card, chip: $chip, input: $input, modal: $modal, bottomSheet: $bottomSheet, fab: $fab, avatar: $avatar, image: $image, navigation: $navigation, badge: $badge, progress: $progress)';
}


}

/// @nodoc
abstract mixin class _$ComponentRadiusTokensCopyWith<$Res> implements $ComponentRadiusTokensCopyWith<$Res> {
  factory _$ComponentRadiusTokensCopyWith(_ComponentRadiusTokens value, $Res Function(_ComponentRadiusTokens) _then) = __$ComponentRadiusTokensCopyWithImpl;
@override @useResult
$Res call({
 BorderRadius button, BorderRadius card, BorderRadius chip, BorderRadius input, BorderRadius modal, BorderRadius bottomSheet, BorderRadius fab, BorderRadius avatar, BorderRadius image, BorderRadius navigation, BorderRadius badge, BorderRadius progress
});




}
/// @nodoc
class __$ComponentRadiusTokensCopyWithImpl<$Res>
    implements _$ComponentRadiusTokensCopyWith<$Res> {
  __$ComponentRadiusTokensCopyWithImpl(this._self, this._then);

  final _ComponentRadiusTokens _self;
  final $Res Function(_ComponentRadiusTokens) _then;

/// Create a copy of ComponentRadiusTokens
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? button = null,Object? card = null,Object? chip = null,Object? input = null,Object? modal = null,Object? bottomSheet = null,Object? fab = null,Object? avatar = null,Object? image = null,Object? navigation = null,Object? badge = null,Object? progress = null,}) {
  return _then(_ComponentRadiusTokens(
button: null == button ? _self.button : button // ignore: cast_nullable_to_non_nullable
as BorderRadius,card: null == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as BorderRadius,chip: null == chip ? _self.chip : chip // ignore: cast_nullable_to_non_nullable
as BorderRadius,input: null == input ? _self.input : input // ignore: cast_nullable_to_non_nullable
as BorderRadius,modal: null == modal ? _self.modal : modal // ignore: cast_nullable_to_non_nullable
as BorderRadius,bottomSheet: null == bottomSheet ? _self.bottomSheet : bottomSheet // ignore: cast_nullable_to_non_nullable
as BorderRadius,fab: null == fab ? _self.fab : fab // ignore: cast_nullable_to_non_nullable
as BorderRadius,avatar: null == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as BorderRadius,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as BorderRadius,navigation: null == navigation ? _self.navigation : navigation // ignore: cast_nullable_to_non_nullable
as BorderRadius,badge: null == badge ? _self.badge : badge // ignore: cast_nullable_to_non_nullable
as BorderRadius,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as BorderRadius,
  ));
}


}

// dart format on
