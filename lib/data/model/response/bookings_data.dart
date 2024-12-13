import 'package:homework/data/model/response/user_data.dart';
import 'package:homework/data/model/response/workspace_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bookings_data.g.dart';

@JsonSerializable(explicitToJson: true)
class BookingsData {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'workspace')
  final WorkspaceData? workspace;

  @JsonKey(name: 'user')
  @HostConverter()
  final dynamic? user;

  @JsonKey(name: 'startDate')
  final DateTime? startDate;

  @JsonKey(name: 'endDate')
  final DateTime? endDate;

  @JsonKey(name: 'subtotal')
  final int? subtotal;

  @JsonKey(name: 'discount')
  final int? discount;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'acceptance')
  final String? acceptance;

  @JsonKey(name: 'ratings')
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
    this.user,
  });

  /// Creates an instance of `BookingsData` from JSON.
  factory BookingsData.fromJson(Map<String, dynamic> json) =>
      _$BookingsDataFromJson(json);

  /// Converts an instance of `BookingsData` to JSON.
  Map<String, dynamic> toJson() => _$BookingsDataToJson(this);
}
