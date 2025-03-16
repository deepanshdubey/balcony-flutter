import 'package:homework/generated/assets.dart';

class AmenitiesItem {
  final String name;
  final String image;
  bool isChecked = false;

  AmenitiesItem({required this.name, required this.image});

  static List<AmenitiesItem> preset() {
    return [
      AmenitiesItem(name: "commercial", image: Assets.amenitiesCommercial),
      AmenitiesItem(name: "residential", image: Assets.amenitiesResidential),
      AmenitiesItem(name: "parking", image: Assets.amenitiesParking),
      AmenitiesItem(name: "concierge", image: Assets.amenitiesConcierge),
      AmenitiesItem(name: "valet", image: Assets.amenitiesValet),
      AmenitiesItem(
          name: "co-workspace, office", image: Assets.amenitiesCoworkingSpace),
      AmenitiesItem(name: "tables", image: Assets.amenitiesTables),
      AmenitiesItem(name: "chairs", image: Assets.amenitiesChairs),
      AmenitiesItem(name: "wi-fi", image: Assets.amenitiesWifi),
      AmenitiesItem(
          name: "conference room", image: Assets.amenitiesConferenceRoom),
      AmenitiesItem(name: "shuttle", image: Assets.amenitiesShuttle),
      AmenitiesItem(name: "common space", image: Assets.amenitiesCommonSpace),
      AmenitiesItem(name: "gym", image: Assets.amenitiesGym),
      AmenitiesItem(
          name: "tv / television, presentation", image: Assets.amenitiesTv),
      AmenitiesItem(name: "printer", image: Assets.amenitiesPrinter),
      AmenitiesItem(
          name: "desk monitor, multi-monitor",
          image: Assets.amenitiesDeskMonitor),
      AmenitiesItem(name: "rooftop", image: Assets.amenitiesRoofTop),
      AmenitiesItem(name: "terrace", image: Assets.amenitiesDeskMonitor),
      AmenitiesItem(name: "backyard", image: Assets.amenitiesBackyard),
      AmenitiesItem(name: "courtyard", image: Assets.amenitiesCourtYard),
      AmenitiesItem(name: "tennis court", image: Assets.amenitiesCourtYard),
      AmenitiesItem(
          name: "basketball court", image: Assets.amenitiesBasketballCourt),
      AmenitiesItem(name: "barbecue", image: Assets.amenitiesBarbecue),
      AmenitiesItem(name: "outlets, charging", image: Assets.amenitiesBiOutlet),
      AmenitiesItem(
          name: "wheelchair accessible", image: Assets.amenitiesAccessibility),
      AmenitiesItem(name: "game room", image: Assets.amenitiesAccessibility),
      AmenitiesItem(
          name: "break room, cafe", image: Assets.amenitiesBreakRoomCafe),
      AmenitiesItem(name: "outdoor deck", image: Assets.amenitiesOutdoorDeck),
      AmenitiesItem(name: "coffee", image: Assets.amenitiesCoffee),
      AmenitiesItem(name: "laundry", image: Assets.amenitiesLaundry),
      AmenitiesItem(name: "dry cleaning", image: Assets.amenitiesDryCleaning),
      AmenitiesItem(name: "natural light", image: Assets.amenitiesNaturalLight),
      AmenitiesItem(name: "greenspaces", image: Assets.amenitiesGreenspaces),
      AmenitiesItem(name: "kitchen", image: Assets.amenitiesKitchen),
      AmenitiesItem(
          name: "waterfront views",
          image: Assets.amenitiesTidalWaveNatureOceanWave),
      AmenitiesItem(name: "sauna", image: Assets.amenitiesSauna),
      AmenitiesItem(name: "steam room", image: Assets.amenitiesSteamRoom),
      AmenitiesItem(
          name: "landscape views", image: Assets.amenitiesLandscapeViews),
      AmenitiesItem(name: "fireplace", image: Assets.amenitiesFireplace),
      AmenitiesItem(name: "pool", image: Assets.amenitiesPool),
    ];
  }
}
