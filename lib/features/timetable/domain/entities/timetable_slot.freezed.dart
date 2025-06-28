// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timetable_slot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TimetableSlot {

/// スロットID
 String get id;/// 学期
 Term get term;/// 曜日
 Weekday get weekday;/// 時限
 Period get period;/// 授業情報
 Course? get course;/// 教室
 String? get room;/// 備考
 String? get notes;
/// Create a copy of TimetableSlot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimetableSlotCopyWith<TimetableSlot> get copyWith => _$TimetableSlotCopyWithImpl<TimetableSlot>(this as TimetableSlot, _$identity);

  /// Serializes this TimetableSlot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimetableSlot&&(identical(other.id, id) || other.id == id)&&(identical(other.term, term) || other.term == term)&&(identical(other.weekday, weekday) || other.weekday == weekday)&&(identical(other.period, period) || other.period == period)&&(identical(other.course, course) || other.course == course)&&(identical(other.room, room) || other.room == room)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,term,weekday,period,course,room,notes);

@override
String toString() {
  return 'TimetableSlot(id: $id, term: $term, weekday: $weekday, period: $period, course: $course, room: $room, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $TimetableSlotCopyWith<$Res>  {
  factory $TimetableSlotCopyWith(TimetableSlot value, $Res Function(TimetableSlot) _then) = _$TimetableSlotCopyWithImpl;
@useResult
$Res call({
 String id, Term term, Weekday weekday, Period period, Course? course, String? room, String? notes
});


$TermCopyWith<$Res> get term;$CourseCopyWith<$Res>? get course;

}
/// @nodoc
class _$TimetableSlotCopyWithImpl<$Res>
    implements $TimetableSlotCopyWith<$Res> {
  _$TimetableSlotCopyWithImpl(this._self, this._then);

  final TimetableSlot _self;
  final $Res Function(TimetableSlot) _then;

/// Create a copy of TimetableSlot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? term = null,Object? weekday = null,Object? period = null,Object? course = freezed,Object? room = freezed,Object? notes = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as Term,weekday: null == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as Weekday,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as Period,course: freezed == course ? _self.course : course // ignore: cast_nullable_to_non_nullable
as Course?,room: freezed == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of TimetableSlot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TermCopyWith<$Res> get term {
  
  return $TermCopyWith<$Res>(_self.term, (value) {
    return _then(_self.copyWith(term: value));
  });
}/// Create a copy of TimetableSlot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CourseCopyWith<$Res>? get course {
    if (_self.course == null) {
    return null;
  }

  return $CourseCopyWith<$Res>(_self.course!, (value) {
    return _then(_self.copyWith(course: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _TimetableSlot implements TimetableSlot {
  const _TimetableSlot({required this.id, required this.term, required this.weekday, required this.period, this.course, this.room, this.notes});
  factory _TimetableSlot.fromJson(Map<String, dynamic> json) => _$TimetableSlotFromJson(json);

/// スロットID
@override final  String id;
/// 学期
@override final  Term term;
/// 曜日
@override final  Weekday weekday;
/// 時限
@override final  Period period;
/// 授業情報
@override final  Course? course;
/// 教室
@override final  String? room;
/// 備考
@override final  String? notes;

/// Create a copy of TimetableSlot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimetableSlotCopyWith<_TimetableSlot> get copyWith => __$TimetableSlotCopyWithImpl<_TimetableSlot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TimetableSlotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimetableSlot&&(identical(other.id, id) || other.id == id)&&(identical(other.term, term) || other.term == term)&&(identical(other.weekday, weekday) || other.weekday == weekday)&&(identical(other.period, period) || other.period == period)&&(identical(other.course, course) || other.course == course)&&(identical(other.room, room) || other.room == room)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,term,weekday,period,course,room,notes);

@override
String toString() {
  return 'TimetableSlot(id: $id, term: $term, weekday: $weekday, period: $period, course: $course, room: $room, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$TimetableSlotCopyWith<$Res> implements $TimetableSlotCopyWith<$Res> {
  factory _$TimetableSlotCopyWith(_TimetableSlot value, $Res Function(_TimetableSlot) _then) = __$TimetableSlotCopyWithImpl;
@override @useResult
$Res call({
 String id, Term term, Weekday weekday, Period period, Course? course, String? room, String? notes
});


@override $TermCopyWith<$Res> get term;@override $CourseCopyWith<$Res>? get course;

}
/// @nodoc
class __$TimetableSlotCopyWithImpl<$Res>
    implements _$TimetableSlotCopyWith<$Res> {
  __$TimetableSlotCopyWithImpl(this._self, this._then);

  final _TimetableSlot _self;
  final $Res Function(_TimetableSlot) _then;

/// Create a copy of TimetableSlot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? term = null,Object? weekday = null,Object? period = null,Object? course = freezed,Object? room = freezed,Object? notes = freezed,}) {
  return _then(_TimetableSlot(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as Term,weekday: null == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as Weekday,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as Period,course: freezed == course ? _self.course : course // ignore: cast_nullable_to_non_nullable
as Course?,room: freezed == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of TimetableSlot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TermCopyWith<$Res> get term {
  
  return $TermCopyWith<$Res>(_self.term, (value) {
    return _then(_self.copyWith(term: value));
  });
}/// Create a copy of TimetableSlot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CourseCopyWith<$Res>? get course {
    if (_self.course == null) {
    return null;
  }

  return $CourseCopyWith<$Res>(_self.course!, (value) {
    return _then(_self.copyWith(course: value));
  });
}
}

// dart format on
