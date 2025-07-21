// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'typography_tokens.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TypographyTokens {

/// ディスプレイ系統（最大サイズ）
 DisplayTokens get display;/// ヘッドライン系統
 HeadlineTokens get headline;/// タイトル系統
 TitleTokens get title;/// ラベル系統
 LabelTokens get label;/// ボディ系統
 BodyTokens get body;
/// Create a copy of TypographyTokens
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TypographyTokensCopyWith<TypographyTokens> get copyWith => _$TypographyTokensCopyWithImpl<TypographyTokens>(this as TypographyTokens, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TypographyTokens&&(identical(other.display, display) || other.display == display)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.title, title) || other.title == title)&&(identical(other.label, label) || other.label == label)&&(identical(other.body, body) || other.body == body));
}


@override
int get hashCode => Object.hash(runtimeType,display,headline,title,label,body);

@override
String toString() {
  return 'TypographyTokens(display: $display, headline: $headline, title: $title, label: $label, body: $body)';
}


}

/// @nodoc
abstract mixin class $TypographyTokensCopyWith<$Res>  {
  factory $TypographyTokensCopyWith(TypographyTokens value, $Res Function(TypographyTokens) _then) = _$TypographyTokensCopyWithImpl;
@useResult
$Res call({
 DisplayTokens display, HeadlineTokens headline, TitleTokens title, LabelTokens label, BodyTokens body
});


$DisplayTokensCopyWith<$Res> get display;$HeadlineTokensCopyWith<$Res> get headline;$TitleTokensCopyWith<$Res> get title;$LabelTokensCopyWith<$Res> get label;$BodyTokensCopyWith<$Res> get body;

}
/// @nodoc
class _$TypographyTokensCopyWithImpl<$Res>
    implements $TypographyTokensCopyWith<$Res> {
  _$TypographyTokensCopyWithImpl(this._self, this._then);

  final TypographyTokens _self;
  final $Res Function(TypographyTokens) _then;

/// Create a copy of TypographyTokens
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? display = null,Object? headline = null,Object? title = null,Object? label = null,Object? body = null,}) {
  return _then(_self.copyWith(
display: null == display ? _self.display : display // ignore: cast_nullable_to_non_nullable
as DisplayTokens,headline: null == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as HeadlineTokens,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as TitleTokens,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as LabelTokens,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as BodyTokens,
  ));
}
/// Create a copy of TypographyTokens
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DisplayTokensCopyWith<$Res> get display {
  
  return $DisplayTokensCopyWith<$Res>(_self.display, (value) {
    return _then(_self.copyWith(display: value));
  });
}/// Create a copy of TypographyTokens
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HeadlineTokensCopyWith<$Res> get headline {
  
  return $HeadlineTokensCopyWith<$Res>(_self.headline, (value) {
    return _then(_self.copyWith(headline: value));
  });
}/// Create a copy of TypographyTokens
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TitleTokensCopyWith<$Res> get title {
  
  return $TitleTokensCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of TypographyTokens
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LabelTokensCopyWith<$Res> get label {
  
  return $LabelTokensCopyWith<$Res>(_self.label, (value) {
    return _then(_self.copyWith(label: value));
  });
}/// Create a copy of TypographyTokens
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BodyTokensCopyWith<$Res> get body {
  
  return $BodyTokensCopyWith<$Res>(_self.body, (value) {
    return _then(_self.copyWith(body: value));
  });
}
}


/// Adds pattern-matching-related methods to [TypographyTokens].
extension TypographyTokensPatterns on TypographyTokens {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TypographyTokens value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TypographyTokens() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TypographyTokens value)  $default,){
final _that = this;
switch (_that) {
case _TypographyTokens():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TypographyTokens value)?  $default,){
final _that = this;
switch (_that) {
case _TypographyTokens() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DisplayTokens display,  HeadlineTokens headline,  TitleTokens title,  LabelTokens label,  BodyTokens body)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TypographyTokens() when $default != null:
return $default(_that.display,_that.headline,_that.title,_that.label,_that.body);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DisplayTokens display,  HeadlineTokens headline,  TitleTokens title,  LabelTokens label,  BodyTokens body)  $default,) {final _that = this;
switch (_that) {
case _TypographyTokens():
return $default(_that.display,_that.headline,_that.title,_that.label,_that.body);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DisplayTokens display,  HeadlineTokens headline,  TitleTokens title,  LabelTokens label,  BodyTokens body)?  $default,) {final _that = this;
switch (_that) {
case _TypographyTokens() when $default != null:
return $default(_that.display,_that.headline,_that.title,_that.label,_that.body);case _:
  return null;

}
}

}

/// @nodoc


