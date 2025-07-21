// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'elevation_tokens.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ElevationTokens {

/// エレベーションなし
 double get level0;/// レベル1（わずかな浮き上がり）
 double get level1;/// レベル2（標準的な浮き上がり）
 double get level2;/// レベル3（明確な浮き上がり）
 double get level3;/// レベル4（強い浮き上がり）
 double get level4;/// レベル5（最大の浮き上がり）
 double get level5;
/// Create a copy of ElevationTokens
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ElevationTokensCopyWith<ElevationTokens> get copyWith => _$ElevationTokensCopyWithImpl<ElevationTokens>(this as ElevationTokens, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ElevationTokens&&(identical(other.level0, level0) || other.level0 == level0)&&(identical(other.level1, level1) || other.level1 == level1)&&(identical(other.level2, level2) || other.level2 == level2)&&(identical(other.level3, level3) || other.level3 == level3)&&(identical(other.level4, level4) || other.level4 == level4)&&(identical(other.level5, level5) || other.level5 == level5));
}


@override
int get hashCode => Object.hash(runtimeType,level0,level1,level2,level3,level4,level5);

@override
String toString() {
  return 'ElevationTokens(level0: $level0, level1: $level1, level2: $level2, level3: $level3, level4: $level4, level5: $level5)';
}


}

/// @nodoc
abstract mixin class $ElevationTokensCopyWith<$Res>  {
  factory $ElevationTokensCopyWith(ElevationTokens value, $Res Function(ElevationTokens) _then) = _$ElevationTokensCopyWithImpl;
@useResult
$Res call({
 double level0, double level1, double level2, double level3, double level4, double level5
});




}
/// @nodoc
class _$ElevationTokensCopyWithImpl<$Res>
    implements $ElevationTokensCopyWith<$Res> {
  _$ElevationTokensCopyWithImpl(this._self, this._then);

  final ElevationTokens _self;
  final $Res Function(ElevationTokens) _then;

/// Create a copy of ElevationTokens
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? level0 = null,Object? level1 = null,Object? level2 = null,Object? level3 = null,Object? level4 = null,Object? level5 = null,}) {
  return _then(_self.copyWith(
level0: null == level0 ? _self.level0 : level0 // ignore: cast_nullable_to_non_nullable
as double,level1: null == level1 ? _self.level1 : level1 // ignore: cast_nullable_to_non_nullable
as double,level2: null == level2 ? _self.level2 : level2 // ignore: cast_nullable_to_non_nullable
as double,level3: null == level3 ? _self.level3 : level3 // ignore: cast_nullable_to_non_nullable
as double,level4: null == level4 ? _self.level4 : level4 // ignore: cast_nullable_to_non_nullable
as double,level5: null == level5 ? _self.level5 : level5 // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ElevationTokens].
extension ElevationTokensPatterns on ElevationTokens {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ElevationTokens value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ElevationTokens() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ElevationTokens value)  $default,){
final _that = this;
switch (_that) {
case _ElevationTokens():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ElevationTokens value)?  $default,){
final _that = this;
switch (_that) {
case _ElevationTokens() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double level0,  double level1,  double level2,  double level3,  double level4,  double level5)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ElevationTokens() when $default != null:
return $default(_that.level0,_that.level1,_that.level2,_that.level3,_that.level4,_that.level5);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double level0,  double level1,  double level2,  double level3,  double level4,  double level5)  $default,) {final _that = this;
switch (_that) {
case _ElevationTokens():
return $default(_that.level0,_that.level1,_that.level2,_that.level3,_that.level4,_that.level5);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double level0,  double level1,  double level2,  double level3,  double level4,  double level5)?  $default,) {final _that = this;
switch (_that) {
case _ElevationTokens() when $default != null:
return $default(_that.level0,_that.level1,_that.level2,_that.level3,_that.level4,_that.level5);case _:
  return null;

}
}

}

/// @nodoc


