import 'package:homework/core/locator/locator.dart';
import 'package:homework/data/model/response/workspace_data.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/base_state.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/ui/create_workspace/model/availability_slot_item.dart';
import 'package:homework/values/colors.dart';
import 'package:homework/values/extensions/context_ext.dart';
import 'package:homework/widget/app_dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvailableWorkspaceHoursWidget extends StatefulWidget {
  final Times? existingTimes;

  const AvailableWorkspaceHoursWidget({super.key, this.existingTimes});

  @override
  State<AvailableWorkspaceHoursWidget> createState() =>
      _AvailableWorkspaceHoursWidgetState();
}

class _AvailableWorkspaceHoursWidgetState
    extends BaseState<AvailableWorkspaceHoursWidget> {
  late List<AvailabilitySlotItem> slots;
  late List<String> allSlots;

  @override
  void initState() {
    // Map existing times to a day-to-DayTime dictionary
    final timesMap = {
      'sunday': widget.existingTimes?.sunday,
      'monday': widget.existingTimes?.monday,
      'tuesday': widget.existingTimes?.tuesday,
      'wednesday': widget.existingTimes?.wednesday,
      'thursday': widget.existingTimes?.thursday,
      'friday': widget.existingTimes?.friday,
      'saturday': widget.existingTimes?.saturday,
    };

    // Create slots and set the controllers during the initialization
    slots = AvailabilitySlotItem.preset()
        .map(
          (day) {
        final dayTime = timesMap[day.toLowerCase()];
        return AvailabilitySlotItem(
          TextEditingController(text: dayTime?.startTime ?? ''),
          TextEditingController(text: dayTime?.endTime ?? ''),
          day: day,
        )..isChecked = dayTime != null; // Mark as checked if times exist
      },
    )
        .toList();

    // Generate all time slots
    allSlots = generateTimeSlots();

    super.initState();
  }


  List<String> generateTimeSlots() {
    List<String> timeSlots = [];
    for (int hour = 0; hour < 24; hour++) {
      String period = hour < 12 ? 'AM' : 'PM';
      int displayHour =
          hour % 12 == 0 ? 12 : hour % 12; // Handle 12 AM and 12 PM correctly
      timeSlots.add('$displayHour $period');
    }
    return timeSlots;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          border: Border.all(
              color: Theme.of(context).primaryColor.withOpacity(.25))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.h.verticalSpace,
          Text(
            "available workspace hours*",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 24.spMin,
                ),
          ),
          16.h.verticalSpace,
          Column(
            children: slots
                .map(
                  (e) => slotWidget(e),
                )
                .toList(),
          ),
          16.h.verticalSpace,
        ],
      ),
    );
  }

  Widget slotWidget(AvailabilitySlotItem item) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12.h),
          child: Checkbox(
            value: item.isChecked,
            onChanged: (value) {
              setState(() {
                item.isChecked = value ?? item.isChecked;
              });
            },
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: Text(
              item.day.toLowerCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(),
            ),
          ),
        ),
        4.w.horizontalSpace,
        Expanded(
            flex: 5,
            child: AppDropdownField(
              controller: item.startTimeController,
              label: "am / pm",
              hintText: "0 AM",
              items: allSlots,
              itemLabel: (p0) => p0,
              onItemSelected: (p0) {
                item.startTime = allSlots.indexOf(p0).toString();
              },
            )),
        Container(
          height: 1,
          color: appColor.primaryColor,
          width: 5.w,
          margin: EdgeInsets.only(left: 6.w, right: 6.w, top: 10.h),
        ),
        Expanded(
            flex: 5,
            child: AppDropdownField(
              controller: item.endTimeController,
              label: "am / pm",
              hintText: "0 AM",
              items: allSlots,
              itemLabel: (p0) => p0,
              onItemSelected: (p0) {
                item.endTime = allSlots.indexOf(p0).toString();
              },
            )),
      ],
    );
  }

  @override
  Times getApiData() {
    return Times(
      sunday: getDayTimeForIndex(0),
      monday: getDayTimeForIndex(1),
      tuesday: getDayTimeForIndex(2),
      wednesday: getDayTimeForIndex(3),
      thursday: getDayTimeForIndex(4),
      friday: getDayTimeForIndex(5),
      saturday: getDayTimeForIndex(6),
    );
  }

  DayTime getDayTimeForIndex(int index) {
    return DayTime(
      startTime: slots[index].startTimeController.text.trim(),
      endTime: slots[index].endTimeController.text.trim(),
    );
  }

  @override
  String? getError() {
    bool isAtLeastOneFilled = slots.any(
      (element) => element.isChecked == true,
    );
    List<AvailabilitySlotItem> checked = slots
        .where(
          (element) => element.isChecked,
        )
        .toList();
    for (var element in checked) {
      if (element.startTimeController.text.isEmpty) {
        return 'please select start time for ${element.day}';
      }
      if (element.endTimeController.text.isEmpty) {
        return 'please select end time for ${element.day}';
      }
      if (int.parse(element.startTime ?? "0") >
          int.parse(element.endTime ?? "0")) {
        return '${element.day} : start cannot be greater than end time';
      }
    }

    return !isAtLeastOneFilled
        ? "please select at least one available workspace hours"
        : null;
  }

  @override
  bool validate() {
    return getError() == null;
  }
}
