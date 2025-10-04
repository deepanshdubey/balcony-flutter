// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'concierge_property_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConciergePropertyResponse _$ConciergePropertyResponseFromJson(
        Map<String, dynamic> json) =>
    ConciergePropertyResponse(
      tenants: json['tenants'] == null
          ? null
          : Tenants.fromJson(json['tenants'] as Map<String, dynamic>),
      message: json['message'] as String?,
      property: json['property'] == null
          ? null
          : Property.fromJson(json['property'] as Map<String, dynamic>),
      success: json['success'] as bool?,
      properties: json['properties'] == null
          ? null
          : Properties.fromJson(json['properties'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConciergePropertyResponseToJson(
        ConciergePropertyResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'properties': instance.properties,
      'property': instance.property,
      'message': instance.message,
      'tenants': instance.tenants,
    };

Properties _$PropertiesFromJson(Map<String, dynamic> json) => Properties(
      leasingProperties: (json['leasingProperties'] as List<dynamic>?)
          ?.map((e) => LeasingPropertie.fromJson(e as Map<String, dynamic>))
          .toList(),
      conciergeProperties: (json['conciergeProperties'] as List<dynamic>?)
          ?.map((e) => ConciergePropertie.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PropertiesToJson(Properties instance) =>
    <String, dynamic>{
      'leasingProperties': instance.leasingProperties,
      'conciergeProperties': instance.conciergeProperties,
    };

LeasingPropertie _$LeasingPropertieFromJson(Map<String, dynamic> json) =>
    LeasingPropertie(
      Id: json['_id'] as String?,
      name: json['name'] as String?,
      hostId: json['hostId'] as String?,
    );

Map<String, dynamic> _$LeasingPropertieToJson(LeasingPropertie instance) =>
    <String, dynamic>{
      '_id': instance.Id,
      'name': instance.name,
      'hostId': instance.hostId,
    };

ConciergePropertie _$ConciergePropertieFromJson(Map<String, dynamic> json) =>
    ConciergePropertie(
      Id: json['_id'] as String?,
      name: json['name'] as String?,
      hostId: json['hostId'] as String?,
    );

Map<String, dynamic> _$ConciergePropertieToJson(ConciergePropertie instance) =>
    <String, dynamic>{
      '_id': instance.Id,
      'name': instance.name,
      'hostId': instance.hostId,
    };

Property _$PropertyFromJson(Map<String, dynamic> json) => Property(
      Id: json['_id'] as String?,
      name: json['name'] as String?,
      hostId: json['hostId'] as String?,
    );

Map<String, dynamic> _$PropertyToJson(Property instance) => <String, dynamic>{
      '_id': instance.Id,
      'name': instance.name,
      'hostId': instance.hostId,
    };
