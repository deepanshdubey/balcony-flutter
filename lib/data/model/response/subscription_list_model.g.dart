// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionListModel _$SubscriptionListModelFromJson(
        Map<String, dynamic> json) =>
    SubscriptionListModel(
      success: json['success'] as bool?,
      plans: (json['plans'] as List<dynamic>?)
          ?.map((e) => Plan.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubscriptionListModelToJson(
        SubscriptionListModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'plans': instance.plans,
    };

Plan _$PlanFromJson(Map<String, dynamic> json) => Plan(
      id: json['id'] as String?,
      name: json['name'] as String?,
      units: (json['units'] as num?)?.toInt(),
      concierge: (json['concierge'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
      currency: json['currency'] as String?,
    );

Map<String, dynamic> _$PlanToJson(Plan instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'units': instance.units,
      'concierge': instance.concierge,
      'price': instance.price,
      'currency': instance.currency,
    };
