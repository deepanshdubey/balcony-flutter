import 'package:balcony/values/colors.dart';
import 'package:balcony/values/extensions/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingsOverviewWidget extends StatefulWidget {
  const BookingsOverviewWidget({super.key});

  @override
  State<BookingsOverviewWidget> createState() => _BookingsOverviewWidgetState();
}

class _BookingsOverviewWidgetState extends State<BookingsOverviewWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 20.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          border: Border.all(color: Colors.black.withOpacity(.25))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'bookings overview',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 24.spMin,
                ),
          ),
          16.h.verticalSpace,
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12).r,
              border: Border.all(color: appColor.primaryColor.withOpacity(.5)),
            ),
            padding: EdgeInsets.all(8.r),
            child: TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: CalendarStyle(
                // Decoration for today's date
                todayDecoration: BoxDecoration(
                  color: appColor.primaryColor
                      .withOpacity(0.3), // Light primary color
                  shape: BoxShape.circle,
                ),
                // Decoration for the selected day
                selectedDecoration: BoxDecoration(
                  color: appColor.primaryColor,
                  shape: BoxShape.circle,
                ),
                // Text style for weekend days (e.g., Fridays)
                weekendTextStyle: TextStyle(
                  color: appColor.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                // Text style for default days
                defaultTextStyle: TextStyle(
                  color: appColor.primaryColor,
                ),
                // Today’s text style
                todayTextStyle: TextStyle(
                  color: Colors.white, // Contrast with todayDecoration
                  fontWeight: FontWeight.bold,
                ),
                // Selected day's text style
                selectedTextStyle: TextStyle(
                  color: Colors.white, // Contrast with selectedDecoration
                  fontWeight: FontWeight.bold,
                ),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  color: appColor.primaryColor, // Title text color
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
                leftChevronIcon: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8).r,
                    border: Border.all(color: appColor.primaryColor),
                  ),
                  padding: EdgeInsets.all(6.0),
                  child: Icon(
                    Icons.chevron_left,
                    color: appColor.primaryColor, // Chevron icon color
                  ),
                ),
                rightChevronIcon: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8).r,
                    border: Border.all(color: appColor.primaryColor),
                  ),
                  padding: EdgeInsets.all(6.0),
                  child: Icon(
                    Icons.chevron_right,
                    color: appColor.primaryColor, // Chevron icon color
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white, // Background color for the header
                ),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekendStyle: TextStyle(
                  color: appColor.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                weekdayStyle: TextStyle(
                  color: appColor.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
