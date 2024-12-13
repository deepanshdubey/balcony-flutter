import 'package:homework/data/model/response/property_data.dart';
import 'package:json_annotation/json_annotation.dart';

import 'workspace_data.dart'; // Import the WorkspaceData model.

part 'pagination_data.g.dart';

@JsonSerializable(genericArgumentFactories: true, explicitToJson: true)
class PaginationData<T> {
  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'data')
  final PaginationItem<T>? data;

  @JsonKey(name: 'workspace')
  final WorkspaceData? workspace;

  @JsonKey(name: 'property')
  final PropertyData? property;

  PaginationData({
    required this.success,
    this.data,
    this.workspace,
    this.property,
  });

  factory PaginationData.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PaginationDataFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$PaginationDataToJson(this, toJsonT);
}

@JsonSerializable(genericArgumentFactories: true)
class PaginationItem<T> {
  @JsonKey(name: 'totalDocuments')
  final int? totalDocuments;

  @JsonKey(name: 'totalPages')
  final int? totalPages;

  @JsonKey(name: 'currentPage')
  final int? currentPage;

  @JsonKey(name: 'limit')
  final int? limit;

  @JsonKey(name: 'skip')
  final int? skip;

  @JsonKey(name: 'items')
  final List<T>? result;

  PaginationItem({
    this.totalDocuments,
    this.totalPages,
    this.currentPage,
    this.limit,
    this.skip,
    this.result,
  });

  factory PaginationItem.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PaginationItemFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$PaginationItemToJson(this, toJsonT);
}
