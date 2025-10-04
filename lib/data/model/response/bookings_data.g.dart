// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookings_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingsData _$BookingsDataFromJson(Map<String, dynamic> json) => BookingsData(
      id: json['_id'] as String?,
      workspace: json['workspace'] == null
          ? null
          : WorkspaceData.fromJson(json['workspace'] as Map<String, dynamic>),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      subtotal: (json['subtotal'] as num?)?.toInt(),
      discount: (json['discount'] as num?)?.toInt(),
      status: json['status'] as String?,
      acceptance: json['acceptance'] as String?,
      ratings: (json['ratings'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      user: const HostConverter().fromJson(json['user']),
    );

Map<String, dynamic> _$BookingsDataToJson(BookingsData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'workspace': instance.workspace?.toJson(),
      'user': const HostConverter().toJson(instance.user),
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'subtotal': instance.subtotal,
      'discount': instance.discount,
      'status': instance.status,
      'acceptance': instance.acceptance,
      'ratings': instance.ratings,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
