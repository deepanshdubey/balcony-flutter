// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyData _$PropertyDataFromJson(Map<String, dynamic> json) => PropertyData(
      id: json['_id'] as String?,
      status: json['status'] as String?,
      ratings: (json['ratings'] as num?)?.toInt(),
      info: json['info'] == null
          ? null
          : Info.fromJson(json['info'] as Map<String, dynamic>),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      geocode: json['geocode'] == null
          ? null
          : Geocode.fromJson(json['geocode'] as Map<String, dynamic>),
      pricing: json['pricing'] == null
          ? null
          : Pricing.fromJson(json['pricing'] as Map<String, dynamic>),
      times: json['times'] == null
          ? null
          : Times.fromJson(json['times'] as Map<String, dynamic>),
      other: json['other'] == null
          ? null
          : Other.fromJson(json['other'] as Map<String, dynamic>),
      amenities: (json['amenities'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      unitList: const UnitListConverter().fromJson(json['unitList']),
      host: const HostConverter().fromJson(json['host']),
    );

Map<String, dynamic> _$PropertyDataToJson(PropertyData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'status': instance.status,
      'ratings': instance.ratings,
      'info': instance.info,
      'images': instance.images,
      'geocode': instance.geocode,
      'pricing': instance.pricing,
      'times': instance.times,
      'other': instance.other,
      'amenities': instance.amenities,
      'unitList': _$JsonConverterToJson<dynamic, List<UnitList>>(
          instance.unitList, const UnitListConverter().toJson),
      'host': const HostConverter().toJson(instance.host),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

UnitList _$UnitListFromJson(Map<String, dynamic> json) => UnitList(
      Id: json['_id'] as String?,
      unit: (json['unit'] as num?)?.toInt(),
      price: json['price'] as num?,
      beds: (json['beds'] as num?)?.toInt(),
      baths: (json['baths'] as num?)?.toInt(),
      floorPlanImg: json['floorPlanImg'] as String?,
      isAvailable: json['isAvailable'] as bool?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$UnitListToJson(UnitList instance) => <String, dynamic>{
      '_id': instance.Id,
      'unit': instance.unit,
      'price': instance.price,
      'beds': instance.beds,
      'baths': instance.baths,
      'floorPlanImg': instance.floorPlanImg,
      'isAvailable': instance.isAvailable,
      'status': instance.status,
    };