class _TypographyTokens implements TypographyTokens {
  const _TypographyTokens({required this.display, required this.headline, required this.title, required this.label, required this.body});
  

/// ディスプレイ系統（最大サイズ）
@override final  DisplayTokens display;
/// ヘッドライン系統
@override final  HeadlineTokens headline;
/// タイトル系統
@override final  TitleTokens title;
/// ラベル系統
@override final  LabelTokens label;
/// ボディ系統
@override final  BodyTokens body;

/// Create a copy of TypographyTokens
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TypographyTokensCopyWith<_TypographyTokens> get copyWith => __$TypographyTokensCopyWithImpl<_TypographyTokens>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TypographyTokens&&(identical(other.display, display) || other.display == display)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.title, title) || other.title == title)&&(identical(other.label, label) || other.label == label)&&(identical(other.body, body) || other.body == body));
}


@override
int get hashCode => Object.hash(runtimeType,display,headline,title,label,body);

@override
String toString() {
  return 'TypographyTokens(display: $display, headline: $headline, title: $title, label: $label, body: $body)';
}


}

/// @nodoc
abstract mixin class _$TypographyTokensCopyWith<$Res> implements $TypographyTokensCopyWith<$Res> {
  factory _$TypographyTokensCopyWith(_TypographyTokens value, $Res Function(_TypographyTokens) _then) = __$TypographyTokensCopyWithImpl;
@override @useResult
$Res call({
 DisplayTokens display, HeadlineTokens headline, TitleTokens title, LabelTokens label, BodyTokens body
});


@override $DisplayTokensCopyWith<$Res> get display;@override $HeadlineTokensCopyWith<$Res> get headline;@override $TitleTokensCopyWith<$Res> get title;@override $LabelTokensCopyWith<$Res> get label;@override $BodyTokensCopyWith<$Res> get body;

}
/// @nodoc
class __$TypographyTokensCopyWithImpl<$Res>
    implements _$TypographyTokensCopyWith<$Res> {
  __$TypographyTokensCopyWithImpl(this._self, this._then);

  final _TypographyTokens _self;
  final $Res Function(_TypographyTokens) _then;

/// Create a copy of TypographyTokens
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? display = null,Object? headline = null,Object? title = null,Object? label = null,Object? body = null,}) {
  return _then(_TypographyTokens(
display: null == display ? _self.display : display // ignore: cast_nullable_to_non_nullable
as DisplayTokens,headline: null == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as HeadlineTokens,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as TitleTokens,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as LabelTokens,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as BodyTokens,
  ));
}

/// Create a copy of TypographyTokens
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DisplayTokensCopyWith<$Res> get display {
  
  return $DisplayTokensCopyWith<$Res>(_self.display, (value) {
    return _then(_self.copyWith(display: value));
  });
}/// Create a copy of TypographyTokens
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HeadlineTokensCopyWith<$Res> get headline {
  
  return $HeadlineTokensCopyWith<$Res>(_self.headline, (value) {
    return _then(_self.copyWith(headline: value));
  });
}/// Create a copy of TypographyTokens
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TitleTokensCopyWith<$Res> get title {
  
  return $TitleTokensCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of TypographyTokens
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LabelTokensCopyWith<$Res> get label {
  
  return $LabelTokensCopyWith<$Res>(_self.label, (value) {
    return _then(_self.copyWith(label: value));
  });
}/// Create a copy of TypographyTokens
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BodyTokensCopyWith<$Res> get body {
  
  return $BodyTokensCopyWith<$Res>(_self.body, (value) {
    return _then(_self.copyWith(body: value));
  });
}
}

/// @nodoc
mixin _$DisplayTokens {

/// Display Large (最大サイズ、ランディングページなど)
 TextStyle get displayLarge;/// Display Medium
 TextStyle get displayMedium;/// Display Small
 TextStyle get displaySmall;
/// Create a copy of DisplayTokens
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DisplayTokensCopyWith<DisplayTokens> get copyWith => _$DisplayTokensCopyWithImpl<DisplayTokens>(this as DisplayTokens, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DisplayTokens&&(identical(other.displayLarge, displayLarge) || other.displayLarge == displayLarge)&&(identical(other.displayMedium, displayMedium) || other.displayMedium == displayMedium)&&(identical(other.displaySmall, displaySmall) || other.displaySmall == displaySmall));
}


@override
int get hashCode => Object.hash(runtimeType,displayLarge,displayMedium,displaySmall);

@override
String toString() {
  return 'DisplayTokens(displayLarge: $displayLarge, displayMedium: $displayMedium, displaySmall: $displaySmall)';
}


}

