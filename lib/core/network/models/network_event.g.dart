// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NetworkEvent _$NetworkEventFromJson(
  Map<String, dynamic> json,
) => _NetworkEvent(
  previous: json['previous'] == null
      ? null
      : ConnectivityStatus.fromJson(json['previous'] as Map<String, dynamic>),
  current: ConnectivityStatus.fromJson(json['current'] as Map<String, dynamic>),
  timestamp: DateTime.parse(json['timestamp'] as String),
  type: NetworkEventType.fromJson(json['type'] as Map<String, dynamic>),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$NetworkEventToJson(_NetworkEvent instance) =>
    <String, dynamic>{
      'previous': instance.previous,
      'current': instance.current,
      'timestamp': instance.timestamp.toIso8601String(),
      'type': instance.type,
      'metadata': instance.metadata,
    };

_Connected _$ConnectedFromJson(Map<String, dynamic> json) =>
    _Connected($type: json['runtimeType'] as String?);

Map<String, dynamic> _$ConnectedToJson(_Connected instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

_Disconnected _$DisconnectedFromJson(Map<String, dynamic> json) =>
    _Disconnected($type: json['runtimeType'] as String?);

Map<String, dynamic> _$DisconnectedToJson(_Disconnected instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

_TypeChanged _$TypeChangedFromJson(Map<String, dynamic> json) =>
    _TypeChanged($type: json['runtimeType'] as String?);

Map<String, dynamic> _$TypeChangedToJson(_TypeChanged instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

_QualityChanged _$QualityChangedFromJson(Map<String, dynamic> json) =>
    _QualityChanged($type: json['runtimeType'] as String?);

Map<String, dynamic> _$QualityChangedToJson(_QualityChanged instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

_Initial _$InitialFromJson(Map<String, dynamic> json) =>
    _Initial($type: json['runtimeType'] as String?);

Map<String, dynamic> _$InitialToJson(_Initial instance) => <String, dynamic>{
  'runtimeType': instance.$type,
};
