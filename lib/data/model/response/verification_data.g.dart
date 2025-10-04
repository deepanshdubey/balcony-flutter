// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Verification _$VerificationFromJson(Map<String, dynamic> json) => Verification(
      identity: json['identity'] == null
          ? null
          : Identity.fromJson(json['identity'] as Map<String, dynamic>),
      bankStatement: json['bankStatement'] == null
          ? null
          : BankStatement.fromJson(
              json['bankStatement'] as Map<String, dynamic>),
      creditReport: json['creditReport'] as String?,
    );

Map<String, dynamic> _$VerificationToJson(Verification instance) =>
    <String, dynamic>{
      'identity': instance.identity,
      'bankStatement': instance.bankStatement,
      'creditReport': instance.creditReport,
    };

Identity _$IdentityFromJson(Map<String, dynamic> json) => Identity(
      status: json['status'] as String?,
    );

Map<String, dynamic> _$IdentityToJson(Identity instance) => <String, dynamic>{
      'status': instance.status,
    };

BankStatement _$BankStatementFromJson(Map<String, dynamic> json) =>
    BankStatement(
      status: json['status'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$BankStatementToJson(BankStatement instance) =>
    <String, dynamic>{
      'status': instance.status,
      'url': instance.url,
    };
