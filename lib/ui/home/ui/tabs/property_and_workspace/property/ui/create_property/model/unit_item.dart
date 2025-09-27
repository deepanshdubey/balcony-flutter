import 'package:flutter/material.dart';

class UnitItem {
  String? id;
  int? unit;
  double? price;
  int? bed;
  int? bath;
  String? floorImage;

  late TextEditingController unitController;
  late TextEditingController priceController;
  late TextEditingController bedController;
  late TextEditingController bathController;

  UnitItem({
    this.id,
    this.unit,
    this.price,
    this.bed,
    this.bath,
    this.floorImage,
  }) {
    unitController = TextEditingController(text: unit?.toString());
    priceController = TextEditingController(text: price?.toString());
    bedController = TextEditingController(text: bed?.toString());
    bathController = TextEditingController(text: bath?.toString());
  }
}
