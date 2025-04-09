import 'package:json_annotation/json_annotation.dart'; 

part 'concierge_tanant_response.g.dart'; 

@JsonSerializable(ignoreUnannotated: true)
class ConciergeTanantResponse {
  @JsonKey(name: 'success')
  final  bool? success;
  @JsonKey(name: 'tenants')
  final  Tenants? tenants;

  ConciergeTanantResponse({this.success, this.tenants});

   factory ConciergeTanantResponse.fromJson(Map<String, dynamic> json) => _$ConciergeTanantResponseFromJson(json);

   Map<String, dynamic> toJson() => _$ConciergeTanantResponseToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Tenants {
  @JsonKey(name: 'conciergeTenants')
  final  List<ConciergeTenant>? conciergeTenants;
  @JsonKey(name: 'leasingTenants')
  final  List<ConciergeTenant>? leasingTenants;

  Tenants({this.leasingTenants, this.conciergeTenants});

   factory Tenants.fromJson(Map<String, dynamic> json) => _$TenantsFromJson(json);

   Map<String, dynamic> toJson() => _$TenantsToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class ConciergeTenant {
  @JsonKey(name: '_id')
  final  String? Id;
  @JsonKey(name: 'info')
  final  ConciergeInfo? info;
  @JsonKey(name: 'selectedUnit')
  final  SelectedUnit? selectedUnit;
  @JsonKey(name: 'parcels')
  final  int? parcels;

  ConciergeTenant({this.Id, this.info, this.selectedUnit, this.parcels});

   factory ConciergeTenant.fromJson(Map<String, dynamic> json) => _$ConciergeTenantFromJson(json);

   Map<String, dynamic> toJson() => _$ConciergeTenantToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class ConciergeInfo {
  @JsonKey(name: 'firstName')
  final  String? firstName;
  @JsonKey(name: 'lastName')
  final  String? lastName;
  @JsonKey(name: 'email')
  final  String? email;
  @JsonKey(name: 'phone')
  final  String? phone;

  ConciergeInfo({this.firstName, this.lastName, this.email, this.phone});

   factory ConciergeInfo.fromJson(Map<String, dynamic> json) => _$ConciergeInfoFromJson(json);

   Map<String, dynamic> toJson() => _$ConciergeInfoToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class SelectedUnit {
  @JsonKey(name: '_id')
  final  String? Id;
  @JsonKey(name: 'unit')
  final  int? unit;
  @JsonKey(name: 'property')
  final  Property? property;

  SelectedUnit({this.Id, this.unit, this.property});

   factory SelectedUnit.fromJson(Map<String, dynamic> json) => _$SelectedUnitFromJson(json);

   Map<String, dynamic> toJson() => _$SelectedUnitToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Property {
  @JsonKey(name: '_id')
  final  String? Id;
  @JsonKey(name: 'name')
  final  String? name;
  @JsonKey(name: 'hostId')
  final  String? hostId;

  Property({this.Id, this.name, this.hostId});

   factory Property.fromJson(Map<String, dynamic> json) => _$PropertyFromJson(json);

   Map<String, dynamic> toJson() => _$PropertyToJson(this);
}