/// @nodoc
abstract mixin class $DisplayTokensCopyWith<$Res>  {
  factory $DisplayTokensCopyWith(DisplayTokens value, $Res Function(DisplayTokens) _then) = _$DisplayTokensCopyWithImpl;
@useResult
$Res call({
 TextStyle displayLarge, TextStyle displayMedium, TextStyle displaySmall
});




}
/// @nodoc
class _$DisplayTokensCopyWithImpl<$Res>
    implements $DisplayTokensCopyWith<$Res> {
  _$DisplayTokensCopyWithImpl(this._self, this._then);

  final DisplayTokens _self;
  final $Res Function(DisplayTokens) _then;

/// Create a copy of DisplayTokens
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayLarge = null,Object? displayMedium = null,Object? displaySmall = null,}) {
  return _then(_self.copyWith(
displayLarge: null == displayLarge ? _self.displayLarge : displayLarge // ignore: cast_nullable_to_non_nullable
as TextStyle,displayMedium: null == displayMedium ? _self.displayMedium : displayMedium // ignore: cast_nullable_to_non_nullable
as TextStyle,displaySmall: null == displaySmall ? _self.displaySmall : displaySmall // ignore: cast_nullable_to_non_nullable
as TextStyle,
  ));
}

}


/// Adds pattern-matching-related methods to [DisplayTokens].
extension DisplayTokensPatterns on DisplayTokens {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DisplayTokens value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DisplayTokens() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DisplayTokens value)  $default,){
final _that = this;
switch (_that) {
case _DisplayTokens():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DisplayTokens value)?  $default,){
final _that = this;
switch (_that) {
case _DisplayTokens() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TextStyle displayLarge,  TextStyle displayMedium,  TextStyle displaySmall)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DisplayTokens() when $default != null:
return $default(_that.displayLarge,_that.displayMedium,_that.displaySmall);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TextStyle displayLarge,  TextStyle displayMedium,  TextStyle displaySmall)  $default,) {final _that = this;
switch (_that) {
case _DisplayTokens():
return $default(_that.displayLarge,_that.displayMedium,_that.displaySmall);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TextStyle displayLarge,  TextStyle displayMedium,  TextStyle displaySmall)?  $default,) {final _that = this;
switch (_that) {
case _DisplayTokens() when $default != null:
return $default(_that.displayLarge,_that.displayMedium,_that.displaySmall);case _:
  return null;

}
}

}

/// @nodoc


class _DisplayTokens implements DisplayTokens {
  const _DisplayTokens({required this.displayLarge, required this.displayMedium, required this.displaySmall});
  

/// Display Large (最大サイズ、ランディングページなど)
@override final  TextStyle displayLarge;
/// Display Medium
@override final  TextStyle displayMedium;
/// Display Small
@override final  TextStyle displaySmall;

/// Create a copy of DisplayTokens
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DisplayTokensCopyWith<_DisplayTokens> get copyWith => __$DisplayTokensCopyWithImpl<_DisplayTokens>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DisplayTokens&&(identical(other.displayLarge, displayLarge) || other.displayLarge == displayLarge)&&(identical(other.displayMedium, displayMedium) || other.displayMedium == displayMedium)&&(identical(other.displaySmall, displaySmall) || other.displaySmall == displaySmall));
}


@override
int get hashCode => Object.hash(runtimeType,displayLarge,displayMedium,displaySmall);

@override
String toString() {
  return 'DisplayTokens(displayLarge: $displayLarge, displayMedium: $displayMedium, displaySmall: $displaySmall)';
}


}

/// @nodoc
abstract mixin class _$DisplayTokensCopyWith<$Res> implements $DisplayTokensCopyWith<$Res> {
  factory _$DisplayTokensCopyWith(_DisplayTokens value, $Res Function(_DisplayTokens) _then) = __$DisplayTokensCopyWithImpl;
@override @useResult
$Res call({
 TextStyle displayLarge, TextStyle displayMedium, TextStyle displaySmall
});




}
/// @nodoc
class __$DisplayTokensCopyWithImpl<$Res>
    implements _$DisplayTokensCopyWith<$Res> {
  __$DisplayTokensCopyWithImpl(this._self, this._then);

  final _DisplayTokens _self;
  final $Res Function(_DisplayTokens) _then;

/// Create a copy of DisplayTokens
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayLarge = null,Object? displayMedium = null,Object? displaySmall = null,}) {
  return _then(_DisplayTokens(
displayLarge: null == displayLarge ? _self.displayLarge : displayLarge // ignore: cast_nullable_to_non_nullable
as TextStyle,displayMedium: null == displayMedium ? _self.displayMedium : displayMedium // ignore: cast_nullable_to_non_nullable
as TextStyle,displaySmall: null == displaySmall ? _self.displaySmall : displaySmall // ignore: cast_nullable_to_non_nullable
as TextStyle,
  ));
}


}

