import 'package:balcony/generated/assets.dart';

class AmenitiesItem {
  final String name;
  final String image;
  bool isChecked = false;

  AmenitiesItem({required this.name, required this.image});

  static List<AmenitiesItem> preset() {
    return [
      AmenitiesItem(name: "commercial", image: Assets.imagesCommercial),
      AmenitiesItem(name: "residential", image: Assets.imagesResidential),
      AmenitiesItem(name: "parking", image: Assets.imagesParking),
    ];
  }
}
