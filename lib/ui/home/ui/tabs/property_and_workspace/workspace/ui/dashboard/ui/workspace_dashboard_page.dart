import 'package:balcony/ui/home/ui/tabs/property_and_workspace/common/widget/earning_widget.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/common/widget/open_support_request_widget.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/common/widget/promotion_widget.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/common/widget/update_payout_widget.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/ui/dashboard/widget/booking_acceptance_widget.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/ui/dashboard/widget/bookings_overview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkspaceDashboardPage extends StatefulWidget {
  const WorkspaceDashboardPage({super.key});

  @override
  State<WorkspaceDashboardPage> createState() => _WorkspaceDashboardPageState();
}

class _WorkspaceDashboardPageState extends State<WorkspaceDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
                flex: 1,
                child: OpenSupportRequestWidget(
                  openSupportRequestCount: 5,
                  onViewRequestClickListener: () {},
                )),
            16.w.horizontalSpace,
            const Spacer(),
          ],
        ),
        16.h.verticalSpace,
        Row(
          children: [
            const Flexible(
              flex: 1,
              child: EarningWidget(
                progress: 22,
                formattedEarningsWithCurrency: '\$1,329',
                formattedTimePeriod: 'this month',
                title: 'total earned',
              ),
            ),
            16.w.horizontalSpace,
            const Flexible(
              flex: 1,
              child: EarningWidget(
                  title: 'total deposited',
                  progress: 74,
                  formattedEarningsWithCurrency: '\$5,329',
                  formattedTimePeriod: 'this year'),
            ),
          ],
        ),
        16.h.verticalSpace,
        BookingsOverviewWidget(),
        16.h.verticalSpace,
        PromotionWidget(),
        16.h.verticalSpace,
        UpdatePayoutWidget(key: UniqueKey(),),
        16.h.verticalSpace,
        BookingAcceptanceWidget(),
        100.h.verticalSpace,
      ],
    );
  }
}
