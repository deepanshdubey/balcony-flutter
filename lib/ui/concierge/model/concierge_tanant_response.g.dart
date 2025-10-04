// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'concierge_tanant_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConciergeTanantResponse _$ConciergeTanantResponseFromJson(
        Map<String, dynamic> json) =>
    ConciergeTanantResponse(
      success: json['success'] as bool?,
      tenants: json['tenants'] == null
          ? null
          : Tenants.fromJson(json['tenants'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConciergeTanantResponseToJson(
        ConciergeTanantResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'tenants': instance.tenants,
    };

Tenants _$TenantsFromJson(Map<String, dynamic> json) => Tenants(
      leasingTenants: (json['leasingTenants'] as List<dynamic>?)
          ?.map((e) => ConciergeTenant.fromJson(e as Map<String, dynamic>))
          .toList(),
      conciergeTenants: (json['conciergeTenants'] as List<dynamic>?)
          ?.map((e) => ConciergeTenant.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TenantsToJson(Tenants instance) => <String, dynamic>{
      'conciergeTenants': instance.conciergeTenants,
      'leasingTenants': instance.leasingTenants,
    };

ConciergeTenant _$ConciergeTenantFromJson(Map<String, dynamic> json) =>
    ConciergeTenant(
      Id: json['_id'] as String?,
      info: json['info'] == null
          ? null
          : ConciergeInfo.fromJson(json['info'] as Map<String, dynamic>),
      selectedUnit: json['selectedUnit'] == null
          ? null
          : SelectedUnit.fromJson(json['selectedUnit'] as Map<String, dynamic>),
      parcels: (json['parcels'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ConciergeTenantToJson(ConciergeTenant instance) =>
    <String, dynamic>{
      '_id': instance.Id,
      'info': instance.info,
      'selectedUnit': instance.selectedUnit,
      'parcels': instance.parcels,
    };

ConciergeInfo _$ConciergeInfoFromJson(Map<String, dynamic> json) =>
    ConciergeInfo(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$ConciergeInfoToJson(ConciergeInfo instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
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