/// @nodoc
mixin _$HeadlineTokens {

/// Headline Large (主要見出し)
 TextStyle get headlineLarge;/// Headline Medium (セクション見出し)
 TextStyle get headlineMedium;/// Headline Small (サブセクション見出し)
 TextStyle get headlineSmall;
/// Create a copy of HeadlineTokens
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HeadlineTokensCopyWith<HeadlineTokens> get copyWith => _$HeadlineTokensCopyWithImpl<HeadlineTokens>(this as HeadlineTokens, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HeadlineTokens&&(identical(other.headlineLarge, headlineLarge) || other.headlineLarge == headlineLarge)&&(identical(other.headlineMedium, headlineMedium) || other.headlineMedium == headlineMedium)&&(identical(other.headlineSmall, headlineSmall) || other.headlineSmall == headlineSmall));
}


@override
int get hashCode => Object.hash(runtimeType,headlineLarge,headlineMedium,headlineSmall);

@override
String toString() {
  return 'HeadlineTokens(headlineLarge: $headlineLarge, headlineMedium: $headlineMedium, headlineSmall: $headlineSmall)';
}


}

/// @nodoc
abstract mixin class $HeadlineTokensCopyWith<$Res>  {
  factory $HeadlineTokensCopyWith(HeadlineTokens value, $Res Function(HeadlineTokens) _then) = _$HeadlineTokensCopyWithImpl;
@useResult
$Res call({
 TextStyle headlineLarge, TextStyle headlineMedium, TextStyle headlineSmall
});




}
/// @nodoc
class _$HeadlineTokensCopyWithImpl<$Res>
    implements $HeadlineTokensCopyWith<$Res> {
  _$HeadlineTokensCopyWithImpl(this._self, this._then);

  final HeadlineTokens _self;
  final $Res Function(HeadlineTokens) _then;

/// Create a copy of HeadlineTokens
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? headlineLarge = null,Object? headlineMedium = null,Object? headlineSmall = null,}) {
  return _then(_self.copyWith(
headlineLarge: null == headlineLarge ? _self.headlineLarge : headlineLarge // ignore: cast_nullable_to_non_nullable
as TextStyle,headlineMedium: null == headlineMedium ? _self.headlineMedium : headlineMedium // ignore: cast_nullable_to_non_nullable
as TextStyle,headlineSmall: null == headlineSmall ? _self.headlineSmall : headlineSmall // ignore: cast_nullable_to_non_nullable
as TextStyle,
  ));
}

}


/// Adds pattern-matching-related methods to [HeadlineTokens].
extension HeadlineTokensPatterns on HeadlineTokens {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HeadlineTokens value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HeadlineTokens() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HeadlineTokens value)  $default,){
final _that = this;
switch (_that) {
case _HeadlineTokens():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HeadlineTokens value)?  $default,){
final _that = this;
switch (_that) {
case _HeadlineTokens() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TextStyle headlineLarge,  TextStyle headlineMedium,  TextStyle headlineSmall)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HeadlineTokens() when $default != null:
return $default(_that.headlineLarge,_that.headlineMedium,_that.headlineSmall);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TextStyle headlineLarge,  TextStyle headlineMedium,  TextStyle headlineSmall)  $default,) {final _that = this;
switch (_that) {
case _HeadlineTokens():
return $default(_that.headlineLarge,_that.headlineMedium,_that.headlineSmall);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TextStyle headlineLarge,  TextStyle headlineMedium,  TextStyle headlineSmall)?  $default,) {final _that = this;
switch (_that) {
case _HeadlineTokens() when $default != null:
return $default(_that.headlineLarge,_that.headlineMedium,_that.headlineSmall);case _:
  return null;

}
}

}

/// @nodoc


class _HeadlineTokens implements HeadlineTokens {
  const _HeadlineTokens({required this.headlineLarge, required this.headlineMedium, required this.headlineSmall});
  

/// Headline Large (主要見出し)
@override final  TextStyle headlineLarge;
/// Headline Medium (セクション見出し)
@override final  TextStyle headlineMedium;
/// Headline Small (サブセクション見出し)
@override final  TextStyle headlineSmall;

/// Create a copy of HeadlineTokens
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HeadlineTokensCopyWith<_HeadlineTokens> get copyWith => __$HeadlineTokensCopyWithImpl<_HeadlineTokens>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HeadlineTokens&&(identical(other.headlineLarge, headlineLarge) || other.headlineLarge == headlineLarge)&&(identical(other.headlineMedium, headlineMedium) || other.headlineMedium == headlineMedium)&&(identical(other.headlineSmall, headlineSmall) || other.headlineSmall == headlineSmall));
}


@override
int get hashCode => Object.hash(runtimeType,headlineLarge,headlineMedium,headlineSmall);

@override
String toString() {
  return 'HeadlineTokens(headlineLarge: $headlineLarge, headlineMedium: $headlineMedium, headlineSmall: $headlineSmall)';
}


}

