import 'package:json_annotation/json_annotation.dart'; 

part 'promo_list_model.g.dart'; 

@JsonSerializable(ignoreUnannotated: true)
class PromoListModel {
  @JsonKey(name: 'success')
  final  bool? success;
  @JsonKey(name: 'promos')
  final  List<Promo>? promos;

  PromoListModel({this.success, this.promos});

   factory PromoListModel.fromJson(Map<String, dynamic> json) => _$PromoListModelFromJson(json);

   Map<String, dynamic> toJson() => _$PromoListModelToJson(this);
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

