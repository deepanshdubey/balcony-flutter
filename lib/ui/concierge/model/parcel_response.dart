import 'package:homework/ui/concierge/model/ongoing_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parcel_response.g.dart'; 

@JsonSerializable(ignoreUnannotated: true)
class ParcelResponse {
  @JsonKey(name: 'success')
  final  bool? success;
  @JsonKey(name: 'message')
  final  String? message;
  @JsonKey(name: 'parcels')
  final  List<Parcel>? parcels;

  ParcelResponse({this.message, this.success, this.parcels});

   factory ParcelResponse.fromJson(Map<String, dynamic> json) => _$ParcelResponseFromJson(json);

   Map<String, dynamic> toJson() => _$ParcelResponseToJson(this);
}



@JsonSerializable(ignoreUnannotated: true)
class Tenant {
  @JsonKey(name: '_id')
  final  String? Id;
  @JsonKey(name: 'info')
  final  ParcelInfo? info;
  @JsonKey(name: 'selectedUnit')
  final  SelectedUnit? selectedUnit;

  Tenant({this.Id, this.info, this.selectedUnit});

   factory Tenant.fromJson(Map<String, dynamic> json) => _$TenantFromJson(json);

   Map<String, dynamic> toJson() => _$TenantToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class ParcelInfo {
  @JsonKey(name: 'firstName')
  final  String? firstName;
  @JsonKey(name: 'lastName')
  final  String? lastName;
  @JsonKey(name: 'email')
  final  String? email;
  @JsonKey(name: 'phone')
  final  String? phone;

  ParcelInfo({this.firstName, this.lastName, this.email, this.phone});

   factory ParcelInfo.fromJson(Map<String, dynamic> json) => _$ParcelInfoFromJson(json);

   Map<String, dynamic> toJson() => _$ParcelInfoToJson(this);
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

