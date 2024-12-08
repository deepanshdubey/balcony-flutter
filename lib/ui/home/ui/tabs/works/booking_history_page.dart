import 'package:auto_route/auto_route.dart';
import 'package:balcony/data/model/response/bookings_data.dart';
import 'package:balcony/generated/assets.dart';
import 'package:balcony/ui/home/ui/tabs/works/booking_details_page.dart';
import 'package:balcony/ui/home/ui/tabs/works/store/booking_listing_store.dart';
import 'package:balcony/values/colors.dart';
import 'package:balcony/values/extensions/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingHistoryPage extends StatefulWidget {
  @override
  _BookingHistoryPageState createState() => _BookingHistoryPageState();
}

class _BookingHistoryPageState extends State<BookingHistoryPage> {
  final store = BookingListingStore();

  @override
  void initState() {
    store.getOngoingBookings();
    store.getPastBookings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                  title: "booking in progress ", subtitle: "(active)"),
              20.verticalSpace,
              Observer(builder: (context) {
                var bookings = store.bookingsInProgress;
                var isLoading = store.isLoading;
                return isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : bookings?.isNotEmpty == true
                        ? BookingTable(
                            isActive: true,
                            bookings: bookings ?? [],
                            onBookingCancelled: () {
                              store.getOngoingBookings();
                              store.getPastBookings();
                            },
                          )
                        : Center(
                            child: Text(
                              "no bookings available",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          );
              }),
              40.verticalSpace,
              const SectionTitle(
                  title: "booking history", subtitle: "(inactive)"),
              20.verticalSpace,
              Observer(builder: (context) {
                var bookings = store.pastBookings;
                var isLoading = store.isLoading;
                return isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : bookings?.isNotEmpty == true
                        ? BookingTable(
                            isActive: true,
                            bookings: bookings ?? [],
                            onBookingCancelled: () {
                              store.getOngoingBookings();
                              store.getPastBookings();
                            },
                          )
                        : Center(
                            child: Text(
                              "no bookings available",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          );
              }),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
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
  final List<BookingsData> bookings;
  final VoidCallback? onBookingCancelled;

  const BookingTable(
      {required this.isActive,
      required this.bookings,
      this.onBookingCancelled});

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
          ...bookings.map((booking) => TableRowWidget(
                booking: booking,
                isActive: isActive,
                onBookingCancelled: onBookingCancelled,
              )),
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
          const SizedBox(width: 24),
          Expanded(
            child: Text(
              "Workspace",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 13.spMin,
                    color: appColor.primaryColor,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              isActive ? "Status / Date of Booking" : "More Info",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 13.spMin,
                    color: appColor.primaryColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class TableRowWidget extends StatelessWidget {
  final BookingsData booking;
  final bool isActive;
  final VoidCallback? onBookingCancelled;

  const TableRowWidget(
      {required this.booking, required this.isActive, this.onBookingCancelled});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.maybePop();
        showAppBottomSheet(
            context,
            BookingsDetailsPage(
              id: booking.id.toString(),
              bookingsData: booking,
              onOrderCancelled: onBookingCancelled,
            ));
      },
      child: Column(
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
                    booking.workspace?.info?.name ?? 'no name',
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
                          booking.status ?? booking.acceptance ?? '-',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
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
      ),
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
