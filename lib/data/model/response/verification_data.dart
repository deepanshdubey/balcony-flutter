import 'package:json_annotation/json_annotation.dart';

part 'verification_data.g.dart';

@JsonSerializable()
class Verification {
  @JsonKey(name: 'identity')
  final Identity? identity;

  @JsonKey(name: 'bankStatement')
  final BankStatement? bankStatement;

  @JsonKey(name: 'creditReport')
  final String? creditReport;

  Verification({this.identity, this.bankStatement, this.creditReport});

  factory Verification.fromJson(Map<String, dynamic> json) =>
      _$VerificationFromJson(json);

  Map<String, dynamic> toJson() => _$VerificationToJson(this);
}

@JsonSerializable()
class Identity {
  @JsonKey(name: 'status')
  final String? status;

  Identity({this.status});

  factory Identity.fromJson(Map<String, dynamic> json) =>
      _$IdentityFromJson(json);

  Map<String, dynamic> toJson() => _$IdentityToJson(this);
}

@JsonSerializable()
class BankStatement {
  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'url')
  final String? url;

  BankStatement({this.status, this.url});

  factory BankStatement.fromJson(Map<String, dynamic> json) =>
      _$BankStatementFromJson(json);

  Map<String, dynamic> toJson() => _$BankStatementToJson(this);
}
