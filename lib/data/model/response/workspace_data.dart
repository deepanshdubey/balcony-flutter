import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'workspace_data.g.dart';

@JsonSerializable()
class WorkspaceData {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'ratings')
  final int? ratings;

  @JsonKey(name: 'info')
  final Info? info;

  @JsonKey(name: 'images')
  final List<String>? images;

  @JsonKey(name: 'geocode')
  final Geocode? geocode;

  @JsonKey(name: 'pricing')
  final Pricing? pricing;

  @JsonKey(name: 'times')
  final Times? times;

  @JsonKey(name: 'other')
  final Other? other;

  @JsonKey(name: 'amenities')
  final List<String>? amenities;

  WorkspaceData({
    this.id,
    this.status,
    this.ratings,
    this.info,
    this.images,
    this.geocode,
    this.pricing,
    this.times,
    this.other,
    this.amenities,
  });

  factory WorkspaceData.fromJson(Map<String, dynamic> json) =>
      _$WorkspaceDataFromJson(json);

  Map<String, dynamic> toJson() => _$WorkspaceDataToJson(this);
}

@JsonSerializable()
class Host {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'firstName')
  final String? firstName;

  @JsonKey(name: 'lastName')
  final String? lastName;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'phone')
  final String? phone;

  @JsonKey(name: 'image')
  final String? image;

  @JsonKey(name: 'role')
  final String? role;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'isWorkspaceAccountConnected')
  final bool? isWorkspaceAccountConnected;

  @JsonKey(name: 'isPropertyAccountConnected')
  final bool? isPropertyAccountConnected;

  Host({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.image,
    this.role,
    this.status,
    this.isWorkspaceAccountConnected,
    this.isPropertyAccountConnected,
  });

  factory Host.fromJson(Map<String, dynamic> json) => _$HostFromJson(json);

  Map<String, dynamic> toJson() => _$HostToJson(this);
}

@JsonSerializable()
class Info {
  final String? name;
  final String? address;
  final String? floor;
  final String? city;
  final String? state;
  final String? country;
  final String? summary;

  Info({
    this.name,
    this.address,
    this.floor,
    this.city,
    this.state,
    this.country,
    this.summary,
  });

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);

  Map<String, dynamic> toJson() => _$InfoToJson(this);
}

@JsonSerializable()
class Geocode {
  final double? lat;
  final double? lon;

  Geocode({
    this.lat,
    this.lon,
  });

  factory Geocode.fromJson(Map<String, dynamic> json) =>
      _$GeocodeFromJson(json);

  Map<String, dynamic> toJson() => _$GeocodeToJson(this);
}

@JsonSerializable()
class Pricing {
  final String? currency;
  final int? totalPerDay;
  final Fee? cleaning;
  final Fee? maintenance;
  final Fee? additional;

  Pricing({
    this.currency,
    this.totalPerDay,
    this.cleaning,
    this.maintenance,
    this.additional,
  });

  String get formattedTotalPerDay {

    String symbol = NumberFormat.simpleCurrency(name: currency).currencySymbol;
    NumberFormat format = NumberFormat("$symbol ###,###,###.00");
    return format.format(totalPerDay ?? 0);
  }

  factory Pricing.fromJson(Map<String, dynamic> json) =>
      _$PricingFromJson(json);

  Map<String, dynamic> toJson() => _$PricingToJson(this);
}

@JsonSerializable()
class Fee {
  final int? fee;
  final String? type;

  Fee({
    this.fee,
    this.type,
  });

  factory Fee.fromJson(Map<String, dynamic> json) => _$FeeFromJson(json);

  Map<String, dynamic> toJson() => _$FeeToJson(this);
}

@JsonSerializable()
class Times {
  final DayTime? sunday;
  final DayTime? monday;
  final DayTime? tuesday;
  final DayTime? wednesday;
  final DayTime? thursday;
  final DayTime? friday;
  final DayTime? saturday;

  Times({
    this.sunday,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
  });

  factory Times.fromJson(Map<String, dynamic> json) => _$TimesFromJson(json);

  Map<String, dynamic> toJson() => _$TimesToJson(this);
}

@JsonSerializable()
class DayTime {
  final String? startTime;
  final String? endTime;

  DayTime({
    this.startTime,
    this.endTime,
  });

  factory DayTime.fromJson(Map<String, dynamic> json) =>
      _$DayTimeFromJson(json);

  Map<String, dynamic> toJson() => _$DayTimeToJson(this);
}

@JsonSerializable()
class Other {
  final bool? isIndoorSpace;
  final bool? isOutdoorSpace;
  final bool? isCoWorkingWorkspace;
  final int? additionalGuests;

  Other({
    this.isIndoorSpace,
    this.isOutdoorSpace,
    this.isCoWorkingWorkspace,
    this.additionalGuests,
  });

  factory Other.fromJson(Map<String, dynamic> json) => _$OtherFromJson(json);

  Map<String, dynamic> toJson() => _$OtherToJson(this);
}
