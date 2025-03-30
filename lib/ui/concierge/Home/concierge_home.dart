import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/generated/assets.dart';
import 'package:homework/ui/concierge/Home/explore_link.dart';
import 'package:homework/ui/concierge/Home/lease_tenant_table.dart';
import 'package:homework/ui/concierge/Home/maintenance_table.dart';
import 'package:homework/ui/concierge/Home/ongoing_parcel_table.dart';
import 'package:homework/ui/concierge/Home/parcel_info.dart';
import 'package:homework/ui/concierge/Home/property_tab.dart';
import 'package:homework/ui/concierge/login/concierge_more_page.dart';
import 'package:homework/ui/concierge/login/concierge_sign_in_page.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/ui/dashboard/widget/tenant_manager_widget.dart';
import 'package:homework/values/extensions/context_ext.dart';
import 'package:homework/values/extensions/theme_ext.dart';
import 'package:homework/widget/primary_button.dart';

import 'concierge_tanant_table.dart';

@RoutePage()
class ConciergeHomePage extends StatefulWidget {
  const ConciergeHomePage({super.key});

  @override
  State<ConciergeHomePage> createState() => _ConciergeHomePageState();
}

class _ConciergeHomePageState extends State<ConciergeHomePage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              50.verticalSpace,
              HeaderSection(theme),
              35.verticalSpace,
              const PropertyTab(),
              24.verticalSpace,
              Divider(
                color: Theme.of(context).colors.primaryColor,
                thickness: 1,
              ),
              24.verticalSpace,
              const ParcelInfo(),
              24.verticalSpace,
              Divider(
                color: Theme.of(context).colors.primaryColor,
                thickness: 1,
              ),
              24.verticalSpace,
              const LeaseTenantTable(),
              24.verticalSpace,
              Divider(
                color: Theme.of(context).colors.primaryColor,
                thickness: 1,
              ),
              24.verticalSpace,
              const ConciergeTenantTable(),
              24.verticalSpace,
              Divider(
                color: Theme.of(context).colors.primaryColor,
                thickness: 1,
              ),
              24.verticalSpace,
              OngoingParcelTable(),
              24.verticalSpace,
              Divider(
                color: Theme.of(context).colors.primaryColor,
                thickness: 1,
              ),
              24.verticalSpace,
              MaintenanceTable(),
              24.verticalSpace,
              ExploreLinksWidget(),
              30.verticalSpace
            ],
          ),
        ),
      ),
    );
  }

  Widget HeaderSection(ThemeData theme) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12).r,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20.0,
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15).r,
          child: Row(
            children: [
              20.horizontalSpace,
              Text(
                "homework",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 20.spMin,
                  fontWeight: FontWeight.w700,
                ),
              ),
              10.horizontalSpace,
           //   tabBar(theme),
              Spacer(),
              GestureDetector(
                onTap: () {
                  showAppBottomSheet(
                    context,
                    ConciergeMorePage(),
                  );
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                  decoration: BoxDecoration(
                      border: Border.all(color: theme.colors.grayBorder),
                      borderRadius: BorderRadius.all(Radius.circular(12.r))),
                  child: Image.asset(
                    Assets.imagesProfile,
                    height: 15.r,
                    width: 15.r,
                  ),
                ),
              ),
              20.horizontalSpace,
            ],
          ),
        ));
  }

  Widget tabBar(ThemeData theme) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
              border: Border.all(color: Colors.black.withOpacity(.25))),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTab(theme, "user", 0),
              _buildTab(theme, "host", 1),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTab(ThemeData theme, String text, int index) {
    final theme = Theme.of(context);

    bool isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
            color: isActive ? theme.colors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(12.r))),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 16.spMin,
            fontWeight: FontWeight.w500,
            color: _currentIndex == index
                ? theme.colors.backgroundColor
                : theme.colors.primaryColor,
          ),
        ),
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