class _ElevationTokens implements ElevationTokens {
  const _ElevationTokens({required this.level0, required this.level1, required this.level2, required this.level3, required this.level4, required this.level5});
  

/// エレベーションなし
@override final  double level0;
/// レベル1（わずかな浮き上がり）
@override final  double level1;
/// レベル2（標準的な浮き上がり）
@override final  double level2;
/// レベル3（明確な浮き上がり）
@override final  double level3;
/// レベル4（強い浮き上がり）
@override final  double level4;
/// レベル5（最大の浮き上がり）
@override final  double level5;

/// Create a copy of ElevationTokens
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ElevationTokensCopyWith<_ElevationTokens> get copyWith => __$ElevationTokensCopyWithImpl<_ElevationTokens>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ElevationTokens&&(identical(other.level0, level0) || other.level0 == level0)&&(identical(other.level1, level1) || other.level1 == level1)&&(identical(other.level2, level2) || other.level2 == level2)&&(identical(other.level3, level3) || other.level3 == level3)&&(identical(other.level4, level4) || other.level4 == level4)&&(identical(other.level5, level5) || other.level5 == level5));
}


@override
int get hashCode => Object.hash(runtimeType,level0,level1,level2,level3,level4,level5);

@override
String toString() {
  return 'ElevationTokens(level0: $level0, level1: $level1, level2: $level2, level3: $level3, level4: $level4, level5: $level5)';
}


}

