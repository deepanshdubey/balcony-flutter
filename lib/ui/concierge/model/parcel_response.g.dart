// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parcel_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParcelResponse _$ParcelResponseFromJson(Map<String, dynamic> json) =>
    ParcelResponse(
      message: json['message'] as String?,
      success: json['success'] as bool?,
      parcels: (json['parcels'] as List<dynamic>?)
          ?.map((e) => Parcel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ParcelResponseToJson(ParcelResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'parcels': instance.parcels,
    };

Tenant _$TenantFromJson(Map<String, dynamic> json) => Tenant(
      Id: json['_id'] as String?,
      info: json['info'] == null
          ? null
          : ParcelInfo.fromJson(json['info'] as Map<String, dynamic>),
      selectedUnit: json['selectedUnit'] == null
          ? null
          : SelectedUnit.fromJson(json['selectedUnit'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TenantToJson(Tenant instance) => <String, dynamic>{
      '_id': instance.Id,
      'info': instance.info,
      'selectedUnit': instance.selectedUnit,
    };

ParcelInfo _$ParcelInfoFromJson(Map<String, dynamic> json) => ParcelInfo(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$ParcelInfoToJson(ParcelInfo instance) =>
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
