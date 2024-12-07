import 'package:auto_route/auto_route.dart';
import 'package:balcony/generated/assets.dart';
import 'package:balcony/ui/home/ui/tabs/stay/rant_payment_details_page.dart';
import 'package:balcony/ui/home/ui/tabs/works/booking_details_page.dart';
import 'package:balcony/values/colors.dart';
import 'package:balcony/values/extensions/context_ext.dart';
import 'package:balcony/widget/app_text_field.dart';
import 'package:balcony/widget/button_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RantedHistoryPage extends StatefulWidget {
  @override
  _RantedHistoryPageState createState() => _RantedHistoryPageState();
}

class _RantedHistoryPageState extends State<RantedHistoryPage> {
  final ValueNotifier<int> rowsPerPageNotifier = ValueNotifier<int>(3);
  final List<int> rowOptions = [3, 5, 10];
  int currentPage = 1;
  final TextEditingController _filterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex:5 , child: AppTextField(controller:_filterController , hintText: "Filter search...")),
                  20.horizontalSpace,
                  Expanded(flex:2 ,child: BorderButton(label: 'filter',onTap: (){},))
                ],
              ),
              20.verticalSpace,
              const SectionTitle(title: "awaiting review ", subtitle: "(active)"),
              20.verticalSpace,
              BookingTable(
                isActive: true,
                bookings: _getBookings(isActive: true),
              ),
              40.verticalSpace,
              const SectionTitle(title: "renting", subtitle: "(inactive)"),
              20.verticalSpace,
              RantedTable(
                isActive: false,
                bookings: _getBookings(isActive: false),
              ),
              40.verticalSpace,const SectionTitle(title: "rented history", subtitle: "(inactive)"),
              20.verticalSpace,
              BookingTable(
                isActive: false,
                bookings: _getBookings(isActive: false),
              ),
              20.verticalSpace,
              const Text("0 of 100 row(s) selected."),
              20.verticalSpace,
              PaginationControls(
                rowsPerPageNotifier: rowsPerPageNotifier,
                rowOptions: rowOptions,
                currentPage: currentPage,
              ),
              20.verticalSpace,
              NavigationControls(),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getBookings({required bool isActive}) {
    return [
      {
        "workspace": "9 Homestead",
        "status": isActive ? "awaiting host to respond" : null,
        "date": isActive ? null : "01/24/2024",
      },
      {
        "workspace": "15 Garland",
        "status": isActive ? "accepted - 01/24/2024" : null,
        "date": isActive ? null : "01/20/2024",
      },
      {
        "workspace": "3432 Beachside",
        "status": isActive ? "accepted - 01/02/2024" : null,
        "date": isActive ? null : "01/18/2024",
      },
    ];
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionTitle({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 28.spMin,
            fontWeight: FontWeight.w800,
            color: appColor.primaryColor,
          ),
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 12.spMin,
            fontWeight: FontWeight.w400,
            color: appColor.primaryColor,
          ),
        ),
      ],
    );
  }
}

class BookingTable extends StatelessWidget {
  final bool isActive;
  final List<Map<String, dynamic>> bookings;


  const BookingTable({required this.isActive, required this.bookings});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8).r,
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        children: [
          TableHeader(isActive: isActive),
          const Divider(height: 1, color: Colors.grey),
          ...bookings.map((booking) => TableRowWidget(booking: booking, isActive: isActive)),
        ],
      ),
    );
  }
}

class RantedTable extends StatelessWidget {
  final bool isActive;
  final List<Map<String, dynamic>> bookings;


  const RantedTable({required this.isActive, required this.bookings});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8).r,
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        children: [
          TableHeader(isActive: isActive),
          const Divider(height: 1, color: Colors.grey),
          ...bookings.map((booking) => TableRantingRow(booking: booking, isActive: isActive)),
        ],
      ),
    );
  }
}

class TableHeader extends StatelessWidget {
  final bool isActive;

  const TableHeader({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8).r,
      child: Row(
        children: [
          30.horizontalSpace,
          Expanded(
            child: Text(
              "building",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 13.spMin,
                color: appColor.primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
               "more info",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 13.spMin,
                  color: appColor.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TableRowWidget extends StatelessWidget {
  final Map<String, dynamic> booking;
  final bool isActive;

  const TableRowWidget({required this.booking, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6).r,
          child: Row(
            children: [
              const Checkbox(
                value: false,
                onChanged: null,
              ),
              Expanded(
                flex: 3,
                child: Text(
                  booking["workspace"],
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 13.spMin,
                    color: appColor.primaryColor,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: isActive
                    ? Text(
                  booking["status"] ?? "",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 13.spMin,
                    color: appColor.primaryColor,
                  ),
                )
                    : const Icon(Icons.more_horiz, color: Colors.grey),
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: Colors.grey),
      ],
    );
  }
}

class TableRantingRow extends StatelessWidget {
  final Map<String, dynamic> booking;
  final bool isActive;

  const TableRantingRow({required this.booking, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6).r,
          child: Row(
            children: [
              const Checkbox(
                value: false,
                onChanged: null,
              ),
              Expanded(
                flex: 4,
                child: Text(
                  booking["workspace"],
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 13.spMin,
                    color: appColor.primaryColor,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: BorderButton(label: "Pay rent", onTap: (){
                  context.router.maybePop();
                  showAppBottomSheet(context,  RentPaymentDetailsPage());
                } , height: 20.h,padding: EdgeInsets.zero,)
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: Colors.grey),
      ],
    );
  }
}

class PaginationControls extends StatelessWidget {
  final ValueNotifier<int> rowsPerPageNotifier;
  final List<int> rowOptions;
  final int currentPage;

  const PaginationControls({
    required this.rowsPerPageNotifier,
    required this.rowOptions,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Rows per page",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 12.spMin,
            fontWeight: FontWeight.w500,
            color: appColor.primaryColor,
          ),
        ),
        36.horizontalSpace,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12).r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8).r,
            border: Border.all(color: Colors.grey),
          ),
          child: ValueListenableBuilder<int>(
            valueListenable: rowsPerPageNotifier,
            builder: (context, rowsPerPage, child) {
              return DropdownButton<int>(
                icon: Image.asset(
                  Assets.imagesChevronsUpDown,
                  height: 14.r,
                  width: 14.r,
                ),
                value: rowsPerPage,
                underline: const SizedBox(),
                items: rowOptions.map((row) {
                  return DropdownMenuItem<int>(
                    value: row,
                    child: Text("$row"),
                  );
                }).toList(),
                onChanged: (newValue) {
                  rowsPerPageNotifier.value = newValue!;
                },
              );
            },
          ),
        ),
        24.horizontalSpace,
        Text(
          "Page $currentPage of 10",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 12.spMin,
            fontWeight: FontWeight.w500,
            color: appColor.primaryColor,
          ),
        ),
      ],
    );
  }
}

class NavigationControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _navButton(Icons.arrow_back_ios),
        8.horizontalSpace,
        _navButton(Icons.arrow_back_ios),
        8.horizontalSpace,
        _navButton(Icons.arrow_forward_ios_sharp),
        8.horizontalSpace,
        _navButton(Icons.arrow_forward_ios_sharp),
      ],
    );
  }

  Widget _navButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8).r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8).r,
        border: Border.all(color: Colors.grey),
      ),
      child: Icon(icon, size: 16.r),
    );
  }
}
