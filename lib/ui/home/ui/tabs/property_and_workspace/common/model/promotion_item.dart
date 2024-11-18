import 'package:flutter/cupertino.dart';

class PromotionItem {
  String? name;
  bool isPercentage = true;
  String? value;
  late GlobalKey<FormState> key;

  late TextEditingController nameController, valueController;

  PromotionItem() {
    nameController = TextEditingController();
    valueController = TextEditingController();
    key = GlobalKey();
  }
}