/// @nodoc
abstract mixin class _$HeadlineTokensCopyWith<$Res> implements $HeadlineTokensCopyWith<$Res> {
  factory _$HeadlineTokensCopyWith(_HeadlineTokens value, $Res Function(_HeadlineTokens) _then) = __$HeadlineTokensCopyWithImpl;
@override @useResult
$Res call({
 TextStyle headlineLarge, TextStyle headlineMedium, TextStyle headlineSmall
});




}
/// @nodoc
class __$HeadlineTokensCopyWithImpl<$Res>
    implements _$HeadlineTokensCopyWith<$Res> {
  __$HeadlineTokensCopyWithImpl(this._self, this._then);

  final _HeadlineTokens _self;
  final $Res Function(_HeadlineTokens) _then;

/// Create a copy of HeadlineTokens
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? headlineLarge = null,Object? headlineMedium = null,Object? headlineSmall = null,}) {
  return _then(_HeadlineTokens(
headlineLarge: null == headlineLarge ? _self.headlineLarge : headlineLarge // ignore: cast_nullable_to_non_nullable
as TextStyle,headlineMedium: null == headlineMedium ? _self.headlineMedium : headlineMedium // ignore: cast_nullable_to_non_nullable
as TextStyle,headlineSmall: null == headlineSmall ? _self.headlineSmall : headlineSmall // ignore: cast_nullable_to_non_nullable
as TextStyle,
  ));
}


}

/// @nodoc
mixin _$TitleTokens {

/// Title Large (ページタイトル、ダイアログタイトル)
 TextStyle get titleLarge;/// Title Medium (カードタイトル、リストヘッダー)
 TextStyle get titleMedium;/// Title Small (サブタイトル、カテゴリラベル)
 TextStyle get titleSmall;
/// Create a copy of TitleTokens
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TitleTokensCopyWith<TitleTokens> get copyWith => _$TitleTokensCopyWithImpl<TitleTokens>(this as TitleTokens, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TitleTokens&&(identical(other.titleLarge, titleLarge) || other.titleLarge == titleLarge)&&(identical(other.titleMedium, titleMedium) || other.titleMedium == titleMedium)&&(identical(other.titleSmall, titleSmall) || other.titleSmall == titleSmall));
}


@override
int get hashCode => Object.hash(runtimeType,titleLarge,titleMedium,titleSmall);

@override
String toString() {
  return 'TitleTokens(titleLarge: $titleLarge, titleMedium: $titleMedium, titleSmall: $titleSmall)';
}


}

/// @nodoc
abstract mixin class $TitleTokensCopyWith<$Res>  {
  factory $TitleTokensCopyWith(TitleTokens value, $Res Function(TitleTokens) _then) = _$TitleTokensCopyWithImpl;
@useResult
$Res call({
 TextStyle titleLarge, TextStyle titleMedium, TextStyle titleSmall
});




}
/// @nodoc
class _$TitleTokensCopyWithImpl<$Res>
    implements $TitleTokensCopyWith<$Res> {
  _$TitleTokensCopyWithImpl(this._self, this._then);

  final TitleTokens _self;
  final $Res Function(TitleTokens) _then;

/// Create a copy of TitleTokens
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? titleLarge = null,Object? titleMedium = null,Object? titleSmall = null,}) {
  return _then(_self.copyWith(
titleLarge: null == titleLarge ? _self.titleLarge : titleLarge // ignore: cast_nullable_to_non_nullable
as TextStyle,titleMedium: null == titleMedium ? _self.titleMedium : titleMedium // ignore: cast_nullable_to_non_nullable
as TextStyle,titleSmall: null == titleSmall ? _self.titleSmall : titleSmall // ignore: cast_nullable_to_non_nullable
as TextStyle,
  ));
}

}


/// Adds pattern-matching-related methods to [TitleTokens].
extension TitleTokensPatterns on TitleTokens {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TitleTokens value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TitleTokens() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TitleTokens value)  $default,){
final _that = this;
switch (_that) {
case _TitleTokens():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TitleTokens value)?  $default,){
final _that = this;
switch (_that) {
case _TitleTokens() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TextStyle titleLarge,  TextStyle titleMedium,  TextStyle titleSmall)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TitleTokens() when $default != null:
return $default(_that.titleLarge,_that.titleMedium,_that.titleSmall);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TextStyle titleLarge,  TextStyle titleMedium,  TextStyle titleSmall)  $default,) {final _that = this;
switch (_that) {
case _TitleTokens():
return $default(_that.titleLarge,_that.titleMedium,_that.titleSmall);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TextStyle titleLarge,  TextStyle titleMedium,  TextStyle titleSmall)?  $default,) {final _that = this;
switch (_that) {
case _TitleTokens() when $default != null:
return $default(_that.titleLarge,_that.titleMedium,_that.titleSmall);case _:
  return null;

}
}

}

/// @nodoc


