// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginFormState {

/// Current student ID entered by user
 StudentId? get studentId;/// Whether any async operation is in progress
 bool get isLoading;/// Error message to display to user
 String? get errorMessage;/// Current step in the login flow
 LoginStep get currentStep;/// Whether Google sign-in has been completed
 bool get isGoogleSignedIn;
/// Create a copy of LoginFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginFormStateCopyWith<LoginFormState> get copyWith => _$LoginFormStateCopyWithImpl<LoginFormState>(this as LoginFormState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginFormState&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.isGoogleSignedIn, isGoogleSignedIn) || other.isGoogleSignedIn == isGoogleSignedIn));
}


@override
int get hashCode => Object.hash(runtimeType,studentId,isLoading,errorMessage,currentStep,isGoogleSignedIn);

@override
String toString() {
  return 'LoginFormState(studentId: $studentId, isLoading: $isLoading, errorMessage: $errorMessage, currentStep: $currentStep, isGoogleSignedIn: $isGoogleSignedIn)';
}


}

/// @nodoc
abstract mixin class $LoginFormStateCopyWith<$Res>  {
  factory $LoginFormStateCopyWith(LoginFormState value, $Res Function(LoginFormState) _then) = _$LoginFormStateCopyWithImpl;
@useResult
$Res call({
 StudentId? studentId, bool isLoading, String? errorMessage, LoginStep currentStep, bool isGoogleSignedIn
});




}
/// @nodoc
class _$LoginFormStateCopyWithImpl<$Res>
    implements $LoginFormStateCopyWith<$Res> {
  _$LoginFormStateCopyWithImpl(this._self, this._then);

  final LoginFormState _self;
  final $Res Function(LoginFormState) _then;

/// Create a copy of LoginFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? studentId = freezed,Object? isLoading = null,Object? errorMessage = freezed,Object? currentStep = null,Object? isGoogleSignedIn = null,}) {
  return _then(_self.copyWith(
studentId: freezed == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as StudentId?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as LoginStep,isGoogleSignedIn: null == isGoogleSignedIn ? _self.isGoogleSignedIn : isGoogleSignedIn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _LoginFormState implements LoginFormState {
  const _LoginFormState({this.studentId, this.isLoading = false, this.errorMessage, this.currentStep = LoginStep.studentId, this.isGoogleSignedIn = false});
  

/// Current student ID entered by user
@override final  StudentId? studentId;
/// Whether any async operation is in progress
@override@JsonKey() final  bool isLoading;
/// Error message to display to user
@override final  String? errorMessage;
/// Current step in the login flow
@override@JsonKey() final  LoginStep currentStep;
/// Whether Google sign-in has been completed
@override@JsonKey() final  bool isGoogleSignedIn;

/// Create a copy of LoginFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginFormStateCopyWith<_LoginFormState> get copyWith => __$LoginFormStateCopyWithImpl<_LoginFormState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginFormState&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.isGoogleSignedIn, isGoogleSignedIn) || other.isGoogleSignedIn == isGoogleSignedIn));
}


@override
int get hashCode => Object.hash(runtimeType,studentId,isLoading,errorMessage,currentStep,isGoogleSignedIn);

@override
String toString() {
  return 'LoginFormState(studentId: $studentId, isLoading: $isLoading, errorMessage: $errorMessage, currentStep: $currentStep, isGoogleSignedIn: $isGoogleSignedIn)';
}


}

/// @nodoc
abstract mixin class _$LoginFormStateCopyWith<$Res> implements $LoginFormStateCopyWith<$Res> {
  factory _$LoginFormStateCopyWith(_LoginFormState value, $Res Function(_LoginFormState) _then) = __$LoginFormStateCopyWithImpl;
@override @useResult
$Res call({
 StudentId? studentId, bool isLoading, String? errorMessage, LoginStep currentStep, bool isGoogleSignedIn
});




}
/// @nodoc
class __$LoginFormStateCopyWithImpl<$Res>
    implements _$LoginFormStateCopyWith<$Res> {
  __$LoginFormStateCopyWithImpl(this._self, this._then);

  final _LoginFormState _self;
  final $Res Function(_LoginFormState) _then;

/// Create a copy of LoginFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? studentId = freezed,Object? isLoading = null,Object? errorMessage = freezed,Object? currentStep = null,Object? isGoogleSignedIn = null,}) {
  return _then(_LoginFormState(
studentId: freezed == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as StudentId?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as LoginStep,isGoogleSignedIn: null == isGoogleSignedIn ? _self.isGoogleSignedIn : isGoogleSignedIn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