/// @nodoc
abstract mixin class _$ElevationTokensCopyWith<$Res> implements $ElevationTokensCopyWith<$Res> {
  factory _$ElevationTokensCopyWith(_ElevationTokens value, $Res Function(_ElevationTokens) _then) = __$ElevationTokensCopyWithImpl;
@override @useResult
$Res call({
 double level0, double level1, double level2, double level3, double level4, double level5
});




}
/// @nodoc
class __$ElevationTokensCopyWithImpl<$Res>
    implements _$ElevationTokensCopyWith<$Res> {
  __$ElevationTokensCopyWithImpl(this._self, this._then);

  final _ElevationTokens _self;
  final $Res Function(_ElevationTokens) _then;

/// Create a copy of ElevationTokens
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? level0 = null,Object? level1 = null,Object? level2 = null,Object? level3 = null,Object? level4 = null,Object? level5 = null,}) {
  return _then(_ElevationTokens(
level0: null == level0 ? _self.level0 : level0 // ignore: cast_nullable_to_non_nullable
as double,level1: null == level1 ? _self.level1 : level1 // ignore: cast_nullable_to_non_nullable
as double,level2: null == level2 ? _self.level2 : level2 // ignore: cast_nullable_to_non_nullable
as double,level3: null == level3 ? _self.level3 : level3 // ignore: cast_nullable_to_non_nullable
as double,level4: null == level4 ? _self.level4 : level4 // ignore: cast_nullable_to_non_nullable
as double,level5: null == level5 ? _self.level5 : level5 // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$ComponentElevationTokens {

/// サーフェス（背景）
 double get surface;/// カード
 double get card;/// ボタン（ElevatedButton）
 double get button;/// FAB（FloatingActionButton）
 double get fab;/// ナビゲーションバー
 double get navigationBar;/// アプリバー
 double get appBar;/// ドロワー
 double get drawer;/// モーダル・ダイアログ
 double get modal;/// メニュー・ドロップダウン
 double get menu;/// スナックバー
 double get snackbar;/// ツールチップ
 double get tooltip;/// ボトムシート
 double get bottomSheet;/// タブバー
 double get tabBar;/// チップ
 double get chip;
/// Create a copy of ComponentElevationTokens
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComponentElevationTokensCopyWith<ComponentElevationTokens> get copyWith => _$ComponentElevationTokensCopyWithImpl<ComponentElevationTokens>(this as ComponentElevationTokens, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComponentElevationTokens&&(identical(other.surface, surface) || other.surface == surface)&&(identical(other.card, card) || other.card == card)&&(identical(other.button, button) || other.button == button)&&(identical(other.fab, fab) || other.fab == fab)&&(identical(other.navigationBar, navigationBar) || other.navigationBar == navigationBar)&&(identical(other.appBar, appBar) || other.appBar == appBar)&&(identical(other.drawer, drawer) || other.drawer == drawer)&&(identical(other.modal, modal) || other.modal == modal)&&(identical(other.menu, menu) || other.menu == menu)&&(identical(other.snackbar, snackbar) || other.snackbar == snackbar)&&(identical(other.tooltip, tooltip) || other.tooltip == tooltip)&&(identical(other.bottomSheet, bottomSheet) || other.bottomSheet == bottomSheet)&&(identical(other.tabBar, tabBar) || other.tabBar == tabBar)&&(identical(other.chip, chip) || other.chip == chip));
}


@override
int get hashCode => Object.hash(runtimeType,surface,card,button,fab,navigationBar,appBar,drawer,modal,menu,snackbar,tooltip,bottomSheet,tabBar,chip);

@override
String toString() {
  return 'ComponentElevationTokens(surface: $surface, card: $card, button: $button, fab: $fab, navigationBar: $navigationBar, appBar: $appBar, drawer: $drawer, modal: $modal, menu: $menu, snackbar: $snackbar, tooltip: $tooltip, bottomSheet: $bottomSheet, tabBar: $tabBar, chip: $chip)';
}


}

/// @nodoc
abstract mixin class $ComponentElevationTokensCopyWith<$Res>  {
  factory $ComponentElevationTokensCopyWith(ComponentElevationTokens value, $Res Function(ComponentElevationTokens) _then) = _$ComponentElevationTokensCopyWithImpl;
@useResult
$Res call({
 double surface, double card, double button, double fab, double navigationBar, double appBar, double drawer, double modal, double menu, double snackbar, double tooltip, double bottomSheet, double tabBar, double chip
});




}
/// @nodoc
class _$ComponentElevationTokensCopyWithImpl<$Res>
    implements $ComponentElevationTokensCopyWith<$Res> {
  _$ComponentElevationTokensCopyWithImpl(this._self, this._then);

  final ComponentElevationTokens _self;
  final $Res Function(ComponentElevationTokens) _then;

/// Create a copy of ComponentElevationTokens
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? surface = null,Object? card = null,Object? button = null,Object? fab = null,Object? navigationBar = null,Object? appBar = null,Object? drawer = null,Object? modal = null,Object? menu = null,Object? snackbar = null,Object? tooltip = null,Object? bottomSheet = null,Object? tabBar = null,Object? chip = null,}) {
  return _then(_self.copyWith(
surface: null == surface ? _self.surface : surface // ignore: cast_nullable_to_non_nullable
as double,card: null == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as double,button: null == button ? _self.button : button // ignore: cast_nullable_to_non_nullable
as double,fab: null == fab ? _self.fab : fab // ignore: cast_nullable_to_non_nullable
as double,navigationBar: null == navigationBar ? _self.navigationBar : navigationBar // ignore: cast_nullable_to_non_nullable
as double,appBar: null == appBar ? _self.appBar : appBar // ignore: cast_nullable_to_non_nullable
as double,drawer: null == drawer ? _self.drawer : drawer // ignore: cast_nullable_to_non_nullable
as double,modal: null == modal ? _self.modal : modal // ignore: cast_nullable_to_non_nullable
as double,menu: null == menu ? _self.menu : menu // ignore: cast_nullable_to_non_nullable
as double,snackbar: null == snackbar ? _self.snackbar : snackbar // ignore: cast_nullable_to_non_nullable
as double,tooltip: null == tooltip ? _self.tooltip : tooltip // ignore: cast_nullable_to_non_nullable
as double,bottomSheet: null == bottomSheet ? _self.bottomSheet : bottomSheet // ignore: cast_nullable_to_non_nullable
as double,tabBar: null == tabBar ? _self.tabBar : tabBar // ignore: cast_nullable_to_non_nullable
as double,chip: null == chip ? _self.chip : chip // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ComponentElevationTokens].
extension ComponentElevationTokensPatterns on ComponentElevationTokens {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ComponentElevationTokens value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ComponentElevationTokens() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ComponentElevationTokens value)  $default,){
final _that = this;
switch (_that) {
case _ComponentElevationTokens():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ComponentElevationTokens value)?  $default,){
final _that = this;
switch (_that) {
case _ComponentElevationTokens() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double surface,  double card,  double button,  double fab,  double navigationBar,  double appBar,  double drawer,  double modal,  double menu,  double snackbar,  double tooltip,  double bottomSheet,  double tabBar,  double chip)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ComponentElevationTokens() when $default != null:
return $default(_that.surface,_that.card,_that.button,_that.fab,_that.navigationBar,_that.appBar,_that.drawer,_that.modal,_that.menu,_that.snackbar,_that.tooltip,_that.bottomSheet,_that.tabBar,_that.chip);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double surface,  double card,  double button,  double fab,  double navigationBar,  double appBar,  double drawer,  double modal,  double menu,  double snackbar,  double tooltip,  double bottomSheet,  double tabBar,  double chip)  $default,) {final _that = this;
switch (_that) {
case _ComponentElevationTokens():
return $default(_that.surface,_that.card,_that.button,_that.fab,_that.navigationBar,_that.appBar,_that.drawer,_that.modal,_that.menu,_that.snackbar,_that.tooltip,_that.bottomSheet,_that.tabBar,_that.chip);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double surface,  double card,  double button,  double fab,  double navigationBar,  double appBar,  double drawer,  double modal,  double menu,  double snackbar,  double tooltip,  double bottomSheet,  double tabBar,  double chip)?  $default,) {final _that = this;
switch (_that) {
case _ComponentElevationTokens() when $default != null:
return $default(_that.surface,_that.card,_that.button,_that.fab,_that.navigationBar,_that.appBar,_that.drawer,_that.modal,_that.menu,_that.snackbar,_that.tooltip,_that.bottomSheet,_that.tabBar,_that.chip);case _:
  return null;

}
}

}

