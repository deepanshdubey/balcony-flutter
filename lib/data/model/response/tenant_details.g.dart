// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TenantDetails _$TenantDetailsFromJson(Map<String, dynamic> json) =>
    TenantDetails(
      tenants: json['tenants'] == null
          ? null
          : Tenants.fromJson(json['tenants'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TenantDetailsToJson(TenantDetails instance) =>
    <String, dynamic>{
      'tenants': instance.tenants,
    };

Tenants _$TenantsFromJson(Map<String, dynamic> json) => Tenants(
      Id: json['_id'] as String?,
      userId: json['userId'] as String?,
      info: json['info'] == null
          ? null
          : Info.fromJson(json['info'] as Map<String, dynamic>),
      selectedUnit: json['selectedUnit'] == null
          ? null
          : SelectedUnit.fromJson(json['selectedUnit'] as Map<String, dynamic>),
      status: json['status'] as String?,
      acceptance: json['acceptance'] as String?,
      agreement: json['agreement'] == null
          ? null
          : Agreement.fromJson(json['agreement'] as Map<String, dynamic>),
      paymentSource: json['paymentSource'] as String?,
      lastPaymentDate: json['lastPaymentDate'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$TenantsToJson(Tenants instance) => <String, dynamic>{
      '_id': instance.Id,
      'userId': instance.userId,
      'info': instance.info,
      'selectedUnit': instance.selectedUnit,
      'status': instance.status,
      'acceptance': instance.acceptance,
      'agreement': instance.agreement,
      'paymentSource': instance.paymentSource,
      'lastPaymentDate': instance.lastPaymentDate,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

Info _$InfoFromJson(Map<String, dynamic> json) => Info(
      country: json['country'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      moveInRequest: json['moveInRequest'] as String?,
      note: json['note'] as String?,
      docs: (json['docs'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$InfoToJson(Info instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'moveInRequest': instance.moveInRequest,
      'note': instance.note,
      'country': instance.country,
      'docs': instance.docs,
    };

SelectedUnit _$SelectedUnitFromJson(Map<String, dynamic> json) => SelectedUnit(
      Id: json['_id'] as String?,
      unit: (json['unit'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
      beds: (json['beds'] as num?)?.toInt(),
      baths: (json['baths'] as num?)?.toInt(),
      floorPlanImg: json['floorPlanImg'] as String?,
      isAvailable: json['isAvailable'] as bool?,
      status: json['status'] as String?,
      property: json['property'] == null
          ? null
          : PropertyData.fromJson(json['property'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SelectedUnitToJson(SelectedUnit instance) =>
    <String, dynamic>{
      '_id': instance.Id,
      'unit': instance.unit,
      'price': instance.price,
      'beds': instance.beds,
      'baths': instance.baths,
      'floorPlanImg': instance.floorPlanImg,
      'isAvailable': instance.isAvailable,
      'status': instance.status,
      'property': instance.property,
    };

Property _$PropertyFromJson(Map<String, dynamic> json) => Property(
      Id: json['_id'] as String?,
      host: json['host'] == null
          ? null
          : Host.fromJson(json['host'] as Map<String, dynamic>),
      status: json['status'] as String?,
      ratings: (json['ratings'] as num?)?.toInt(),
      info: json['info'] == null
          ? null
          : Info.fromJson(json['info'] as Map<String, dynamic>),
      geocode: json['geocode'] == null
          ? null
          : Geocode.fromJson(json['geocode'] as Map<String, dynamic>),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      currency: json['currency'] as String?,
      unitList: (json['unitList'] as List<dynamic>?)
          ?.map((e) => UnitList.fromJson(e as Map<String, dynamic>))
          .toList(),
      other: json['other'] == null
          ? null
          : Other.fromJson(json['other'] as Map<String, dynamic>),
      amenities: (json['amenities'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PropertyToJson(Property instance) => <String, dynamic>{
      '_id': instance.Id,
      'host': instance.host,
      'status': instance.status,
      'ratings': instance.ratings,
      'info': instance.info,
      'geocode': instance.geocode,
      'images': instance.images,
      'currency': instance.currency,
      'unitList': instance.unitList,
      'other': instance.other,
      'amenities': instance.amenities,
    };

Agreement _$AgreementFromJson(Map<String, dynamic> json) => Agreement(
      rent: (json['rent'] as num?)?.toInt(),
      securityDepositFee: (json['securityDepositFee'] as num?)?.toInt(),
      isRefunded: json['isRefunded'] as bool?,
      discount: (json['discount'] as num?)?.toInt(),
      leaseStartDate: json['leaseStartDate'] as String?,
      leaseEndDate: json['leaseEndDate'] as String?,
      renewOn: json['renewOn'] as String?,
    );

Map<String, dynamic> _$AgreementToJson(Agreement instance) => <String, dynamic>{
      'rent': instance.rent,
      'securityDepositFee': instance.securityDepositFee,
      'isRefunded': instance.isRefunded,
      'discount': instance.discount,
      'leaseStartDate': instance.leaseStartDate,
      'leaseEndDate': instance.leaseEndDate,
      'renewOn': instance.renewOn,
    };
