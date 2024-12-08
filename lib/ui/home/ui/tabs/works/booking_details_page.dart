import 'package:auto_route/auto_route.dart';
import 'package:balcony/core/alert/alert_manager.dart';
import 'package:balcony/core/session/app_session.dart';
import 'package:balcony/data/model/response/bookings_data.dart';
import 'package:balcony/data/model/response/workspace_data.dart';
import 'package:balcony/ui/home/ui/tabs/works/store/booking_listing_store.dart';
import 'package:balcony/values/colors.dart';
import 'package:balcony/widget/app_back_button.dart';
import 'package:balcony/widget/button_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

class BookingsDetailsPage extends StatefulWidget {
  final String id;
  final BookingsData? bookingsData;
  final VoidCallback? onOrderCancelled;

  const BookingsDetailsPage(
      {super.key, required this.id, this.bookingsData, this.onOrderCancelled});

  @override
  State<BookingsDetailsPage> createState() => _BookingsDetailsPageState();
}

class _BookingsDetailsPageState extends State<BookingsDetailsPage> {
  final TextEditingController promoController = TextEditingController();
  final store = BookingListingStore();

  @override
  void initState() {
    store.getBookingDetails(widget.id);
    reaction(
      (p0) => store.cancelBookingResponse,
      (p0) {
        widget.onOrderCancelled ?? ();
        Navigator.of(context).pop();
      },
    );
    reaction(
      (p0) => store.errorMessage,
      (p0) {
        if (p0 != null) {
          alertManager.showError(context, p0);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpace,
              AppBackButton(
                text: "back",
                onTap: () => context.router.maybePop(),
              ),
              20.verticalSpace,
              Observer(
                  builder: (context) => store.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : bookingListingStore.bookingDetails != null ||
                              widget.bookingsData != null
                          ? bookingDetailsSection(
                              bookingListingStore.bookingDetails ??
                                  widget.bookingsData!)
                          : Text(
                              "no data found",
                              style: Theme.of(context).textTheme.titleMedium,
                            )),
            ],
          ),
        ),
      ),
    );
  }

  Widget bookingDetailsSection(BookingsData bookingsData) {
    return Column(
      children: [
        _buildOrderContainer(context, bookingsData),
        20.verticalSpace,
        _buildSupportSection(context, bookingsData),
        16.verticalSpace,
        _buildContactOptions(context, bookingsData),
      ],
    );
  }

  Widget _buildOrderContainer(BuildContext context, BookingsData bookingsData) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8).r,
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(
              title: "Order ${bookingsData.id}",
              date: DateFormat("MMMM dd, yyyy")
                  .format(bookingsData.createdAt ?? DateTime.now())),
          20.verticalSpace,
          _buildOrderDetails(context, bookingsData),
          20.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20).r,
            child: const Divider(),
          ),
          20.verticalSpace,
          _buildUserInfoSection(context, bookingsData),
          if (bookingsData.status == "pending" ||
              bookingsData.status == "in progress")
            _buildCancelOrderSection(context, bookingsData),
        ],
      ),
    );
  }

  Widget _buildOrderDetails(BuildContext context, BookingsData bookingsData) {
    return SectionContainer(
      title: "Order Details",
      children: [
        KeyValueRow(
          label:
              '${bookingsData.workspace?.info?.name} x ${bookingsData.workspace?.times?.nonNullCount} days',
          value: '\$${bookingsData.subtotal}',
        ),
        20.verticalSpace,
        const Divider(),
        20.verticalSpace,
        KeyValueRow(label: 'Subtotal', value: '\$${bookingsData.subtotal}'),
        KeyValueRow(label: 'Discount', value: '\$${bookingsData.discount}'),
        KeyValueRow(
            label: 'Total',
            value:
                '\$${(bookingsData.subtotal ?? 0) - (bookingsData.discount ?? 0)}'),
      ],
    );
  }

  Widget _buildUserInfoSection(
      BuildContext context, BookingsData bookingsData) {
    var host = bookingsData.workspace?.host;
    var isHost = session.user.id ==
        ((host is String)
            ? host
            : (host is Host)
                ? host.Id
                : -1);
    var user = isHost
        ? bookingsData.user
        : host is Host
            ? bookingsData.workspace?.host
            : null;
    return SectionContainer(
      title: "${isHost ? "customer" : "host"}'s info",
      children: [
        KeyValueRow(label: 'name', value: user?.firstName),
        KeyValueRow(label: 'email', value: user?.email),
        KeyValueRow(label: 'phone', value: user?.phone),
        20.verticalSpace
      ],
    );
  }

  Widget _buildCancelOrderSection(BuildContext context, BookingsData booking) {
    return SectionContainer(
      children: [
        const Divider(),
        20.verticalSpace,
        Text(
          'Cancel order',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 13.spMin,
              ),
        ),
        6.verticalSpace,
        Text(
          'You can cancel before 24 hours of the book start date/time for a full refund. Failure to cancel before 24 hours results in a 25% late cancelation charge.',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 8.spMin,
              ),
        ),
        20.verticalSpace,
        Observer(
          builder: (context) => BorderButton(
            label: "cancel booking",
            isLoading: store.isLoading,
            onTap: () {
              var host = booking.workspace?.host;
              var isHost = session.user.id ==
                  ((host is String)
                      ? host
                      : (host is Host)
                          ? host.Id
                          : -1);

              alertManager.showSystemAlertDialog(
                context: context,
                onConfirm: () {
                  store.cancelBooking(booking.id.toString(), isHost);
                },
              );
            },
          ),
        ),
        20.verticalSpace
      ],
    );
  }

  Widget _buildSupportSection(BuildContext context, BookingsData bookingsData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Contact Host for Support",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 14.spMin,
                color: appColor.primaryColor,
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          "Chat &/or call with the workspace host before booking",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 14.spMin,
                color: appColor.primaryColor,
              ),
        ),
      ],
    );
  }

  Widget _buildContactOptions(BuildContext context, BookingsData bookingsData) {
    return Row(
      children: [
        Text(
          "chat",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 14.spMin,
                color: appColor.primaryColor,
                decoration: TextDecoration.underline,
              ),
        ),
        16.horizontalSpace,
        Container(
          color: const Color(0xff005451),
          height: 20.h,
          width: 1.w,
        ),
        16.horizontalSpace,
        Text(
          "call",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 14.spMin,
                decoration: TextDecoration.underline,
                color: appColor.primaryColor,
              ),
        ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final String date;

  const SectionTitle({
    required this.title,
    required this.date,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 98.h,
      decoration: BoxDecoration(
        color: const Color(0xffCCDDDC),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ).r,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27).r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 17.spMin,
                  ),
            ),
            8.verticalSpace,
            Text("Date: $date"),
          ],
        ),
      ),
    );
  }
}

class SectionContainer extends StatelessWidget {
  final String? title;
  final List<Widget> children;

  const SectionContainer({
    this.title,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 13.spMin,
                  ),
            ),
            12.verticalSpace,
          ],
          ...children,
        ],
      ),
    );
  }
}

class KeyValueRow extends StatelessWidget {
  final String label;
  final String? value;

  const KeyValueRow({
    required this.label,
    this.value = "",
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 13.spMin,
                  color: const Color(0xff71717A),
                ),
          ),
          Text(
            value ?? '-',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 13.spMin,
                ),
          ),
        ],
      ),
    );
  }
}
