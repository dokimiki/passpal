// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeState {

 AsyncValue<List<NewsItem>> get systemNews; AsyncValue<List<MailSummary>> get receivedMail; AsyncValue<List<AlboNewsItem>> get alboNews;
/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeStateCopyWith<HomeState> get copyWith => _$HomeStateCopyWithImpl<HomeState>(this as HomeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState&&(identical(other.systemNews, systemNews) || other.systemNews == systemNews)&&(identical(other.receivedMail, receivedMail) || other.receivedMail == receivedMail)&&(identical(other.alboNews, alboNews) || other.alboNews == alboNews));
}


@override
int get hashCode => Object.hash(runtimeType,systemNews,receivedMail,alboNews);

@override
String toString() {
  return 'HomeState(systemNews: $systemNews, receivedMail: $receivedMail, alboNews: $alboNews)';
}


}

/// @nodoc
abstract mixin class $HomeStateCopyWith<$Res>  {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) _then) = _$HomeStateCopyWithImpl;
@useResult
$Res call({
 AsyncValue<List<NewsItem>> systemNews, AsyncValue<List<MailSummary>> receivedMail, AsyncValue<List<AlboNewsItem>> alboNews
});




}
/// @nodoc
class _$HomeStateCopyWithImpl<$Res>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._self, this._then);

  final HomeState _self;
  final $Res Function(HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? systemNews = null,Object? receivedMail = null,Object? alboNews = null,}) {
  return _then(_self.copyWith(
systemNews: null == systemNews ? _self.systemNews : systemNews // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<NewsItem>>,receivedMail: null == receivedMail ? _self.receivedMail : receivedMail // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<MailSummary>>,alboNews: null == alboNews ? _self.alboNews : alboNews // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<AlboNewsItem>>,
  ));
}

}


/// @nodoc


class _HomeState implements HomeState {
  const _HomeState({this.systemNews = const AsyncValue.loading(), this.receivedMail = const AsyncValue.loading(), this.alboNews = const AsyncValue.loading()});
  

@override@JsonKey() final  AsyncValue<List<NewsItem>> systemNews;
@override@JsonKey() final  AsyncValue<List<MailSummary>> receivedMail;
@override@JsonKey() final  AsyncValue<List<AlboNewsItem>> alboNews;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeStateCopyWith<_HomeState> get copyWith => __$HomeStateCopyWithImpl<_HomeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeState&&(identical(other.systemNews, systemNews) || other.systemNews == systemNews)&&(identical(other.receivedMail, receivedMail) || other.receivedMail == receivedMail)&&(identical(other.alboNews, alboNews) || other.alboNews == alboNews));
}


@override
int get hashCode => Object.hash(runtimeType,systemNews,receivedMail,alboNews);

@override
String toString() {
  return 'HomeState(systemNews: $systemNews, receivedMail: $receivedMail, alboNews: $alboNews)';
}


}

/// @nodoc
abstract mixin class _$HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$HomeStateCopyWith(_HomeState value, $Res Function(_HomeState) _then) = __$HomeStateCopyWithImpl;
@override @useResult
$Res call({
 AsyncValue<List<NewsItem>> systemNews, AsyncValue<List<MailSummary>> receivedMail, AsyncValue<List<AlboNewsItem>> alboNews
});




}
/// @nodoc
class __$HomeStateCopyWithImpl<$Res>
    implements _$HomeStateCopyWith<$Res> {
  __$HomeStateCopyWithImpl(this._self, this._then);

  final _HomeState _self;
  final $Res Function(_HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? systemNews = null,Object? receivedMail = null,Object? alboNews = null,}) {
  return _then(_HomeState(
systemNews: null == systemNews ? _self.systemNews : systemNews // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<NewsItem>>,receivedMail: null == receivedMail ? _self.receivedMail : receivedMail // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<MailSummary>>,alboNews: null == alboNews ? _self.alboNews : alboNews // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<AlboNewsItem>>,
  ));
}


}

// dart format on