class _TitleTokens implements TitleTokens {
  const _TitleTokens({required this.titleLarge, required this.titleMedium, required this.titleSmall});
  

/// Title Large (ページタイトル、ダイアログタイトル)
@override final  TextStyle titleLarge;
/// Title Medium (カードタイトル、リストヘッダー)
@override final  TextStyle titleMedium;
/// Title Small (サブタイトル、カテゴリラベル)
@override final  TextStyle titleSmall;

/// Create a copy of TitleTokens
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TitleTokensCopyWith<_TitleTokens> get copyWith => __$TitleTokensCopyWithImpl<_TitleTokens>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TitleTokens&&(identical(other.titleLarge, titleLarge) || other.titleLarge == titleLarge)&&(identical(other.titleMedium, titleMedium) || other.titleMedium == titleMedium)&&(identical(other.titleSmall, titleSmall) || other.titleSmall == titleSmall));
}


@override
int get hashCode => Object.hash(runtimeType,titleLarge,titleMedium,titleSmall);

@override
String toString() {
  return 'TitleTokens(titleLarge: $titleLarge, titleMedium: $titleMedium, titleSmall: $titleSmall)';
}


}

/// @nodoc
abstract mixin class _$TitleTokensCopyWith<$Res> implements $TitleTokensCopyWith<$Res> {
  factory _$TitleTokensCopyWith(_TitleTokens value, $Res Function(_TitleTokens) _then) = __$TitleTokensCopyWithImpl;
@override @useResult
$Res call({
 TextStyle titleLarge, TextStyle titleMedium, TextStyle titleSmall
});




}
/// @nodoc
class __$TitleTokensCopyWithImpl<$Res>
    implements _$TitleTokensCopyWith<$Res> {
  __$TitleTokensCopyWithImpl(this._self, this._then);

  final _TitleTokens _self;
  final $Res Function(_TitleTokens) _then;

/// Create a copy of TitleTokens
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? titleLarge = null,Object? titleMedium = null,Object? titleSmall = null,}) {
  return _then(_TitleTokens(
titleLarge: null == titleLarge ? _self.titleLarge : titleLarge // ignore: cast_nullable_to_non_nullable
as TextStyle,titleMedium: null == titleMedium ? _self.titleMedium : titleMedium // ignore: cast_nullable_to_non_nullable
as TextStyle,titleSmall: null == titleSmall ? _self.titleSmall : titleSmall // ignore: cast_nullable_to_non_nullable
as TextStyle,
  ));
}


}

/// @nodoc
mixin _$LabelTokens {

/// Label Large (ボタンテキスト、タブラベル)
 TextStyle get labelLarge;/// Label Medium (チップ、バッジ)
 TextStyle get labelMedium;/// Label Small (補助ラベル、ヒント)
 TextStyle get labelSmall;
/// Create a copy of LabelTokens
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LabelTokensCopyWith<LabelTokens> get copyWith => _$LabelTokensCopyWithImpl<LabelTokens>(this as LabelTokens, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LabelTokens&&(identical(other.labelLarge, labelLarge) || other.labelLarge == labelLarge)&&(identical(other.labelMedium, labelMedium) || other.labelMedium == labelMedium)&&(identical(other.labelSmall, labelSmall) || other.labelSmall == labelSmall));
}


@override
int get hashCode => Object.hash(runtimeType,labelLarge,labelMedium,labelSmall);

@override
String toString() {
  return 'LabelTokens(labelLarge: $labelLarge, labelMedium: $labelMedium, labelSmall: $labelSmall)';
}


}

/// @nodoc
abstract mixin class $LabelTokensCopyWith<$Res>  {
  factory $LabelTokensCopyWith(LabelTokens value, $Res Function(LabelTokens) _then) = _$LabelTokensCopyWithImpl;
@useResult
$Res call({
 TextStyle labelLarge, TextStyle labelMedium, TextStyle labelSmall
});




}
/// @nodoc
class _$LabelTokensCopyWithImpl<$Res>
    implements $LabelTokensCopyWith<$Res> {
  _$LabelTokensCopyWithImpl(this._self, this._then);

  final LabelTokens _self;
  final $Res Function(LabelTokens) _then;

/// Create a copy of LabelTokens
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? labelLarge = null,Object? labelMedium = null,Object? labelSmall = null,}) {
  return _then(_self.copyWith(
labelLarge: null == labelLarge ? _self.labelLarge : labelLarge // ignore: cast_nullable_to_non_nullable
as TextStyle,labelMedium: null == labelMedium ? _self.labelMedium : labelMedium // ignore: cast_nullable_to_non_nullable
as TextStyle,labelSmall: null == labelSmall ? _self.labelSmall : labelSmall // ignore: cast_nullable_to_non_nullable
as TextStyle,
  ));
}

}


