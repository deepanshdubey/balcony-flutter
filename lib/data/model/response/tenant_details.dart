import 'package:homework/data/model/response/property_data.dart';
import 'package:homework/data/model/response/workspace_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tenant_details.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class TenantDetails {
  @JsonKey(name: 'tenants')
  final Tenants? tenants;

  TenantDetails({this.tenants});

  factory TenantDetails.fromJson(Map<String, dynamic> json) =>
      _$TenantDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$TenantDetailsToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Tenants {
  @JsonKey(name: '_id')
  final String? Id;
  @JsonKey(name: 'userId')
  final String? userId;
  @JsonKey(name: 'info')
  final Info? info;
  @JsonKey(name: 'selectedUnit')
  final SelectedUnit? selectedUnit;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'acceptance')
  final String? acceptance;
  @JsonKey(name: 'agreement')
  final Agreement? agreement;
  @JsonKey(name: 'paymentSource')
  final String? paymentSource;
  @JsonKey(name: 'lastPaymentDate')
  final String? lastPaymentDate;
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  Tenants(
      {this.Id,
      this.userId,
      this.info,
      this.selectedUnit,
      this.status,
      this.acceptance,
      this.agreement,
      this.paymentSource,
      this.lastPaymentDate,
      this.createdAt,
      this.updatedAt});

  factory Tenants.fromJson(Map<String, dynamic> json) =>
      _$TenantsFromJson(json);

  Map<String, dynamic> toJson() => _$TenantsToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Info {
  /*
      "firstName": "Kavya",
      "lastName": "Gaur",
      "email": "kavyagaur36@gmail.com",
      "phone": "+917878788780",
      "country": "united states",
      "moveInRequest": "2025-05-28T00:00:00.000Z",
      "note": "sf addis fodsjf sdjfo ",
      "docs": [https://example.com/doc1.pdf, https://example.com/doc2.pdf]
   */
  @JsonKey(name: 'firstName')
  final String? firstName;
  @JsonKey(name: 'lastName')
  final String? lastName;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'moveInRequest')
  final String? moveInRequest;
  @JsonKey(name: 'note')
  final String? note;
  @JsonKey(name: 'country')
  final String? country;
  @JsonKey(name: 'docs')
  final List<String>? docs;

  Info({
    this.country,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.moveInRequest,
    this.note,
    this.docs,
  });

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);

  Map<String, dynamic> toJson() => _$InfoToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class SelectedUnit {
  @JsonKey(name: '_id')
  final String? Id;
  @JsonKey(name: 'unit')
  final int? unit;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'beds')
  final int? beds;
  @JsonKey(name: 'baths')
  final int? baths;
  @JsonKey(name: 'floorPlanImg')
  final String? floorPlanImg;
  @JsonKey(name: 'isAvailable')
  final bool? isAvailable;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'property')
  final PropertyData? property;

  SelectedUnit(
      {this.Id,
      this.unit,
      this.price,
      this.beds,
      this.baths,
      this.floorPlanImg,
      this.isAvailable,
      this.status,
      this.property});

  factory SelectedUnit.fromJson(Map<String, dynamic> json) =>
      _$SelectedUnitFromJson(json);

  Map<String, dynamic> toJson() => _$SelectedUnitToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Property {
  @JsonKey(name: '_id')
  final String? Id;
  @JsonKey(name: 'host')
  final Host? host;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'ratings')
  final int? ratings;
  @JsonKey(name: 'info')
  final Info? info;
  @JsonKey(name: 'geocode')
  final Geocode? geocode;
  @JsonKey(name: 'images')
  final List<String>? images;
  @JsonKey(name: 'currency')
  final String? currency;
  @JsonKey(name: 'unitList')
  final List<UnitList>? unitList;
  @JsonKey(name: 'other')
  final Other? other;
  @JsonKey(name: 'amenities')
  final List<String>? amenities;

  Property(
      {this.Id,
      this.host,
      this.status,
      this.ratings,
      this.info,
      this.geocode,
      this.images,
      this.currency,
      this.unitList,
      this.other,
      this.amenities});

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Agreement {
  @JsonKey(name: 'rent')
  final int? rent;
  @JsonKey(name: 'securityDepositFee')
  final int? securityDepositFee;
  @JsonKey(name: 'isRefunded')
  final bool? isRefunded;
  @JsonKey(name: 'discount')
  final int? discount;
  @JsonKey(name: 'leaseStartDate')
  final String? leaseStartDate;
  @JsonKey(name: 'leaseEndDate')
  final String? leaseEndDate;
  @JsonKey(name: 'renewOn')
  final String? renewOn;

  Agreement(
      {this.rent,
      this.securityDepositFee,
      this.isRefunded,
      this.discount,
      this.leaseStartDate,
      this.leaseEndDate,
      this.renewOn});

  factory Agreement.fromJson(Map<String, dynamic> json) =>
      _$AgreementFromJson(json);

  Map<String, dynamic> toJson() => _$AgreementToJson(this);
}
