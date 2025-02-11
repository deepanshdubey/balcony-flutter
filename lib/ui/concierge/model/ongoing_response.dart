import 'package:homework/data/model/response/tenant_details.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ongoing_response.g.dart'; 

@JsonSerializable(ignoreUnannotated: true)
class OngoingResponse {
  @JsonKey(name: 'success')
  final  bool? success;
  @JsonKey(name: 'parcels')
  final  List<Parcel>? parcels;

  OngoingResponse({this.success, this.parcels});

   factory OngoingResponse.fromJson(Map<String, dynamic> json) => _$OngoingResponseFromJson(json);

   Map<String, dynamic> toJson() => _$OngoingResponseToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Parcel {
  @JsonKey(name: '_id')
  final  String? Id;
  @JsonKey(name: 'count')
  final  int? count;
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

  Parcel({this.Id, this.count, this.note, this.status, this.createdAt, this.updatedAt, this.tenant});

   factory Parcel.fromJson(Map<String, dynamic> json) => _$ParcelFromJson(json);

   Map<String, dynamic> toJson() => _$ParcelToJson(this);
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