/// Adds pattern-matching-related methods to [LabelTokens].
extension LabelTokensPatterns on LabelTokens {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LabelTokens value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LabelTokens() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LabelTokens value)  $default,){
final _that = this;
switch (_that) {
case _LabelTokens():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LabelTokens value)?  $default,){
final _that = this;
switch (_that) {
case _LabelTokens() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TextStyle labelLarge,  TextStyle labelMedium,  TextStyle labelSmall)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LabelTokens() when $default != null:
return $default(_that.labelLarge,_that.labelMedium,_that.labelSmall);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TextStyle labelLarge,  TextStyle labelMedium,  TextStyle labelSmall)  $default,) {final _that = this;
switch (_that) {
case _LabelTokens():
return $default(_that.labelLarge,_that.labelMedium,_that.labelSmall);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TextStyle labelLarge,  TextStyle labelMedium,  TextStyle labelSmall)?  $default,) {final _that = this;
switch (_that) {
case _LabelTokens() when $default != null:
return $default(_that.labelLarge,_that.labelMedium,_that.labelSmall);case _:
  return null;

}
}

}

/// @nodoc


class _LabelTokens implements LabelTokens {
  const _LabelTokens({required this.labelLarge, required this.labelMedium, required this.labelSmall});
  

/// Label Large (ボタンテキスト、タブラベル)
@override final  TextStyle labelLarge;
/// Label Medium (チップ、バッジ)
@override final  TextStyle labelMedium;
/// Label Small (補助ラベル、ヒント)
@override final  TextStyle labelSmall;

/// Create a copy of LabelTokens
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LabelTokensCopyWith<_LabelTokens> get copyWith => __$LabelTokensCopyWithImpl<_LabelTokens>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LabelTokens&&(identical(other.labelLarge, labelLarge) || other.labelLarge == labelLarge)&&(identical(other.labelMedium, labelMedium) || other.labelMedium == labelMedium)&&(identical(other.labelSmall, labelSmall) || other.labelSmall == labelSmall));
}


@override
int get hashCode => Object.hash(runtimeType,labelLarge,labelMedium,labelSmall);

@override
String toString() {
  return 'LabelTokens(labelLarge: $labelLarge, labelMedium: $labelMedium, labelSmall: $labelSmall)';
}


}

/// @nodoc
abstract mixin class _$LabelTokensCopyWith<$Res> implements $LabelTokensCopyWith<$Res> {
  factory _$LabelTokensCopyWith(_LabelTokens value, $Res Function(_LabelTokens) _then) = __$LabelTokensCopyWithImpl;
@override @useResult
$Res call({
 TextStyle labelLarge, TextStyle labelMedium, TextStyle labelSmall
});




}
/// @nodoc
class __$LabelTokensCopyWithImpl<$Res>
    implements _$LabelTokensCopyWith<$Res> {
  __$LabelTokensCopyWithImpl(this._self, this._then);

  final _LabelTokens _self;
  final $Res Function(_LabelTokens) _then;

/// Create a copy of LabelTokens
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? labelLarge = null,Object? labelMedium = null,Object? labelSmall = null,}) {
  return _then(_LabelTokens(
labelLarge: null == labelLarge ? _self.labelLarge : labelLarge // ignore: cast_nullable_to_non_nullable
as TextStyle,labelMedium: null == labelMedium ? _self.labelMedium : labelMedium // ignore: cast_nullable_to_non_nullable
as TextStyle,labelSmall: null == labelSmall ? _self.labelSmall : labelSmall // ignore: cast_nullable_to_non_nullable
as TextStyle,
  ));
}


}

/// @nodoc
mixin _$BodyTokens {

/// Body Large (本文テキスト、段落)
 TextStyle get bodyLarge;/// Body Medium (リストアイテム、説明テキスト)
 TextStyle get bodyMedium;/// Body Small (キャプション、補足テキスト)
 TextStyle get bodySmall;
/// Create a copy of BodyTokens
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BodyTokensCopyWith<BodyTokens> get copyWith => _$BodyTokensCopyWithImpl<BodyTokens>(this as BodyTokens, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BodyTokens&&(identical(other.bodyLarge, bodyLarge) || other.bodyLarge == bodyLarge)&&(identical(other.bodyMedium, bodyMedium) || other.bodyMedium == bodyMedium)&&(identical(other.bodySmall, bodySmall) || other.bodySmall == bodySmall));
}


@override
int get hashCode => Object.hash(runtimeType,bodyLarge,bodyMedium,bodySmall);

@override
String toString() {
  return 'BodyTokens(bodyLarge: $bodyLarge, bodyMedium: $bodyMedium, bodySmall: $bodySmall)';
}


}

