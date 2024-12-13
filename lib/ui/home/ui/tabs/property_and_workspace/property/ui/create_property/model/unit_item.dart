import 'package:flutter/cupertino.dart';

class UnitItem {
  int? unit;
  double? price;
  int? bed;
  int? bath;
  String? floorImage;

  late TextEditingController unitController;
  late TextEditingController priceController;
  late TextEditingController bedController;
  late TextEditingController bathController;

  UnitItem() {
    unitController = TextEditingController();
    priceController = TextEditingController();
    bedController = TextEditingController();
    bathController = TextEditingController();
  }
}
