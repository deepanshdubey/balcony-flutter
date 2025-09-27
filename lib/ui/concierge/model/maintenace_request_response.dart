import 'package:homework/data/model/response/tenant_details.dart';
import 'package:json_annotation/json_annotation.dart';

part 'maintenace_request_response.g.dart'; 

@JsonSerializable(ignoreUnannotated: true)
class MaintenaceRequestResponse {
  @JsonKey(name: 'success')
  final  bool? success;
  @JsonKey(name: 'requests')
  final  List<Request>? requests;

  MaintenaceRequestResponse({this.success, this.requests});

   factory MaintenaceRequestResponse.fromJson(Map<String, dynamic> json) => _$MaintenaceRequestResponseFromJson(json);

   Map<String, dynamic> toJson() => _$MaintenaceRequestResponseToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Request {
  @JsonKey(name: '_id')
  final  String? Id;
  @JsonKey(name: 'note')
  final  String? note;
  @JsonKey(name: 'status')
  final  String? status;
  @JsonKey(name: 'createdAt')
  final  String? createdAt;
  @JsonKey(name: 'updatedAt')
  final  String? updatedAt;
  @JsonKey(name: 'tenant')
  final  Tenant? tenant;

  Request({this.Id, this.note, this.status, this.createdAt, this.updatedAt, this.tenant});

   factory Request.fromJson(Map<String, dynamic> json) => _$RequestFromJson(json);

   Map<String, dynamic> toJson() => _$RequestToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Tenant {
  @JsonKey(name: '_id')
  final  String? Id;
  @JsonKey(name: 'parcels')
  final  int? parcels;
  @JsonKey(name: 'info')
  final  Info? info;
  @JsonKey(name: 'selectedUnit')
  final  SelectedUnit? selectedUnit;

  Tenant({this.Id, this.parcels, this.info, this.selectedUnit});

   factory Tenant.fromJson(Map<String, dynamic> json) => _$TenantFromJson(json);

   Map<String, dynamic> toJson() => _$TenantToJson(this);
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