/// @nodoc


class _ComponentElevationTokens implements ComponentElevationTokens {
  const _ComponentElevationTokens({required this.surface, required this.card, required this.button, required this.fab, required this.navigationBar, required this.appBar, required this.drawer, required this.modal, required this.menu, required this.snackbar, required this.tooltip, required this.bottomSheet, required this.tabBar, required this.chip});
  

/// サーフェス（背景）
@override final  double surface;
/// カード
@override final  double card;
/// ボタン（ElevatedButton）
@override final  double button;
/// FAB（FloatingActionButton）
@override final  double fab;
/// ナビゲーションバー
@override final  double navigationBar;
/// アプリバー
@override final  double appBar;
/// ドロワー
@override final  double drawer;
/// モーダル・ダイアログ
@override final  double modal;
/// メニュー・ドロップダウン
@override final  double menu;
/// スナックバー
@override final  double snackbar;
/// ツールチップ
@override final  double tooltip;
/// ボトムシート
@override final  double bottomSheet;
/// タブバー
@override final  double tabBar;
/// チップ
@override final  double chip;

/// Create a copy of ComponentElevationTokens
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ComponentElevationTokensCopyWith<_ComponentElevationTokens> get copyWith => __$ComponentElevationTokensCopyWithImpl<_ComponentElevationTokens>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ComponentElevationTokens&&(identical(other.surface, surface) || other.surface == surface)&&(identical(other.card, card) || other.card == card)&&(identical(other.button, button) || other.button == button)&&(identical(other.fab, fab) || other.fab == fab)&&(identical(other.navigationBar, navigationBar) || other.navigationBar == navigationBar)&&(identical(other.appBar, appBar) || other.appBar == appBar)&&(identical(other.drawer, drawer) || other.drawer == drawer)&&(identical(other.modal, modal) || other.modal == modal)&&(identical(other.menu, menu) || other.menu == menu)&&(identical(other.snackbar, snackbar) || other.snackbar == snackbar)&&(identical(other.tooltip, tooltip) || other.tooltip == tooltip)&&(identical(other.bottomSheet, bottomSheet) || other.bottomSheet == bottomSheet)&&(identical(other.tabBar, tabBar) || other.tabBar == tabBar)&&(identical(other.chip, chip) || other.chip == chip));
}


@override
int get hashCode => Object.hash(runtimeType,surface,card,button,fab,navigationBar,appBar,drawer,modal,menu,snackbar,tooltip,bottomSheet,tabBar,chip);

