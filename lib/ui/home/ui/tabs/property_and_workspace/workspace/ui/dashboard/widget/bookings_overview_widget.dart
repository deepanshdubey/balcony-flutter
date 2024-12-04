import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/ui/dashboard/store/dashboard_store.dart';
import 'package:balcony/values/colors.dart';
import 'package:balcony/values/extensions/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingsOverviewWidget extends StatefulWidget {
  const BookingsOverviewWidget({super.key});

  @override
  State<BookingsOverviewWidget> createState() => _BookingsOverviewWidgetState();
}

class _BookingsOverviewWidgetState extends State<BookingsOverviewWidget> {
  final _bookingStore = DashboardStore();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _bookingStore.getBookingDates();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Container(
          width: context.width,
          padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 20.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            border: Border.all(color: Colors.black.withOpacity(.25)),
          ),
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
                  border:
                      Border.all(color: appColor.primaryColor.withOpacity(.5)),
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
                    // Highlight booked dates
                    holidayDecoration: BoxDecoration(
                      color: appColor.primaryColor, // Highlight color
                      shape: BoxShape.circle,
                    ),
                    defaultDecoration: const BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    weekendDecoration: const BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  holidayPredicate: (day) {
                    // Highlight days listed in bookingDates
                    final formatter = DateFormat('yyyy-MM-dd');
                    final dayString = formatter.format(day);
                    return _bookingStore.bookingDates.contains(dayString);
                  },
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                      color: appColor.primaryColor, // Title text color
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
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
      },
    );
  }
}
