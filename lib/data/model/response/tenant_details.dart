import 'package:json_annotation/json_annotation.dart'; 

part 'tenant_details.g.dart'; 

@JsonSerializable(ignoreUnannotated: true)
class TenantDetails {
  @JsonKey(name: 'tenants')
  final  Tenants? tenants;

  TenantDetails({this.tenants});

   factory TenantDetails.fromJson(Map<String, dynamic> json) => _$TenantDetailsFromJson(json);

   Map<String, dynamic> toJson() => _$TenantDetailsToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Tenants {
  @JsonKey(name: '_id')
  final  String? Id;
  @JsonKey(name: 'userId')
  final  String? userId;
  @JsonKey(name: 'info')
  final  Info? info;
  @JsonKey(name: 'selectedUnit')
  final  SelectedUnit? selectedUnit;
  @JsonKey(name: 'status')
  final  String? status;
  @JsonKey(name: 'acceptance')
  final  String? acceptance;
  @JsonKey(name: 'agreement')
  final  Agreement? agreement;
  @JsonKey(name: 'paymentSource')
  final  String? paymentSource;
  @JsonKey(name: 'lastPaymentDate')
  final  String? lastPaymentDate;
  @JsonKey(name: 'createdAt')
  final  String? createdAt;
  @JsonKey(name: 'updatedAt')
  final  String? updatedAt;

  Tenants({this.Id, this.userId, this.info, this.selectedUnit, this.status, this.acceptance, this.agreement, this.paymentSource, this.lastPaymentDate, this.createdAt, this.updatedAt});

   factory Tenants.fromJson(Map<String, dynamic> json) => _$TenantsFromJson(json);

   Map<String, dynamic> toJson() => _$TenantsToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Info {
  @JsonKey(name: 'firstName')
  final  String? firstName;
  @JsonKey(name: 'lastName')
  final  String? lastName;
  @JsonKey(name: 'email')
  final  String? email;
  @JsonKey(name: 'phone')
  final  String? phone;
  @JsonKey(name: 'socialSecurityNo')
  final  String? socialSecurityNo;
  @JsonKey(name: 'moveInRequest')
  final  String? moveInRequest;
  @JsonKey(name: 'note')
  final  String? note;
  @JsonKey(name: 'name')
  final  String? name;
  @JsonKey(name: 'address')
  final  String? address;
  @JsonKey(name: 'docs')
  final  List<String>? docs;

  Info({this.name, this.address, this.firstName, this.lastName, this.email, this.phone, this.socialSecurityNo, this.moveInRequest, this.note, this.docs});

   factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);

   Map<String, dynamic> toJson() => _$InfoToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class SelectedUnit {
  @JsonKey(name: '_id')
  final  String? Id;
  @JsonKey(name: 'unit')
  final  int? unit;
  @JsonKey(name: 'price')
  final  int? price;
  @JsonKey(name: 'beds')
  final  int? beds;
  @JsonKey(name: 'baths')
  final  int? baths;
  @JsonKey(name: 'floorPlanImg')
  final  String? floorPlanImg;
  @JsonKey(name: 'isAvailable')
  final  bool? isAvailable;
  @JsonKey(name: 'status')
  final  String? status;
  @JsonKey(name: 'property')
  final  Property? property;

  SelectedUnit({this.Id, this.unit, this.price, this.beds, this.baths, this.floorPlanImg, this.isAvailable, this.status, this.property});

   factory SelectedUnit.fromJson(Map<String, dynamic> json) => _$SelectedUnitFromJson(json);

   Map<String, dynamic> toJson() => _$SelectedUnitToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Property {
  @JsonKey(name: '_id')
  final  String? Id;
  @JsonKey(name: 'host')
  final  Host? host;
  @JsonKey(name: 'status')
  final  String? status;
  @JsonKey(name: 'ratings')
  final  int? ratings;
  @JsonKey(name: 'info')
  final  Info? info;
  @JsonKey(name: 'geocode')
  final  Geocode? geocode;
  @JsonKey(name: 'images')
  final  List<String>? images;
  @JsonKey(name: 'currency')
  final  String? currency;
  @JsonKey(name: 'unitList')
  final  List<UnitList>? unitList;
  @JsonKey(name: 'other')
  final  Other? other;
  @JsonKey(name: 'amenities')
  final  List<String>? amenities;

  Property({this.Id, this.host, this.status, this.ratings, this.info, this.geocode, this.images, this.currency, this.unitList, this.other, this.amenities});

   factory Property.fromJson(Map<String, dynamic> json) => _$PropertyFromJson(json);

   Map<String, dynamic> toJson() => _$PropertyToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Host {
  @JsonKey(name: '_id')
  final  String? Id;
  @JsonKey(name: 'firstName')
  final  String? firstName;
  @JsonKey(name: 'lastName')
  final  String? lastName;
  @JsonKey(name: 'email')
  final  String? email;
  @JsonKey(name: 'phone')
  final  String? phone;
  @JsonKey(name: 'image')
  final  String? image;
  @JsonKey(name: 'role')
  final  String? role;
  @JsonKey(name: 'status')
  final  String? status;
  @JsonKey(name: 'isWorkspaceAccountConnected')
  final  bool? isWorkspaceAccountConnected;
  @JsonKey(name: 'isPropertyAccountConnected')
  final  bool? isPropertyAccountConnected;

  Host({this.Id, this.firstName, this.lastName, this.email, this.phone, this.image, this.role, this.status, this.isWorkspaceAccountConnected, this.isPropertyAccountConnected});

   factory Host.fromJson(Map<String, dynamic> json) => _$HostFromJson(json);

   Map<String, dynamic> toJson() => _$HostToJson(this);
}



@JsonSerializable(ignoreUnannotated: true)
class Geocode {
  @JsonKey(name: 'lat')
  final  double? lat;
  @JsonKey(name: 'lon')
  final  double? lon;

  Geocode({this.lat, this.lon});

   factory Geocode.fromJson(Map<String, dynamic> json) => _$GeocodeFromJson(json);

   Map<String, dynamic> toJson() => _$GeocodeToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class UnitList {
  @JsonKey(name: '_id')
  final  String? Id;
  @JsonKey(name: 'unit')
  final  int? unit;
  @JsonKey(name: 'price')
  final  int? price;
  @JsonKey(name: 'beds')
  final  int? beds;
  @JsonKey(name: 'baths')
  final  int? baths;
  @JsonKey(name: 'floorPlanImg')
  final  String? floorPlanImg;
  @JsonKey(name: 'isAvailable')
  final  bool? isAvailable;
  @JsonKey(name: 'status')
  final  String? status;

  UnitList({this.Id, this.unit, this.price, this.beds, this.baths, this.floorPlanImg, this.isAvailable, this.status});

   factory UnitList.fromJson(Map<String, dynamic> json) => _$UnitListFromJson(json);

   Map<String, dynamic> toJson() => _$UnitListToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Other {
  @JsonKey(name: 'chargeFeeFromRent')
  final  bool? chargeFeeFromRent;
  @JsonKey(name: 'chargeFeeAsAddition')
  final  bool? chargeFeeAsAddition;
  @JsonKey(name: 'leaseDuration')
  final  int? leaseDuration;
  @JsonKey(name: 'leasingPolicyDoc')
  final  String? leasingPolicyDoc;

  Other({this.chargeFeeFromRent, this.chargeFeeAsAddition, this.leaseDuration, this.leasingPolicyDoc});

   factory Other.fromJson(Map<String, dynamic> json) => _$OtherFromJson(json);

   Map<String, dynamic> toJson() => _$OtherToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Agreement {
  @JsonKey(name: 'rent')
  final  int? rent;
  @JsonKey(name: 'securityDepositFee')
  final  int? securityDepositFee;
  @JsonKey(name: 'isRefunded')
  final  bool? isRefunded;
  @JsonKey(name: 'discount')
  final  int? discount;
  @JsonKey(name: 'leaseStartDate')
  final  String? leaseStartDate;
  @JsonKey(name: 'leaseEndDate')
  final  String? leaseEndDate;
  @JsonKey(name: 'renewOn')
  final  String? renewOn;

  Agreement({this.rent, this.securityDepositFee, this.isRefunded, this.discount, this.leaseStartDate, this.leaseEndDate, this.renewOn});

   factory Agreement.fromJson(Map<String, dynamic> json) => _$AgreementFromJson(json);

   Map<String, dynamic> toJson() => _$AgreementToJson(this);
}

