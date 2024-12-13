import 'package:homework/ui/home/ui/tabs/more/ui/support_tickets/widget/section_title.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/store/workspace_store.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/ui/dashboard/widget/past_bookings_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PastBookingsWidget extends StatefulWidget {
  const PastBookingsWidget({Key? key}) : super(key: key);

  @override
  State<PastBookingsWidget> createState() => _PastBookingsWidgetState();
}

class _PastBookingsWidgetState extends State<PastBookingsWidget> {
  final workspaceStore = WorkspaceStore();

  @override
  void initState() {
    super.initState();
    workspaceStore.getPastBookings();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Observer(builder: (context) {
      var bookings = workspaceStore.bookingsResponse;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: "past bookings", subtitle: ""),
          8.h.verticalSpace,
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
              border: Border.all(color: Colors.black.withOpacity(.25)),
            ),
            child: Column(
              children: [
                // Header Row
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        topRight: Radius.circular(12.r)),
                    color: Colors.grey[200],
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8.r, horizontal: 0.r),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Checkbox(
                          value: false,
                          onChanged: (value) {},
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'workspace',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Text(
                            'status',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: Text(
                            'order number',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Data Rows
                workspaceStore.isLoading
                    ? Padding(
                        padding: EdgeInsets.all(20.r),
                        child: const CircularProgressIndicator(),
                      )
                    : bookings?.isNotEmpty == true
                        ? ListView.separated(
                            itemCount: bookings!.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              final workspace = bookings[index];
                              return PastBookingsRowWidget(
                                booking: workspace,

                              );
                            },
                            separatorBuilder: (context, index) => Divider(
                              height: 1.h,
                              color: Colors.black26,
                            ),
                          )
                        : Center(
                            child: Padding(
                              padding: EdgeInsets.all(20.r),
                              child: const Text('no bookings available.'),
                            ),
                          ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
