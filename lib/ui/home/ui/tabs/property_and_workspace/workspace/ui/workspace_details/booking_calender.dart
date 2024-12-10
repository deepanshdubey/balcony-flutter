import 'package:homework/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingCalendar extends StatefulWidget {
  final Function(String formattedRange, int days, String startDate, String endDate) onDateSelected;

  BookingCalendar({required this.onDateSelected});

  @override
  _BookingCalendarState createState() => _BookingCalendarState();
}

class _BookingCalendarState extends State<BookingCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      // Updated decoration to match the original code
      decoration: BoxDecoration(
        borderRadius: BorderRadius
            .circular(12)
            .r, // Updated radius
        border: Border.all(color: appColor.primaryColor.withOpacity(0.5)),
      ),
      padding: EdgeInsets.all(8.r), // Consistent padding
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) {
          if (_startDate != null && _endDate != null) {
            return day.isAtSameMomentAs(_startDate!) ||
                day.isAtSameMomentAs(_endDate!) ||
                (day.isAfter(_startDate!) && day.isBefore(_endDate!));
          }
          return isSameDay(_startDate, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (selectedDay.isBefore(DateTime.now())) {
            return;
          }

          setState(() {
            if (_startDate == null ||
                (_startDate != null && _endDate != null)) {
              _startDate = selectedDay;
              _endDate = null;
            } else if (_startDate != null && selectedDay.isAfter(_startDate!)) {
              _endDate = selectedDay;
            } else {
              _startDate = selectedDay;
              _endDate = null;
            }
            _focusedDay = focusedDay;
          });

          widget.onDateSelected(
              _formatSelectedRange(),
              _endDate == null ? 1 : _endDate!.difference(_startDate!).inDays +
                  1,
              _startDate?.toIso8601String() ?? "",
              _endDate?.toIso8601String() ?? ""

          );
        },
        calendarStyle: CalendarStyle(
          // Updated styles to match initial design
          todayDecoration: BoxDecoration(
            color: appColor.primaryColor.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: appColor.primaryColor,
            shape: BoxShape.circle,
          ),
          rangeHighlightColor: appColor.primaryColor.withOpacity(0.2),
          weekendTextStyle: TextStyle(
            color: appColor.primaryColor,
            fontWeight: FontWeight.bold,
          ),
          defaultTextStyle: TextStyle(
            color: appColor.primaryColor,
          ),
          todayTextStyle: TextStyle(
            color: Colors.white, // Contrast for today’s date
            fontWeight: FontWeight.bold,
          ),
          selectedTextStyle: TextStyle(
            color: Colors.white, // Contrast for selected date
            fontWeight: FontWeight.bold,
          ),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(
            color: appColor.primaryColor, // Title color
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
          leftChevronIcon: Container(
            // Chevron style updates
            decoration: BoxDecoration(
              borderRadius: BorderRadius
                  .circular(8)
                  .r,
              border: Border.all(color: appColor.primaryColor),
            ),
            padding: EdgeInsets.all(6.0),
            child: Icon(
              Icons.chevron_left,
              color: appColor.primaryColor,
            ),
          ),
          rightChevronIcon: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius
                  .circular(8)
                  .r,
              border: Border.all(color: appColor.primaryColor),
            ),
            padding: const EdgeInsets.all(6.0),
            child: Icon(
              Icons.chevron_right,
              color: appColor.primaryColor,
            ),
          ),
          decoration: const BoxDecoration(
            color: Colors.white, // Background color for header
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
    );
  }

  String _formatSelectedRange() {
    if (_startDate != null && _endDate == null) {
      return "${_startDate!.monthName()} ${_startDate!.day}${_getDaySuffix(
          _startDate!.day)}";
    } else if (_startDate != null && _endDate != null) {
      return "${_startDate!.monthName()} ${_startDate!.day}${_getDaySuffix(
          _startDate!.day)} - ${_endDate!.day}${_getDaySuffix(_endDate!.day)}";
    }
    return "No date selected";
  }

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return "th";
    switch (day % 10) {
      case 1:
        return "st";
      case 2:
        return "nd";
      case 3:
        return "rd";
      default:
        return "th";
    }
  }
}

extension DateTimeExtension on DateTime {
  String monthName() {
    const monthNames = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return monthNames[this.month - 1];
  }
}
