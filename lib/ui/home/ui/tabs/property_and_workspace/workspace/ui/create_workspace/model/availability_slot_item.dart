import 'package:flutter/cupertino.dart';

class AvailabilitySlotItem {
  final String day;
  bool isChecked = false;
  String? startTime;
  String? endTime;
  final TextEditingController startTimeController;
  final TextEditingController endTimeController;

  AvailabilitySlotItem(this.startTimeController, this.endTimeController,
      {required this.day});

  static List<String> preset() {
    return [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];
  }
}
