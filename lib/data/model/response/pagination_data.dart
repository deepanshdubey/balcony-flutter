import 'package:json_annotation/json_annotation.dart';

part 'pagination_data.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PaginationData<T> {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'totalDocuments')
  final int totalDocuments;

  @JsonKey(name: 'totalPages')
  final int totalPages;

  @JsonKey(name: 'currentPage')
  final int currentPage;

  @JsonKey(name: 'limit')
  final int limit;

  @JsonKey(name: 'skip')
  final int skip;

  @JsonKey(name: 'result')
  final List<T> result;

  PaginationData({
    required this.success,
    required this.totalDocuments,
    required this.totalPages,
    required this.currentPage,
    required this.limit,
    required this.skip,
    required this.result,
  });

  factory PaginationData.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) => _$PaginationDataFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$PaginationDataToJson(this, toJsonT);
}
