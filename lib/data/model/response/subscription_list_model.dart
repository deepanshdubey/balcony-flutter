import 'package:json_annotation/json_annotation.dart'; 

part 'subscription_list_model.g.dart'; 

@JsonSerializable(ignoreUnannotated: true)
class SubscriptionListModel {
  @JsonKey(name: 'success')
  final  bool? success;
  @JsonKey(name: 'plans')
  final  List<Plan>? plans;

  SubscriptionListModel({this.success, this.plans});

   factory SubscriptionListModel.fromJson(Map<String, dynamic> json) => _$SubscriptionListModelFromJson(json);

   Map<String, dynamic> toJson() => _$SubscriptionListModelToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Plan {
  @JsonKey(name: 'id')
  final  String? id;
  @JsonKey(name: 'name')
  final  String? name;
  @JsonKey(name: 'units')
  final  int? units;
  @JsonKey(name: 'concierge')
  final  int? concierge;
  @JsonKey(name: 'price')
  final  int? price;
  @JsonKey(name: 'currency')
  final  String? currency;

  Plan({this.id, this.name, this.units, this.concierge, this.price, this.currency});

   factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);

   Map<String, dynamic> toJson() => _$PlanToJson(this);
}