@override
String toString() {
  return 'ComponentElevationTokens(surface: $surface, card: $card, button: $button, fab: $fab, navigationBar: $navigationBar, appBar: $appBar, drawer: $drawer, modal: $modal, menu: $menu, snackbar: $snackbar, tooltip: $tooltip, bottomSheet: $bottomSheet, tabBar: $tabBar, chip: $chip)';
}


}

/// @nodoc
abstract mixin class _$ComponentElevationTokensCopyWith<$Res> implements $ComponentElevationTokensCopyWith<$Res> {
  factory _$ComponentElevationTokensCopyWith(_ComponentElevationTokens value, $Res Function(_ComponentElevationTokens) _then) = __$ComponentElevationTokensCopyWithImpl;
@override @useResult
$Res call({
 double surface, double card, double button, double fab, double navigationBar, double appBar, double drawer, double modal, double menu, double snackbar, double tooltip, double bottomSheet, double tabBar, double chip
});




}
/// @nodoc
class __$ComponentElevationTokensCopyWithImpl<$Res>
    implements _$ComponentElevationTokensCopyWith<$Res> {
  __$ComponentElevationTokensCopyWithImpl(this._self, this._then);

  final _ComponentElevationTokens _self;
  final $Res Function(_ComponentElevationTokens) _then;

/// Create a copy of ComponentElevationTokens
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? surface = null,Object? card = null,Object? button = null,Object? fab = null,Object? navigationBar = null,Object? appBar = null,Object? drawer = null,Object? modal = null,Object? menu = null,Object? snackbar = null,Object? tooltip = null,Object? bottomSheet = null,Object? tabBar = null,Object? chip = null,}) {
  return _then(_ComponentElevationTokens(
surface: null == surface ? _self.surface : surface // ignore: cast_nullable_to_non_nullable
as double,card: null == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as double,button: null == button ? _self.button : button // ignore: cast_nullable_to_non_nullable
as double,fab: null == fab ? _self.fab : fab // ignore: cast_nullable_to_non_nullable
as double,navigationBar: null == navigationBar ? _self.navigationBar : navigationBar // ignore: cast_nullable_to_non_nullable
as double,appBar: null == appBar ? _self.appBar : appBar // ignore: cast_nullable_to_non_nullable
as double,drawer: null == drawer ? _self.drawer : drawer // ignore: cast_nullable_to_non_nullable
as double,modal: null == modal ? _self.modal : modal // ignore: cast_nullable_to_non_nullable
as double,menu: null == menu ? _self.menu : menu // ignore: cast_nullable_to_non_nullable
as double,snackbar: null == snackbar ? _self.snackbar : snackbar // ignore: cast_nullable_to_non_nullable
as double,tooltip: null == tooltip ? _self.tooltip : tooltip // ignore: cast_nullable_to_non_nullable
as double,bottomSheet: null == bottomSheet ? _self.bottomSheet : bottomSheet // ignore: cast_nullable_to_non_nullable
as double,tabBar: null == tabBar ? _self.tabBar : tabBar // ignore: cast_nullable_to_non_nullable
as double,chip: null == chip ? _self.chip : chip // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$ShadowTokens {

/// 基本シャドウ色
 Color get shadow;/// アンビエントシャドウ色
 Color get ambient;/// キーシャドウ色
 Color get key;/// サーフェスシャドウ色
 Color get surface;
/// Create a copy of ShadowTokens
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShadowTokensCopyWith<ShadowTokens> get copyWith => _$ShadowTokensCopyWithImpl<ShadowTokens>(this as ShadowTokens, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShadowTokens&&(identical(other.shadow, shadow) || other.shadow == shadow)&&(identical(other.ambient, ambient) || other.ambient == ambient)&&(identical(other.key, key) || other.key == key)&&(identical(other.surface, surface) || other.surface == surface));
}


@override
int get hashCode => Object.hash(runtimeType,shadow,ambient,key,surface);

@override
String toString() {
  return 'ShadowTokens(shadow: $shadow, ambient: $ambient, key: $key, surface: $surface)';
}


}

/// @nodoc
abstract mixin class $ShadowTokensCopyWith<$Res>  {
  factory $ShadowTokensCopyWith(ShadowTokens value, $Res Function(ShadowTokens) _then) = _$ShadowTokensCopyWithImpl;
@useResult
$Res call({
 Color shadow, Color ambient, Color key, Color surface
});




}
/// @nodoc
class _$ShadowTokensCopyWithImpl<$Res>
    implements $ShadowTokensCopyWith<$Res> {
  _$ShadowTokensCopyWithImpl(this._self, this._then);

  final ShadowTokens _self;
  final $Res Function(ShadowTokens) _then;

/// Create a copy of ShadowTokens
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shadow = null,Object? ambient = null,Object? key = null,Object? surface = null,}) {
  return _then(_self.copyWith(
shadow: null == shadow ? _self.shadow : shadow // ignore: cast_nullable_to_non_nullable
as Color,ambient: null == ambient ? _self.ambient : ambient // ignore: cast_nullable_to_non_nullable
as Color,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as Color,surface: null == surface ? _self.surface : surface // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}

}


/// Adds pattern-matching-related methods to [ShadowTokens].
extension ShadowTokensPatterns on ShadowTokens {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShadowTokens value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShadowTokens() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShadowTokens value)  $default,){
final _that = this;
switch (_that) {
case _ShadowTokens():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShadowTokens value)?  $default,){
final _that = this;
switch (_that) {
case _ShadowTokens() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Color shadow,  Color ambient,  Color key,  Color surface)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShadowTokens() when $default != null:
return $default(_that.shadow,_that.ambient,_that.key,_that.surface);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Color shadow,  Color ambient,  Color key,  Color surface)  $default,) {final _that = this;
switch (_that) {
case _ShadowTokens():
return $default(_that.shadow,_that.ambient,_that.key,_that.surface);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Color shadow,  Color ambient,  Color key,  Color surface)?  $default,) {final _that = this;
switch (_that) {
case _ShadowTokens() when $default != null:
return $default(_that.shadow,_that.ambient,_that.key,_that.surface);case _:
  return null;

}
}

}

