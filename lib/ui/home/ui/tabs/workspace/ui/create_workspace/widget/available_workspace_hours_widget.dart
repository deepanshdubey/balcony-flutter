import 'package:balcony/ui/home/ui/tabs/workspace/ui/create_workspace/model/availability_slot_item.dart';
import 'package:balcony/values/colors.dart';
import 'package:balcony/values/extensions/context_ext.dart';
import 'package:balcony/widget/app_dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvailableWorkspaceHoursWidget extends StatefulWidget {
  const AvailableWorkspaceHoursWidget({super.key});

  @override
  State<AvailableWorkspaceHoursWidget> createState() =>
      _AvailableWorkspaceHoursWidgetState();
}

class _AvailableWorkspaceHoursWidgetState
    extends State<AvailableWorkspaceHoursWidget> {
  late List<AvailabilitySlotItem> slots;
  late List<String> allSlots;

  @override
  void initState() {
    slots = AvailabilitySlotItem.preset()
        .map(
          (day) => AvailabilitySlotItem(
              TextEditingController(), TextEditingController(),
              day: day),
        )
        .toList();
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
          flex: 4,
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
        8.w.horizontalSpace,
        Expanded(
            flex: 5,
            child: AppDropdownField(
              controller: item.startTimeController,
              label: "am / pm",
              hintText: "1..",
              items: allSlots,
              itemLabel: (p0) => p0,
              onItemSelected: (p0) {
                item.startTime = allSlots.indexOf(p0).toString();
              },
            )),
        Container(
          height: 1,
          color: appColor.primaryColor,
          width: 12.w,
          margin: EdgeInsets.only(left: 6.w, right: 6.w, top: 10.h),
        ),
        Expanded(
            flex: 5,
            child: AppDropdownField(
              controller: item.startTimeController,
              label: "am / pm",
              hintText: "1..",
              items: allSlots,
              itemLabel: (p0) => p0,
              onItemSelected: (p0) {
                item.startTime = allSlots.indexOf(p0).toString();
              },
            )),
      ],
    );
  }
}
