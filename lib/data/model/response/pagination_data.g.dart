// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationData<T> _$PaginationDataFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PaginationData<T>(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : PaginationItem<T>.fromJson(json['data'] as Map<String, dynamic>,
              (value) => fromJsonT(value)),
      workspace: json['workspace'] == null
          ? null
          : WorkspaceData.fromJson(json['workspace'] as Map<String, dynamic>),
      property: json['property'] == null
          ? null
          : PropertyData.fromJson(json['property'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaginationDataToJson<T>(
  PaginationData<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.toJson(
        (value) => toJsonT(value),
      ),
      'workspace': instance.workspace,
      'property': instance.property,
    };

PaginationItem<T> _$PaginationItemFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PaginationItem<T>(
      totalDocuments: (json['totalDocuments'] as num?)?.toInt(),
      totalPages: (json['totalPages'] as num?)?.toInt(),
      currentPage: (json['currentPage'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
      skip: (json['skip'] as num?)?.toInt(),
      result: (json['items'] as List<dynamic>?)?.map(fromJsonT).toList(),
    );

Map<String, dynamic> _$PaginationItemToJson<T>(
  PaginationItem<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'totalDocuments': instance.totalDocuments,
      'totalPages': instance.totalPages,
      'currentPage': instance.currentPage,
      'limit': instance.limit,
      'skip': instance.skip,
      'items': instance.result?.map(toJsonT).toList(),
    };
