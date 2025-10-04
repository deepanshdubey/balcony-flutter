// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenace_request_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaintenaceRequestResponse _$MaintenaceRequestResponseFromJson(
        Map<String, dynamic> json) =>
    MaintenaceRequestResponse(
      success: json['success'] as bool?,
      requests: (json['requests'] as List<dynamic>?)
          ?.map((e) => Request.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MaintenaceRequestResponseToJson(
        MaintenaceRequestResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'requests': instance.requests,
    };

Request _$RequestFromJson(Map<String, dynamic> json) => Request(
      Id: json['_id'] as String?,
      note: json['note'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      tenant: json['tenant'] == null
          ? null
          : Tenant.fromJson(json['tenant'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RequestToJson(Request instance) => <String, dynamic>{
      '_id': instance.Id,
      'note': instance.note,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'tenant': instance.tenant,
    };

Tenant _$TenantFromJson(Map<String, dynamic> json) => Tenant(
      Id: json['_id'] as String?,
      parcels: (json['parcels'] as num?)?.toInt(),
      info: json['info'] == null
          ? null
          : Info.fromJson(json['info'] as Map<String, dynamic>),
      selectedUnit: json['selectedUnit'] == null
          ? null
          : SelectedUnit.fromJson(json['selectedUnit'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TenantToJson(Tenant instance) => <String, dynamic>{
      '_id': instance.Id,
      'parcels': instance.parcels,
      'info': instance.info,
      'selectedUnit': instance.selectedUnit,
    };

SelectedUnit _$SelectedUnitFromJson(Map<String, dynamic> json) => SelectedUnit(
      Id: json['_id'] as String?,
      unit: (json['unit'] as num?)?.toInt(),
      property: json['property'] == null
          ? null
          : Property.fromJson(json['property'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SelectedUnitToJson(SelectedUnit instance) =>
    <String, dynamic>{
      '_id': instance.Id,
      'unit': instance.unit,
      'property': instance.property,
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
