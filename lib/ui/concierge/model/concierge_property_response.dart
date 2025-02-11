import 'package:homework/data/model/response/tenant_details.dart';
import 'package:json_annotation/json_annotation.dart';

part 'concierge_property_response.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class ConciergePropertyResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'properties')
  final Properties? properties;
  @JsonKey(name: 'property')
  final Property? property;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'tenants')
  final  Tenants? tenants;

  ConciergePropertyResponse({this.tenants, this.message, this.property, this.success, this.properties});

  factory ConciergePropertyResponse.fromJson(Map<String, dynamic> json) =>
      _$ConciergePropertyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConciergePropertyResponseToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Properties {
  @JsonKey(name: 'leasingProperties')
  final List<LeasingPropertie>? leasingProperties;
  @JsonKey(name: 'conciergeProperties')
  final List<ConciergePropertie>? conciergeProperties;

  Properties({this.leasingProperties, this.conciergeProperties});

  factory Properties.fromJson(Map<String, dynamic> json) =>
      _$PropertiesFromJson(json);

  Map<String, dynamic> toJson() => _$PropertiesToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class LeasingPropertie {
  @JsonKey(name: '_id')
  final String? Id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'hostId')
  final String? hostId;

  LeasingPropertie({this.Id, this.name, this.hostId});

  factory LeasingPropertie.fromJson(Map<String, dynamic> json) =>
      _$LeasingPropertieFromJson(json);

  Map<String, dynamic> toJson() => _$LeasingPropertieToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class ConciergePropertie {
  @JsonKey(name: '_id')
  final String? Id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'hostId')
  final String? hostId;

  ConciergePropertie({this.Id, this.name, this.hostId});

  factory ConciergePropertie.fromJson(Map<String, dynamic> json) =>
      _$ConciergePropertieFromJson(json);

  Map<String, dynamic> toJson() => _$ConciergePropertieToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Property {
  @JsonKey(name: '_id')
  final String? Id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'hostId')
  final String? hostId;

  Property({this.Id, this.name, this.hostId});

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyToJson(this);
}