/// @nodoc


class _ShadowTokens implements ShadowTokens {
  const _ShadowTokens({required this.shadow, required this.ambient, required this.key, required this.surface});
  

/// 基本シャドウ色
@override final  Color shadow;
/// アンビエントシャドウ色
@override final  Color ambient;
/// キーシャドウ色
@override final  Color key;
/// サーフェスシャドウ色
@override final  Color surface;

/// Create a copy of ShadowTokens
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShadowTokensCopyWith<_ShadowTokens> get copyWith => __$ShadowTokensCopyWithImpl<_ShadowTokens>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShadowTokens&&(identical(other.shadow, shadow) || other.shadow == shadow)&&(identical(other.ambient, ambient) || other.ambient == ambient)&&(identical(other.key, key) || other.key == key)&&(identical(other.surface, surface) || other.surface == surface));
}


@override
int get hashCode => Object.hash(runtimeType,shadow,ambient,key,surface);

@override
String toString() {
  return 'ShadowTokens(shadow: $shadow, ambient: $ambient, key: $key, surface: $surface)';
}


}

/// @nodoc
abstract mixin class _$ShadowTokensCopyWith<$Res> implements $ShadowTokensCopyWith<$Res> {
  factory _$ShadowTokensCopyWith(_ShadowTokens value, $Res Function(_ShadowTokens) _then) = __$ShadowTokensCopyWithImpl;
@override @useResult
$Res call({
 Color shadow, Color ambient, Color key, Color surface
});




}
/// @nodoc
class __$ShadowTokensCopyWithImpl<$Res>
    implements _$ShadowTokensCopyWith<$Res> {
  __$ShadowTokensCopyWithImpl(this._self, this._then);

  final _ShadowTokens _self;
  final $Res Function(_ShadowTokens) _then;

/// Create a copy of ShadowTokens
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shadow = null,Object? ambient = null,Object? key = null,Object? surface = null,}) {
  return _then(_ShadowTokens(
shadow: null == shadow ? _self.shadow : shadow // ignore: cast_nullable_to_non_nullable
as Color,ambient: null == ambient ? _self.ambient : ambient // ignore: cast_nullable_to_non_nullable
as Color,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as Color,surface: null == surface ? _self.surface : surface // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}


}

// dart format on
