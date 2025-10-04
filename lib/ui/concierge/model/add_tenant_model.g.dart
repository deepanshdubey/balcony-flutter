// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_tenant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddTenantModel _$AddTenantModelFromJson(Map<String, dynamic> json) =>
    AddTenantModel(
      success: json['success'] as bool?,
      tenant: json['tenant'] == null
          ? null
          : Tenant.fromJson(json['tenant'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddTenantModelToJson(AddTenantModel instance) =>
    <String, dynamic>{
      'success': instance.success,
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
