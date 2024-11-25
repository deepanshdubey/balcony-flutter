import 'package:json_annotation/json_annotation.dart';

part 'card_data.g.dart';

@JsonSerializable()
class CardData {
  @JsonKey(name: '_id')
  final String? id;

  final String? name;

  @JsonKey(name: 'cardNo')
  final String? cardNumber;

  final String? brand;

  final String? expiry;

  @JsonKey(name: 'default')
  final bool? isDefault;

  CardData({
    this.id,
    this.name,
    this.cardNumber,
    this.brand,
    this.expiry,
    this.isDefault,
  });

  /// A factory constructor to create an instance from JSON.
  factory CardData.fromJson(Map<String, dynamic> json) =>
      _$CardDataFromJson(json);

  /// A method to convert the instance to JSON.
  Map<String, dynamic> toJson() => _$CardDataToJson(this);
}
