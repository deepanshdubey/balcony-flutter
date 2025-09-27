import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/core/session/app_session.dart';
import 'package:homework/data/model/response/tenant_details.dart';
import 'package:homework/router/app_router.dart';
import 'package:homework/ui/concierge/Home/bulk_email_widget.dart';
import 'package:homework/ui/home/ui/tabs/chat/ui/chat_page.dart';
import 'package:homework/ui/home/ui/tabs/more/ui/support_tickets/store/support_ticket_store.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/widget/earning_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/widget/open_support_request_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/widget/promotion_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/widget/update_payout_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/store/property_store.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/ui/dashboard/store/dashboard_store.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/ui/dashboard/widget/property_manager_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/ui/dashboard/widget/prospact_tenant_view.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/ui/dashboard/widget/review_tenant_application.dart' show ReviewTenantApplication;
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/ui/dashboard/widget/tenant_manager_widget.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

class PropertyDashboardPage extends StatefulWidget {
  const PropertyDashboardPage({super.key});

  @override
  State<PropertyDashboardPage> createState() => _PropertyDashboardPageState();
}

class _PropertyDashboardPageState extends State<PropertyDashboardPage> {
  final dashboardStore = DashboardStore();
  final supportTicketStore = SupportTicketStore();
  final propertyStore = PropertyStore();
  List<ReactionDisposer>? disposers;


  /// Tracks which tenant IDs are selected
  Set<String> _selectedTenantIds = {};

  @override
  void initState() {
    super.initState();
    _addReactions();
    dashboardStore.getEarnings(
      session.user.id.toString(),
      isWorkspace: false,
    );
    propertyStore.getHostProperties();
    propertyStore.getTenantsByHostId();
  }


  void _addReactions() {
    disposers ??= [
      reaction((_) => propertyStore.errorMessage, (String? err) {
        if (err != null) alertManager.showError(context, err);
      }),
      reaction((_) => dashboardStore.bulkEmailResponse, (resp) {
        if (resp?.success ?? false) {
          alertManager.showSuccess(context, 'Email sent successfully');
        }
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
    final horizontalPadding = 0.w;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        20.h,
        horizontalPadding,
        100.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSupportRequestsRow(),
          SizedBox(height: 16.h),
          _buildEarningsRow(),
          SizedBox(height: 16.h),
          const ProspactTenantWidget(),
          SizedBox(height: 16.h),
          _buildPropertyManager(),
          SizedBox(height: 16.h),
          _buildTenantManager(),
          SizedBox(height: 16.h),
          const PromotionWidget(),
          SizedBox(height: 16.h),
          UpdatePayoutWidget(
            key: UniqueKey(),
            isWorkspace: false,
          ),
          SizedBox(height: 16.h),
          _buildBulkEmailSection(),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildSupportRequestsRow() {
    return Observer(builder: (_) {
      final count = supportTicketStore.supportTicketsResponse
              ?.where((t) => t.status == 'active' && t.property != null)
              .length ??
          0;
      return Row(
        children: [
          Flexible(
            flex: 1,
            child: OpenSupportRequestWidget(
              openSupportRequestCount: count,
              isLoading: supportTicketStore.isLoading,
            ),
          ),
          SizedBox(width: 16.w),
          const Spacer(),
        ],
      );
    });
  }

  Widget _buildEarningsRow() {
    return Observer(builder: (_) {
      final resp = dashboardStore.earningsResponse;
      final format = NumberFormat("\$###,###,###");
      return Row(
        children: [
          Flexible(
            flex: 1,
            child: EarningWidget(
              title: 'total earned',
              progress: 22,
              isLoading: dashboardStore.isLoading,
              formattedEarningsWithCurrency: format.format(resp?.earnings ?? 0),
              formattedTimePeriod: 'this month',
            ),
          ),
          SizedBox(width: 16.w),
          Flexible(
            flex: 1,
            child: EarningWidget(
              title: 'total deposited',
              progress: 74,
              isLoading: dashboardStore.isLoading,
              formattedEarningsWithCurrency: format.format(resp?.deposits ?? 0),
              formattedTimePeriod: 'this year',
            ),
          ),
        ],
      );
    });
  }

  Widget _buildPropertyManager() {
    return Observer(builder: (_) {
      return PropertyManagerWidget(
        properties: propertyStore.propertyResponse,
        isLoading: propertyStore.isLoading,
        onAddNew: () => appRouter.push(
          CreatePropertyRoute(onEdited: propertyStore.getHostProperties),
        ),
        onDelete: (id) => propertyStore.deleteProperty(id),
        onUpdate: (property) => appRouter.push(
          CreatePropertyRoute(
            existingProperty: property,
            onEdited: propertyStore.getHostProperties,
          ),
        ),
      );
    });
  }

  Widget _buildTenantManager() {
    return Observer(builder: (_) {
      final tenants = propertyStore.tenantsByHostResponse;
      final isLoading = propertyStore.isLoading;

      return TenantManagerWidget(
        tenants: tenants,
        isLoading: isLoading,
        selectedTenantIds: _selectedTenantIds,
        onSelectAll: _toggleSelectAllTenants,
        onTenantSelectionChanged: _toggleTenantSelection,
        onViewTenant: _viewTenant,
      );
    });
  }


  void _toggleSelectAllTenants() {
    final tenants = propertyStore.tenantsByHostResponse ?? [];
    setState(() {
      if (_selectedTenantIds.length == tenants.length) {
        _selectedTenantIds.clear();
      } else {
        _selectedTenantIds = tenants.map((t) => t.Id.toString()).toSet();
      }
    });
  }

  void _toggleTenantSelection(String id) {
    setState(() {
      if (_selectedTenantIds.contains(id)) {
        _selectedTenantIds.remove(id);
      } else {
        _selectedTenantIds.add(id);
      }
    });
  }

  void _viewTenant(Tenants tenant) {
    showAppBottomSheet(
      context,
      ReviewTenantApplication(
        tenant: tenant,
        onlyShowData: false,
      ),
    );
  }


  Widget _buildBulkEmailSection() {
    return Observer(
      builder: (_) {
        final resp = propertyStore.propertyResponse;
        final isLoading = dashboardStore.isSendingBulkEmail;
        final totalTenants = propertyStore.tenantsByHostResponse?.length ?? 0;

        final map = <String, String?>{};
        if (resp != null) {
          resp.forEach((p) {
            if (p.id != null && p.info?.name != null) {
              map[p.id!] = p.info!.name!;
            }
          });
        }
        return BulkEmailWidget(
          totalTenant: totalTenants,
          isEmailSending: isLoading,
          propertyMap: map,
          onSendEmailTapped: (ids, msg) => dashboardStore.sendBulkEmail(
              type: "leasing-property", ids: ids, message: msg),
        );
      },
    );
  }
}
