import 'package:homework/data/model/response/workspace_data.dart';
import 'package:homework/ui/concierge/model/parcel_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_tenant_model.g.dart'; 

@JsonSerializable(ignoreUnannotated: true)
class AddTenantModel {
  @JsonKey(name: 'success')
  final  bool? success;
  @JsonKey(name: 'tenant')
  final  Tenant? tenant;

  AddTenantModel({this.success, this.tenant});

   factory AddTenantModel.fromJson(Map<String, dynamic> json) => _$AddTenantModelFromJson(json);

   Map<String, dynamic> toJson() => _$AddTenantModelToJson(this);
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




