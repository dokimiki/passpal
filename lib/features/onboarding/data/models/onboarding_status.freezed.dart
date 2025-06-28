// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OnboardingStatus {

 Campus? get campus; NotificationPermission? get notificationsGranted; bool get completed;
/// Create a copy of OnboardingStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingStatusCopyWith<OnboardingStatus> get copyWith => _$OnboardingStatusCopyWithImpl<OnboardingStatus>(this as OnboardingStatus, _$identity);

  /// Serializes this OnboardingStatus to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingStatus&&(identical(other.campus, campus) || other.campus == campus)&&(identical(other.notificationsGranted, notificationsGranted) || other.notificationsGranted == notificationsGranted)&&(identical(other.completed, completed) || other.completed == completed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,campus,notificationsGranted,completed);

@override
String toString() {
  return 'OnboardingStatus(campus: $campus, notificationsGranted: $notificationsGranted, completed: $completed)';
}


}

/// @nodoc
abstract mixin class $OnboardingStatusCopyWith<$Res>  {
  factory $OnboardingStatusCopyWith(OnboardingStatus value, $Res Function(OnboardingStatus) _then) = _$OnboardingStatusCopyWithImpl;
@useResult
$Res call({
 Campus? campus, NotificationPermission? notificationsGranted, bool completed
});


$CampusCopyWith<$Res>? get campus;$NotificationPermissionCopyWith<$Res>? get notificationsGranted;

}
/// @nodoc
class _$OnboardingStatusCopyWithImpl<$Res>
    implements $OnboardingStatusCopyWith<$Res> {
  _$OnboardingStatusCopyWithImpl(this._self, this._then);

  final OnboardingStatus _self;
  final $Res Function(OnboardingStatus) _then;

/// Create a copy of OnboardingStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? campus = freezed,Object? notificationsGranted = freezed,Object? completed = null,}) {
  return _then(_self.copyWith(
campus: freezed == campus ? _self.campus : campus // ignore: cast_nullable_to_non_nullable
as Campus?,notificationsGranted: freezed == notificationsGranted ? _self.notificationsGranted : notificationsGranted // ignore: cast_nullable_to_non_nullable
as NotificationPermission?,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of OnboardingStatus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CampusCopyWith<$Res>? get campus {
    if (_self.campus == null) {
    return null;
  }

  return $CampusCopyWith<$Res>(_self.campus!, (value) {
    return _then(_self.copyWith(campus: value));
  });
}/// Create a copy of OnboardingStatus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationPermissionCopyWith<$Res>? get notificationsGranted {
    if (_self.notificationsGranted == null) {
    return null;
  }

  return $NotificationPermissionCopyWith<$Res>(_self.notificationsGranted!, (value) {
    return _then(_self.copyWith(notificationsGranted: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _OnboardingStatus implements OnboardingStatus {
  const _OnboardingStatus({this.campus, this.notificationsGranted, this.completed = false});
  factory _OnboardingStatus.fromJson(Map<String, dynamic> json) => _$OnboardingStatusFromJson(json);

@override final  Campus? campus;
@override final  NotificationPermission? notificationsGranted;
@override@JsonKey() final  bool completed;

/// Create a copy of OnboardingStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingStatusCopyWith<_OnboardingStatus> get copyWith => __$OnboardingStatusCopyWithImpl<_OnboardingStatus>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OnboardingStatusToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingStatus&&(identical(other.campus, campus) || other.campus == campus)&&(identical(other.notificationsGranted, notificationsGranted) || other.notificationsGranted == notificationsGranted)&&(identical(other.completed, completed) || other.completed == completed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,campus,notificationsGranted,completed);

@override
String toString() {
  return 'OnboardingStatus(campus: $campus, notificationsGranted: $notificationsGranted, completed: $completed)';
}


}

/// @nodoc
abstract mixin class _$OnboardingStatusCopyWith<$Res> implements $OnboardingStatusCopyWith<$Res> {
  factory _$OnboardingStatusCopyWith(_OnboardingStatus value, $Res Function(_OnboardingStatus) _then) = __$OnboardingStatusCopyWithImpl;
@override @useResult
$Res call({
 Campus? campus, NotificationPermission? notificationsGranted, bool completed
});


@override $CampusCopyWith<$Res>? get campus;@override $NotificationPermissionCopyWith<$Res>? get notificationsGranted;

}
/// @nodoc
class __$OnboardingStatusCopyWithImpl<$Res>
    implements _$OnboardingStatusCopyWith<$Res> {
  __$OnboardingStatusCopyWithImpl(this._self, this._then);

  final _OnboardingStatus _self;
  final $Res Function(_OnboardingStatus) _then;

/// Create a copy of OnboardingStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? campus = freezed,Object? notificationsGranted = freezed,Object? completed = null,}) {
  return _then(_OnboardingStatus(
campus: freezed == campus ? _self.campus : campus // ignore: cast_nullable_to_non_nullable
as Campus?,notificationsGranted: freezed == notificationsGranted ? _self.notificationsGranted : notificationsGranted // ignore: cast_nullable_to_non_nullable
as NotificationPermission?,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of OnboardingStatus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CampusCopyWith<$Res>? get campus {
    if (_self.campus == null) {
    return null;
  }

  return $CampusCopyWith<$Res>(_self.campus!, (value) {
    return _then(_self.copyWith(campus: value));
  });
}/// Create a copy of OnboardingStatus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationPermissionCopyWith<$Res>? get notificationsGranted {
    if (_self.notificationsGranted == null) {
    return null;
  }

  return $NotificationPermissionCopyWith<$Res>(_self.notificationsGranted!, (value) {
    return _then(_self.copyWith(notificationsGranted: value));
  });
}
}

// dart format on
