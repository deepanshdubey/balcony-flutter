import 'package:homework/data/model/response/workspace_data.dart';
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

  @UnitListConverter()
  @JsonKey(name: 'unitList')
  final List<UnitList>? unitList;

  @JsonKey(name: 'host')
  @HostConverter()
  final dynamic? host;

  PropertyData(
      {this.id,
      this.status,
      this.ratings,
      this.info,
      this.images,
      this.geocode,
      this.pricing,
      this.times,
      this.other,
      this.amenities,
      this.unitList,
      this.host});

  factory PropertyData.fromJson(Map<String, dynamic> json) =>
      _$PropertyDataFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyDataToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class UnitList {
  @JsonKey(name: '_id')
  final String? Id;
  @JsonKey(name: 'unit')
  final int? unit;
  @JsonKey(name: 'price')
  final num? price;
  @JsonKey(name: 'beds')
  final int? beds;
  @JsonKey(name: 'baths')
  final int? baths;
  @JsonKey(name: 'floorPlanImg')
  String? floorPlanImg;
  @JsonKey(name: 'isAvailable')
  final bool? isAvailable;
  @JsonKey(name: 'status')
  final String? status;

  UnitList({
    this.Id,
    this.unit,
    this.price,
    this.beds,
    this.baths,
    this.floorPlanImg,
    this.isAvailable,
    this.status,
  });

  factory UnitList.fromJson(Map<String, dynamic> json) =>
      _$UnitListFromJson(json);

  Map<String, dynamic> toJson() => _$UnitListToJson(this);
}

class UnitListConverter implements JsonConverter<List<UnitList>, dynamic> {
  const UnitListConverter();

  @override
  List<UnitList> fromJson(dynamic json) {
    if (json is List) {
      return json
          .whereType<
              Map<String,
                  dynamic>>() // Ensure that each item is a Map<String, dynamic>
          .map((e) => UnitList.fromJson(e)) // Convert the map to UnitList
          .toList();
    }
    return []; // Return an empty list if JSON is not a List
  }

  @override
  dynamic toJson(List<UnitList> object) {
    return object
        .map((e) => e.toJson())
        .toList(); // Convert the list of UnitList to JSON
  }
}
