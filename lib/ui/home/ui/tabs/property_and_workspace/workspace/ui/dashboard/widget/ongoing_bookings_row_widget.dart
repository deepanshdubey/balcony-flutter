import 'package:balcony/core/alert/alert_manager.dart';
import 'package:balcony/data/model/response/bookings_data.dart';
import 'package:balcony/ui/home/ui/tabs/chat/ui/chat_page.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/store/workspace_store.dart';
import 'package:balcony/ui/home/ui/tabs/works/booking_details_page.dart';
import 'package:balcony/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';

class OnGoingBookingsRowWidget extends StatefulWidget {
  final BookingsData booking;
  final VoidCallback? onBookingUpdated;

  const OnGoingBookingsRowWidget({
    super.key,
    required this.booking,
    this.onBookingUpdated,
  });

  @override
  State<OnGoingBookingsRowWidget> createState() =>
      _OnGoingBookingsRowWidgetState();
}

class _OnGoingBookingsRowWidgetState extends State<OnGoingBookingsRowWidget> {
  bool isSelected = false;
  late String bookingStatus;
  final workspaceStore = WorkspaceStore();

  @override
  void initState() {
    bookingStatus = widget.booking.status ?? "pending";
    reaction((_) => workspaceStore.isBookingAccepted, (response) {
      if (response != null) {
        widget.onBookingUpdated ?? ();
      }
    });

    reaction((_) => workspaceStore.errorMessage, (response) {
      if (response != null) {
        alertManager.showError(context, response);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        showAppBottomSheet(
            context,
            BookingsDetailsPage(
              id: widget.booking.id.toString(),
              bookingsData: widget.booking,
            ));
      },
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Checkbox(
              value: isSelected,
              onChanged: (value) {
                setState(() {
                  isSelected = value ?? false;
                });
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              widget.booking.workspace?.info?.name ?? "no name",
              style: theme.textTheme.bodyLarge,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              bookingStatus,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 12.spMin),
            ),
          ),
          Expanded(
            flex: 3,
            child: Observer(builder: (context) {
              var isLoading = workspaceStore.isLoading;
              return Center(
                child: isLoading
                    ? SizedBox(
                        width: 24.r,
                        height: 24.r,
                        child: const CircularProgressIndicator())
                    : bookingStatus.toLowerCase() == "pending"
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    workspaceStore.handleBooking(
                                        widget.booking.id.toString(), true);
                                  },
                                  child: Icon(
                                    Icons.check_circle_rounded,
                                    color: appColor.primaryColor,
                                  )),
                              10.w.horizontalSpace,
                              GestureDetector(
                                  onTap: () {
                                    workspaceStore.handleBooking(
                                        widget.booking.id.toString(), false);
                                  },
                                  child: Transform.rotate(
                                      angle: 45 * 3.141592653589793 / 180,
                                      child: const Icon(
                                        Icons.add_circle,
                                        color: Colors.red,
                                      ))),
                            ],
                          )
                        : Text(
                            widget.booking.acceptance.toString(),
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontSize: 12.spMin,
                            ),
                          ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
