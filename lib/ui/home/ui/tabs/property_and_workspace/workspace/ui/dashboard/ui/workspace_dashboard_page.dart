import 'package:homework/core/session/app_session.dart';
import 'package:homework/ui/home/ui/tabs/more/ui/support_tickets/store/support_ticket_store.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/widget/earning_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/widget/open_support_request_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/widget/promotion_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/widget/update_payout_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/ui/dashboard/store/dashboard_store.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/ui/dashboard/widget/booking_acceptance_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/ui/dashboard/widget/bookings_overview_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/ui/dashboard/widget/ongoing_bookings_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/ui/dashboard/widget/past_bookings_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/ui/dashboard/widget/workspace_manager_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class WorkspaceDashboardPage extends StatefulWidget {
  const WorkspaceDashboardPage({super.key});

  @override
  State<WorkspaceDashboardPage> createState() => _WorkspaceDashboardPageState();
}

class _WorkspaceDashboardPageState extends State<WorkspaceDashboardPage> {
  final dashboardStore = DashboardStore();

  @override
  void initState() {
    supportTicketStore.getSupportTickets();
    dashboardStore.getEarnings(session.user.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Observer(builder: (context) {
          var count = supportTicketStore.supportTicketsResponse
              ?.where(
                (element) =>
                    element.status == 'active' && element.workspace != null,
              )
              .length;
          var isLoading = supportTicketStore.isLoading;
          return Row(
            children: [
              Flexible(
                  flex: 1,
                  child: OpenSupportRequestWidget(
                    openSupportRequestCount: count ?? 0,
                    isLoading: isLoading,
                  )),
              16.w.horizontalSpace,
              const Spacer(),
            ],
          );
        }),
        16.h.verticalSpace,
        Observer(builder: (context) {
          var isLoading = dashboardStore.isLoading;
          var totalEarned = dashboardStore.earningsResponse?.earnings ?? 0;
          var totalDeposited = dashboardStore.earningsResponse?.deposits ?? 0;
          var format = NumberFormat("\$###,###,###");
          return Row(
            children: [
              Flexible(
                flex: 1,
                child: EarningWidget(
                  progress: 22,
                  formattedEarningsWithCurrency: format.format(totalEarned),
                  formattedTimePeriod: 'this month',
                  title: 'total earned',
                  isLoading: isLoading,
                ),
              ),
              16.w.horizontalSpace,
              Flexible(
                flex: 1,
                child: EarningWidget(
                    title: 'total deposited',
                    progress: 74,
                    isLoading: isLoading,
                    formattedEarningsWithCurrency:
                        format.format(totalDeposited),
                    formattedTimePeriod: 'this year'),
              ),
            ],
          );
        }),
        16.h.verticalSpace,
        BookingsOverviewWidget(),
        16.h.verticalSpace,
        WorkspaceManagerWidget(),
        16.h.verticalSpace,
        OnGoingBookingsWidget(),
        16.h.verticalSpace,
        PastBookingsWidget(),
        16.h.verticalSpace,
        PromotionWidget(),
        16.h.verticalSpace,
        UpdatePayoutWidget(
          key: UniqueKey(),
        ),
        16.h.verticalSpace,
        BookingAcceptanceWidget(),
        100.h.verticalSpace,
      ],
    );
  }
}
