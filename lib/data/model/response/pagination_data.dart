import 'package:json_annotation/json_annotation.dart';

part 'pagination_data.g.dart';

@JsonSerializable(genericArgumentFactories: true,explicitToJson: true)
class PaginationData<T> {
  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'data')
  final PaginationItem<T>? data;

  PaginationData({
    this.success,
    this.data,
  });

  factory PaginationData.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) => _$PaginationDataFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$PaginationDataToJson(this, toJsonT);
}

@JsonSerializable(genericArgumentFactories: true)
class PaginationDataDetails<T> {
  @JsonKey(name: 'count')
  final int? count;

  @JsonKey(name: 'data')
  final List<PaginationItem<T>>? items;

  PaginationDataDetails({
    this.count,
    this.items,
  });

  factory PaginationDataDetails.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) => _$PaginationDataDetailsFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$PaginationDataDetailsToJson(this, toJsonT);
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
      ) => _$PaginationItemFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$PaginationItemToJson(this, toJsonT);
}
