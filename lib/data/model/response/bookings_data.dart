import 'package:balcony/data/model/response/workspace_data.dart';
import 'package:json_annotation/json_annotation.dart';


part 'bookings_data.g.dart';

@JsonSerializable(explicitToJson: true)
class BookingsData {
  @JsonKey(name: '_id')
  final String? id;

  final WorkspaceData? workspace;

  @JsonKey(name: 'startDate')
  final DateTime? startDate;

  @JsonKey(name: 'endDate')
  final DateTime? endDate;

  final int? subtotal;
  final int? discount;

  final String? status;
  final String? acceptance;

  final int? ratings;

  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;

  BookingsData({
    this.id,
    this.workspace,
    this.startDate,
    this.endDate,
    this.subtotal,
    this.discount,
    this.status,
    this.acceptance,
    this.ratings,
    this.createdAt,
    this.updatedAt,
  });

  /// Creates an instance of `BookingsData` from JSON.
  factory BookingsData.fromJson(Map<String, dynamic> json) =>
      _$BookingsDataFromJson(json);

  /// Converts an instance of `BookingsData` to JSON.
  Map<String, dynamic> toJson() => _$BookingsDataToJson(this);
}