import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/generated/assets.dart';
import 'package:homework/ui/concierge/Home/explore_link.dart';
import 'package:homework/ui/concierge/Home/maintenance_table.dart';
import 'package:homework/ui/concierge/Home/ongoing_parcel_table.dart';
import 'package:homework/ui/concierge/Home/parcel_info.dart';
import 'package:homework/ui/concierge/Home/property_tab.dart';
import 'package:homework/ui/concierge/Home/widget/leased_tenant_manager_widget.dart';
import 'package:homework/ui/concierge/Home/widget/manually_added_tenant_manager_widget.dart';
import 'package:homework/ui/concierge/login/concierge_more_page.dart';
import 'package:homework/ui/concierge/store/concierge_store.dart';
import 'package:homework/values/extensions/context_ext.dart';
import 'package:homework/values/extensions/theme_ext.dart';
import 'package:mobx/mobx.dart';

import '../../../core/alert/alert_manager.dart';
import 'bulk_email_widget.dart';

@RoutePage()
class ConciergeHomePage extends StatefulWidget {
  const ConciergeHomePage({super.key});

  @override
  State<ConciergeHomePage> createState() => _ConciergeHomePageState();
}

class _ConciergeHomePageState extends State<ConciergeHomePage> {
  final conciergeStore = ConciergeStore();
  List<ReactionDisposer>? disposers;

  @override
  void initState() {
    super.initState();
    conciergeStore.conciergePropertyAll();
    addDisposer();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => conciergeStore.bulkEmailResponse, (response) {
        if (response?.success ?? false) {
          alertManager.showSuccess(context, "Email sent successfully");
        }
      }),
      reaction((_) => conciergeStore.errorMessage, (String? errorMessage) {
        if (errorMessage != null) {
          alertManager.showError(context, errorMessage);
        }
      }),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    removeDisposer();
  }

  void removeDisposer() {
    if (disposers == null) return;
    for (final element in disposers!) {
      element.reaction.dispose();
    }
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
              // Property tab with store data
              Observer(
                builder: (_) {
                  final response = conciergeStore.conciergePropertyResponse;
                  if (response == null) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final names = response.properties?.leasingProperties
                          ?.map((p) => p.name)
                          .toList() ??
                      [];
                  return PropertyTab(
                    propertyNames: names,
                  );
                },
              ),
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
              const LeasedTenantManagerWidget(),
              24.verticalSpace,
              Divider(
                color: Theme.of(context).colors.primaryColor,
                thickness: 1,
              ),
              24.verticalSpace,
              const ManuallyAddedTenantManagerWidget(),
              24.verticalSpace,
              Divider(
                color: Theme.of(context).colors.primaryColor,
                thickness: 1,
              ),
              24.verticalSpace,
              const OngoingParcelTable(),
              24.verticalSpace,
              Divider(
                color: Theme.of(context).colors.primaryColor,
                thickness: 1,
              ),
              24.verticalSpace,
              Observer(
                builder: (_) {
                  final isLoading = conciergeStore.isSendingBulkEmail;
                  final response = conciergeStore.conciergePropertyResponse;
                  final Map<String, String?> propertiesMap = {};
                  if (response != null) {
                    response.properties?.leasingProperties?.forEach((p) {
                      if (p.Id != null && p.name != null) {
                        propertiesMap[p.Id!] = p.name!;
                      }
                    });
                    response.properties?.conciergeProperties?.forEach((p) {
                      if (p.Id != null && p.name != null) {
                        //  propertiesMap[p.Id!] = p.name!;
                      }
                    });
                  }
                  final totalTenants = propertiesMap.length;
                  return BulkEmailWidget(
                    totalTenant: totalTenants,
                    isEmailSending: isLoading,
                    propertyMap: propertiesMap,
                    onSendEmailTapped: (List<String> ids, String message) {
                      conciergeStore.sendBulkEmail(ids: ids, message: message);
                    },
                  );
                },
              ),
              24.verticalSpace,
              Divider(
                color: Theme.of(context).colors.primaryColor,
                thickness: 1,
              ),
              24.verticalSpace,
              const MaintenanceTable(),
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
              const Spacer(),
              GestureDetector(
                onTap: () {
                  showAppBottomSheet(
                    context,
                    const ConciergeMorePage(),
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
}