/// @nodoc
abstract mixin class $BodyTokensCopyWith<$Res>  {
  factory $BodyTokensCopyWith(BodyTokens value, $Res Function(BodyTokens) _then) = _$BodyTokensCopyWithImpl;
@useResult
$Res call({
 TextStyle bodyLarge, TextStyle bodyMedium, TextStyle bodySmall
});




}
/// @nodoc
class _$BodyTokensCopyWithImpl<$Res>
    implements $BodyTokensCopyWith<$Res> {
  _$BodyTokensCopyWithImpl(this._self, this._then);

  final BodyTokens _self;
  final $Res Function(BodyTokens) _then;

/// Create a copy of BodyTokens
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bodyLarge = null,Object? bodyMedium = null,Object? bodySmall = null,}) {
  return _then(_self.copyWith(
bodyLarge: null == bodyLarge ? _self.bodyLarge : bodyLarge // ignore: cast_nullable_to_non_nullable
as TextStyle,bodyMedium: null == bodyMedium ? _self.bodyMedium : bodyMedium // ignore: cast_nullable_to_non_nullable
as TextStyle,bodySmall: null == bodySmall ? _self.bodySmall : bodySmall // ignore: cast_nullable_to_non_nullable
as TextStyle,
  ));
}

}


/// Adds pattern-matching-related methods to [BodyTokens].
extension BodyTokensPatterns on BodyTokens {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BodyTokens value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BodyTokens() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BodyTokens value)  $default,){
final _that = this;
switch (_that) {
case _BodyTokens():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BodyTokens value)?  $default,){
final _that = this;
switch (_that) {
case _BodyTokens() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TextStyle bodyLarge,  TextStyle bodyMedium,  TextStyle bodySmall)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BodyTokens() when $default != null:
return $default(_that.bodyLarge,_that.bodyMedium,_that.bodySmall);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TextStyle bodyLarge,  TextStyle bodyMedium,  TextStyle bodySmall)  $default,) {final _that = this;
switch (_that) {
case _BodyTokens():
return $default(_that.bodyLarge,_that.bodyMedium,_that.bodySmall);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TextStyle bodyLarge,  TextStyle bodyMedium,  TextStyle bodySmall)?  $default,) {final _that = this;
switch (_that) {
case _BodyTokens() when $default != null:
return $default(_that.bodyLarge,_that.bodyMedium,_that.bodySmall);case _:
  return null;

}
}

}

/// @nodoc


class _BodyTokens implements BodyTokens {
  const _BodyTokens({required this.bodyLarge, required this.bodyMedium, required this.bodySmall});
  

/// Body Large (本文テキスト、段落)
@override final  TextStyle bodyLarge;
/// Body Medium (リストアイテム、説明テキスト)
@override final  TextStyle bodyMedium;
/// Body Small (キャプション、補足テキスト)
@override final  TextStyle bodySmall;

/// Create a copy of BodyTokens
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BodyTokensCopyWith<_BodyTokens> get copyWith => __$BodyTokensCopyWithImpl<_BodyTokens>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BodyTokens&&(identical(other.bodyLarge, bodyLarge) || other.bodyLarge == bodyLarge)&&(identical(other.bodyMedium, bodyMedium) || other.bodyMedium == bodyMedium)&&(identical(other.bodySmall, bodySmall) || other.bodySmall == bodySmall));
}


@override
int get hashCode => Object.hash(runtimeType,bodyLarge,bodyMedium,bodySmall);

@override
String toString() {
  return 'BodyTokens(bodyLarge: $bodyLarge, bodyMedium: $bodyMedium, bodySmall: $bodySmall)';
}


}

/// @nodoc
abstract mixin class _$BodyTokensCopyWith<$Res> implements $BodyTokensCopyWith<$Res> {
  factory _$BodyTokensCopyWith(_BodyTokens value, $Res Function(_BodyTokens) _then) = __$BodyTokensCopyWithImpl;
@override @useResult
$Res call({
 TextStyle bodyLarge, TextStyle bodyMedium, TextStyle bodySmall
});




}
/// @nodoc
class __$BodyTokensCopyWithImpl<$Res>
    implements _$BodyTokensCopyWith<$Res> {
  __$BodyTokensCopyWithImpl(this._self, this._then);

  final _BodyTokens _self;
  final $Res Function(_BodyTokens) _then;

/// Create a copy of BodyTokens
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bodyLarge = null,Object? bodyMedium = null,Object? bodySmall = null,}) {
  return _then(_BodyTokens(
bodyLarge: null == bodyLarge ? _self.bodyLarge : bodyLarge // ignore: cast_nullable_to_non_nullable
as TextStyle,bodyMedium: null == bodyMedium ? _self.bodyMedium : bodyMedium // ignore: cast_nullable_to_non_nullable
as TextStyle,bodySmall: null == bodySmall ? _self.bodySmall : bodySmall // ignore: cast_nullable_to_non_nullable
as TextStyle,
  ));
}


}

// dart format on
