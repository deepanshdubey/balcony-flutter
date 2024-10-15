import 'package:balcony/core/locator/locator.dart';
import 'package:flutter/material.dart';

class AppColor {
  Color get greenColor => const Color(0xff0FDA48);

  Color get primaryColor => const Color(0xff0D5EF9);

  Color get borderColor => const Color(0xffBEE1F4);

  Color get grayBorder => Colors.grey;

  Color get iconColor => Colors.grey;

  Color get backgroundColor => Colors.white;

  Color get textColor => Colors.black;

  Color get fillColor => const Color(0xffF9F9F9);

  Color get strokeColor => const Color(0x1a181e22);

  Color get subtitleColor => const Color(0xff181E22);

  Color get dividerColor => const Color(0xffEDEEEE);

  Color get containerColor => Colors.white;
}

AppColor appColors = locator<AppColor>();
