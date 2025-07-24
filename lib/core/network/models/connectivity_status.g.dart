// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectivity_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConnectivityStatus _$ConnectivityStatusFromJson(Map<String, dynamic> json) =>
    _ConnectivityStatus(
      isConnected: json['isConnected'] as bool,
      type: $enumDecode(_$ConnectivityTypeEnumMap, json['type']),
      quality:
          $enumDecodeNullable(_$ConnectionQualityEnumMap, json['quality']) ??
          ConnectionQuality.unknown,
      signalStrength: (json['signalStrength'] as num?)?.toInt(),
      speedKbps: (json['speedKbps'] as num?)?.toDouble(),
      isMetered: json['isMetered'] as bool? ?? false,
      isRoaming: json['isRoaming'] as bool? ?? false,
      networkName: json['networkName'] as String?,
      ipAddress: json['ipAddress'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$ConnectivityStatusToJson(_ConnectivityStatus instance) =>
    <String, dynamic>{
      'isConnected': instance.isConnected,
      'type': _$ConnectivityTypeEnumMap[instance.type]!,
      'quality': _$ConnectionQualityEnumMap[instance.quality]!,
      'signalStrength': instance.signalStrength,
      'speedKbps': instance.speedKbps,
      'isMetered': instance.isMetered,
      'isRoaming': instance.isRoaming,
      'networkName': instance.networkName,
      'ipAddress': instance.ipAddress,
      'timestamp': instance.timestamp.toIso8601String(),
      'metadata': instance.metadata,
    };

const _$ConnectivityTypeEnumMap = {
  ConnectivityType.none: 'none',
  ConnectivityType.wifi: 'wifi',
  ConnectivityType.mobile: 'mobile',
  ConnectivityType.ethernet: 'ethernet',
  ConnectivityType.bluetooth: 'bluetooth',
  ConnectivityType.vpn: 'vpn',
  ConnectivityType.other: 'other',
};

const _$ConnectionQualityEnumMap = {
  ConnectionQuality.none: 'none',
  ConnectionQuality.excellent: 'excellent',
  ConnectionQuality.good: 'good',
  ConnectionQuality.fair: 'fair',
  ConnectionQuality.poor: 'poor',
  ConnectionQuality.unknown: 'unknown',
};
