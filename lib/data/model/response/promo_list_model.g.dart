// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promo_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromoListModel _$PromoListModelFromJson(Map<String, dynamic> json) =>
    PromoListModel(
      success: json['success'] as bool?,
      promos: (json['promos'] as List<dynamic>?)
          ?.map((e) => Promo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PromoListModelToJson(PromoListModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'promos': instance.promos,
    };

Promo _$PromoFromJson(Map<String, dynamic> json) => Promo(
      code: json['code'] as String?,
      type: json['type'] as String?,
      discount: (json['discount'] as num?)?.toInt(),
      applicableOn: json['applicableOn'] as String?,
    );

Map<String, dynamic> _$PromoToJson(Promo instance) => <String, dynamic>{
      'code': instance.code,
      'type': instance.type,
      'discount': instance.discount,
      'applicableOn': instance.applicableOn,
    };
