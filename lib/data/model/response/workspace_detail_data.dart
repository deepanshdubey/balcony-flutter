import 'package:balcony/data/model/response/workspace_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'workspace_detail_data.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class WorkspaceDetailData {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final Data? data;

  WorkspaceDetailData({this.success, this.data});

  factory WorkspaceDetailData.fromJson(Map<String, dynamic> json) =>
      _$WorkspaceDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$WorkspaceDetailDataToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Data {
  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'items')
  final List<Item>? items;

  Data({this.count, this.items});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Item {
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
  @JsonKey(name: 'images')
  final List<String>? images;
  @JsonKey(name: 'geocode')
  final Geocode? geocode;
  @JsonKey(name: 'pricing')
  final Pricing? pricing;
  @JsonKey(name: 'times')
  final Times? times;
  @JsonKey(name: 'other')
  final Other? other;
  @JsonKey(name: 'amenities')
  final String? amenities;
  @JsonKey(name: 'bookedDates')
  final List<String>? bookedDates;

  Item(
      {this.Id,
      this.host,
      this.status,
      this.ratings,
      this.info,
      this.images,
      this.geocode,
      this.pricing,
      this.times,
      this.other,
      this.amenities,
      this.bookedDates});

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Host {
  @JsonKey(name: '_id')
  final String? Id;
  @JsonKey(name: 'firstName')
  final String? firstName;
  @JsonKey(name: 'lastName')
  final String? lastName;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'role')
  final String? role;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'isWorkspaceAccountConnected')
  final bool? isWorkspaceAccountConnected;
  @JsonKey(name: 'isPropertyAccountConnected')
  final bool? isPropertyAccountConnected;

  Host(
      {this.Id,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.image,
      this.role,
      this.status,
      this.isWorkspaceAccountConnected,
      this.isPropertyAccountConnected});

  factory Host.fromJson(Map<String, dynamic> json) => _$HostFromJson(json);

  Map<String, dynamic> toJson() => _$HostToJson(this);
}
