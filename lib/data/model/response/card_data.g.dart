// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardData _$CardDataFromJson(Map<String, dynamic> json) => CardData(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      cardNumber: json['cardNo'] as String?,
      brand: json['brand'] as String?,
      expiry: json['expiry'] as String?,
      isDefault: json['default'] as bool?,
    );

Map<String, dynamic> _$CardDataToJson(CardData instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'cardNo': instance.cardNumber,
      'brand': instance.brand,
      'expiry': instance.expiry,
      'default': instance.isDefault,
    };
