import 'package:balcony/data/model/response/workspace_data.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'property_data.g.dart';

@JsonSerializable()
class PropertyData {
  @JsonKey(name: '_id')
  final String? id;

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
  final List<String>? amenities;

  PropertyData({
    this.id,
    this.status,
    this.ratings,
    this.info,
    this.images,
    this.geocode,
    this.pricing,
    this.times,
    this.other,
    this.amenities,
  });

  factory PropertyData.fromJson(Map<String, dynamic> json) =>
      _$PropertyDataFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyDataToJson(this);
}
