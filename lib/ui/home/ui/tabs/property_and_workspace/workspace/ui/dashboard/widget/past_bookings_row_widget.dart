import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/data/model/response/bookings_data.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/store/workspace_store.dart';
import 'package:homework/ui/home/ui/tabs/works/booking_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../../../../values/extensions/context_ext.dart';

class PastBookingsRowWidget extends StatefulWidget {
  final BookingsData booking;

  const PastBookingsRowWidget({
    super.key,
    required this.booking,
  });

  @override
  State<PastBookingsRowWidget> createState() => _PastBookingsRowWidgetState();
}

class _PastBookingsRowWidgetState extends State<PastBookingsRowWidget> {
  bool isSelected = false;
  late String bookingStatus;
  final workspaceStore = WorkspaceStore();

  @override
  void initState() {
    bookingStatus = widget.booking.status ?? "pending";
    reaction((_) => workspaceStore.workspaceStatusResponse, (response) {
      if (response != null) {}
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
              child: Text(
                widget.booking.id.toString(),
                style: theme.textTheme.titleMedium,
                maxLines: 1,
              )),
        ],
      ),
    );
  }
}
