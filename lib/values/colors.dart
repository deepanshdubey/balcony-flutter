import 'package:homework/core/locator/locator.dart';
import 'package:flutter/material.dart';

class AppColor {
  Color get disabledColor => const Color(0xff28AE7B);

  Color get greenColor => const Color(0xff0FDA48);

  Color get primaryColor => const Color(0xff005451);

  Color get borderColor => const Color(0xffBEE1F4);

  Color get grayBorder => Colors.grey;

  Color get iconColor => Colors.grey;

  Color get backgroundColor => Colors.white;

  Color get textColor => const Color(0xff005451);

  Color get fillColor => const Color(0xffF9F9F9);

  Color get strokeColor => const Color(0xffCBD5E1);

  Color get subtitleColor => const Color(0xff64748B);

  Color get dividerColor => const Color(0xff005451);

  Color get containerColor => Colors.white;
}

AppColor appColor = locator<AppColor>();
