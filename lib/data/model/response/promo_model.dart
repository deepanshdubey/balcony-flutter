import 'package:json_annotation/json_annotation.dart'; 

part 'promo_model.g.dart'; 

@JsonSerializable(ignoreUnannotated: true)
class PromoModel {
  @JsonKey(name: 'success')
  final  bool? success;
  @JsonKey(name: 'promo')
  final  Promo? promo;

  @JsonKey(name: 'message')
  final  String? message;

  PromoModel({this.success, this.promo,this.message});

   factory PromoModel.fromJson(Map<String, dynamic> json) => _$PromoModelFromJson(json);

   Map<String, dynamic> toJson() => _$PromoModelToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Promo {
  @JsonKey(name: 'code')
  final  String? code;
  @JsonKey(name: 'type')
  final  String? type;
  @JsonKey(name: 'discount')
  final  int? discount;
  @JsonKey(name: 'applicableOn')
  final  String? applicableOn;

  Promo({this.code, this.type, this.discount, this.applicableOn});

   factory Promo.fromJson(Map<String, dynamic> json) => _$PromoFromJson(json);

   Map<String, dynamic> toJson() => _$PromoToJson(this);
}

