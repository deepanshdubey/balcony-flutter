// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromoModel _$PromoModelFromJson(Map<String, dynamic> json) => PromoModel(
      success: json['success'] as bool?,
      promo: json['promo'] == null
          ? null
          : Promo.fromJson(json['promo'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$PromoModelToJson(PromoModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'promo': instance.promo,
      'message': instance.message,
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
