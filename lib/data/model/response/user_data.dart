import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class UserData {
  @HiveField(0)
  @JsonKey(name: '_id')
  String? id;

  @HiveField(1)
  @JsonKey(name: 'firstName')
  String? firstName;

  @HiveField(2)
  @JsonKey(name: 'lastName')
  String? lastName;

  @HiveField(3)
  @JsonKey(name: 'email')
  String? email;

  @HiveField(4)
  @JsonKey(name: 'phone')
  String? phone;

  @HiveField(5)
  @JsonKey(name: 'role')
  String? role;

  @HiveField(6)
  @JsonKey(name: 'status')
  String? status;

  @HiveField(7)
  @JsonKey(name: 'isWorkspaceAccountConnected')
  bool? isWorkspaceAccountConnected;

  @HiveField(8)
  @JsonKey(name: 'isPropertyAccountConnected')
  bool? isPropertyAccountConnected;

  UserData({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.role,
    this.status,
    this.isWorkspaceAccountConnected,
    this.isPropertyAccountConnected,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
