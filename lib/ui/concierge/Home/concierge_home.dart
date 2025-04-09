import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/ui/concierge/Home/explore_link.dart';
import 'package:homework/ui/concierge/Home/maintenance_table.dart';
import 'package:homework/ui/concierge/Home/ongoing_parcel_table.dart';
import 'package:homework/ui/concierge/Home/parcel_info.dart';
import 'package:homework/ui/concierge/Home/property_tab.dart';
import 'package:homework/ui/concierge/Home/widget/concierge_header.dart';
import 'package:homework/ui/concierge/Home/widget/leased_tenant_manager_widget.dart';
import 'package:homework/ui/concierge/Home/widget/manually_added_tenant_manager_widget.dart';
import 'package:homework/ui/concierge/model/concierge_tanant_response.dart';
import 'package:homework/ui/concierge/store/concierge_store.dart';
import 'package:homework/values/extensions/theme_ext.dart';
import 'package:mobx/mobx.dart';

import 'bulk_email_widget.dart';

@RoutePage()
class ConciergeHomePage extends StatefulWidget {
  const ConciergeHomePage({super.key});

  @override
  _ConciergeHomePageState createState() => _ConciergeHomePageState();
}

class _ConciergeHomePageState extends State<ConciergeHomePage> {
  final conciergeStore = ConciergeStore();
  List<ReactionDisposer>? disposers;

  @override
  void initState() {
    super.initState();
    conciergeStore.conciergePropertyAll();
    conciergeStore.conciergeTenantAll();
    _addReactions();
  }

  void _addReactions() {
    disposers ??= [
      reaction((_) => conciergeStore.bulkEmailResponse, (resp) {
        if (resp?.success ?? false) {
          alertManager.showSuccess(context, 'Email sent successfully');
        }
      }),
      reaction((_) => conciergeStore.pendingParcelRemindResponse, (resp) {
        if (resp?.success ?? false) {
          alertManager.showSuccess(context, 'Remind email sent successfully');
        }
      }),
      reaction((_) => conciergeStore.errorMessage, (String? err) {
        if (err != null) alertManager.showError(context, err);
      }),
    ];
  }

  @override
  void dispose() {
    for (final d in disposers ?? []) {
      d.reaction.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.h),
              const ConciergeHeader(),
              SizedBox(height: 35.h),
              _buildPropertyTab(),
              SizedBox(height: 24.h),
              _buildDivider(),
              _buildParcelInfo(),
              SizedBox(height: 24.h),
              _buildDivider(),
              _buildLeasingTenants(),
              SizedBox(height: 24.h),
              _buildDivider(),
              _buildConciergeTenants(),
              SizedBox(height: 24.h),
              _buildDivider(),
              const OngoingParcelTable(),
              SizedBox(height: 24.h),
              _buildDivider(),
              _buildBulkEmailSection(),
              SizedBox(height: 24.h),
              _buildDivider(),
              const MaintenanceTable(),
              SizedBox(height: 24.h),
              ExploreLinksWidget(),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    final color = Theme.of(context).colors.primaryColor;
    return Divider(color: color, thickness: 1);
  }

  Widget _buildPropertyTab() {
    return Observer(
      builder: (_) {
        final resp = conciergeStore.conciergePropertyResponse;
        if (resp == null) {
          return const Center(child: CircularProgressIndicator());
        }
        final names =
            resp.properties?.leasingProperties?.map((p) => p.name).toList() ??
                [];
        return PropertyTab(propertyNames: names);
      },
    );
  }

  Widget _buildParcelInfo() {
    return Observer(
      builder: (_) {
        final resp = conciergeStore.conciergeTenantAllResponse?.tenants;

        // Safely extract tenant lists or default to empty lists
        final leasingList = resp?.leasingTenants ?? <ConciergeTenant>[];
        final conciergeList = resp?.conciergeTenants ?? <ConciergeTenant>[];

        // Correctly sum total parcels, not just counting tenants
        final count =
            leasingList.fold<int>(0, (sum, t) => sum + (t.parcels ?? 0)) +
                conciergeList.fold<int>(0, (sum, t) => sum + (t.parcels ?? 0));

        final isRemindingForPendingParcel =
            conciergeStore.isRemindingForPendingParcel;

        return ParcelInfo(
          isLoading: conciergeStore.isLoading,
          pendingParcelCount: count,
          isRemindingForPendingParcel: isRemindingForPendingParcel,
          onEmailPressed: () {
            conciergeStore.remindForPendingParcel();
          },
        );
      },
    );
  }

  Widget _buildLeasingTenants() {
    return Observer(
      builder: (_) {
        final resp = conciergeStore.conciergeTenantAllResponse?.tenants;

        // Safely extract tenant lists or default to empty lists
        final leasingList = resp?.leasingTenants ?? <ConciergeTenant>[];
        return LeasedTenantManagerWidget(
          key: UniqueKey(),
          tenants: leasingList,
        );
      },
    );
  }

  Widget _buildConciergeTenants() {
    return Observer(
      builder: (_) {
        final resp = conciergeStore.conciergeTenantAllResponse?.tenants;

        // Safely extract tenant lists or default to empty lists
        final conciergeTenants = resp?.conciergeTenants ?? <ConciergeTenant>[];
        return ManuallyAddedTenantManagerWidget(
          key: UniqueKey(),
          tenants: conciergeTenants,
        );
      },
    );
  }

  Widget _buildBulkEmailSection() {
    return Observer(
      builder: (_) {
        final resp = conciergeStore.conciergePropertyResponse;
        final isLoading = conciergeStore.isSendingBulkEmail;

        final map = <String, String?>{};
        if (resp != null) {
          resp.properties?.leasingProperties?.forEach((p) {
            if (p.Id != null && p.name != null) map[p.Id!] = p.name!;
          });
          resp.properties?.conciergeProperties?.forEach((p) {
            if (p.Id != null && p.name != null) map[p.Id!] = p.name!;
          });
        }

        return BulkEmailWidget(
          totalTenant: map.length,
          isEmailSending: isLoading,
          propertyMap: map,
          onSendEmailTapped: (ids, msg) =>
              conciergeStore.sendBulkEmail(ids: ids, message: msg),
        );
      },
    );
  }
}
