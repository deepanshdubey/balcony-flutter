// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkspaceData _$WorkspaceDataFromJson(Map<String, dynamic> json) =>
    WorkspaceData(
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
      host: const HostConverter().fromJson(json['host']),
    );

Map<String, dynamic> _$WorkspaceDataToJson(WorkspaceData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'status': instance.status,
      'ratings': instance.ratings,
      'info': instance.info,
      'images': instance.images,
      'geocode': instance.geocode,
      'host': const HostConverter().toJson(instance.host),
      'pricing': instance.pricing,
      'times': instance.times,
      'other': instance.other,
      'amenities': instance.amenities,
    };

Info _$InfoFromJson(Map<String, dynamic> json) => Info(
      name: json['name'] as String?,
      address: json['address'] as String?,
      floor: json['floor'] as String? ?? "",
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      summary: json['summary'] as String?,
    );

Map<String, dynamic> _$InfoToJson(Info instance) => <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'floor': instance.floor,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'summary': instance.summary,
    };

Geocode _$GeocodeFromJson(Map<String, dynamic> json) => Geocode(
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$GeocodeToJson(Geocode instance) => <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
    };

Pricing _$PricingFromJson(Map<String, dynamic> json) => Pricing(
      currency: json['currency'] as String?,
      totalPerDay: json['totalPerDay'] as num?,
      cleaning: json['cleaning'] == null
          ? null
          : Fee.fromJson(json['cleaning'] as Map<String, dynamic>),
      maintenance: json['maintenance'] == null
          ? null
          : Fee.fromJson(json['maintenance'] as Map<String, dynamic>),
      additional: json['additional'] == null
          ? null
          : Fee.fromJson(json['additional'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PricingToJson(Pricing instance) => <String, dynamic>{
      'currency': instance.currency,
      'totalPerDay': instance.totalPerDay,
      'cleaning': instance.cleaning,
      'maintenance': instance.maintenance,
      'additional': instance.additional,
    };

Fee _$FeeFromJson(Map<String, dynamic> json) => Fee(
      fee: json['fee'] as num?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$FeeToJson(Fee instance) => <String, dynamic>{
      'fee': instance.fee,
      'type': instance.type,
    };

Times _$TimesFromJson(Map<String, dynamic> json) => Times(
      sunday: json['sunday'] == null
          ? null
          : DayTime.fromJson(json['sunday'] as Map<String, dynamic>),
      monday: json['monday'] == null
          ? null
          : DayTime.fromJson(json['monday'] as Map<String, dynamic>),
      tuesday: json['tuesday'] == null
          ? null
          : DayTime.fromJson(json['tuesday'] as Map<String, dynamic>),
      wednesday: json['wednesday'] == null
          ? null
          : DayTime.fromJson(json['wednesday'] as Map<String, dynamic>),
      thursday: json['thursday'] == null
          ? null
          : DayTime.fromJson(json['thursday'] as Map<String, dynamic>),
      friday: json['friday'] == null
          ? null
          : DayTime.fromJson(json['friday'] as Map<String, dynamic>),
      saturday: json['saturday'] == null
          ? null
          : DayTime.fromJson(json['saturday'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TimesToJson(Times instance) => <String, dynamic>{
      'sunday': instance.sunday,
      'monday': instance.monday,
      'tuesday': instance.tuesday,
      'wednesday': instance.wednesday,
      'thursday': instance.thursday,
      'friday': instance.friday,
      'saturday': instance.saturday,
    };

DayTime _$DayTimeFromJson(Map<String, dynamic> json) => DayTime(
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
    );

Map<String, dynamic> _$DayTimeToJson(DayTime instance) => <String, dynamic>{
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };

Other _$OtherFromJson(Map<String, dynamic> json) => Other(
      isIndoorSpace: json['isIndoorSpace'] as bool?,
      isOutdoorSpace: json['isOutdoorSpace'] as bool?,
      isCoWorkingWorkspace: json['isCoWorkingWorkspace'] as bool?,
      additionalGuests: (json['additionalGuests'] as num?)?.toInt(),
      leaseDuration: (json['leaseDuration'] as num?)?.toInt(),
      chargeFeeAsAddition: json['chargeFeeAsAddition'] as bool?,
      chargeFeeFromRent: json['chargeFeeFromRent'] as bool?,
    );

Map<String, dynamic> _$OtherToJson(Other instance) => <String, dynamic>{
      'isIndoorSpace': instance.isIndoorSpace,
      'isOutdoorSpace': instance.isOutdoorSpace,
      'isCoWorkingWorkspace': instance.isCoWorkingWorkspace,
      'additionalGuests': instance.additionalGuests,
      'leaseDuration': instance.leaseDuration,
      'chargeFeeAsAddition': instance.chargeFeeAsAddition,
      'chargeFeeFromRent': instance.chargeFeeFromRent,
    };

Host _$HostFromJson(Map<String, dynamic> json) => Host(
      Id: json['_id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      role: json['role'] as String?,
      status: json['status'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$HostToJson(Host instance) => <String, dynamic>{
      '_id': instance.Id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'role': instance.role,
      'status': instance.status,
      'image': instance.image,
    };
