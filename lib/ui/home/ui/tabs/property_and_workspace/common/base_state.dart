import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  /// Abstract method for form validation
  bool validate();

  ThemeData get theme => Theme.of(context);

  /// Abstract method to show error messages
  String? getError();

  dynamic getApiData();

  int additionalGuests() {
    return 0;
  }

  bool isIndoor() {
    return false;
  }

  bool isOutdoor() {
    return false;
  }

  bool isWorkspaceStyle() {
    return false;
  }
}
