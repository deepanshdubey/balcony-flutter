import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/ui/concierge/Home/utils/tenant_scanner.dart'
    show TenantScanner;
import 'package:homework/ui/concierge/Home/widget/tenant_manager/header_text.dart';
import 'package:homework/ui/concierge/Home/widget/tenant_manager/scan_section.dart';
import 'package:homework/ui/concierge/Home/widget/tenant_manager/tenant_list.dart';
import 'package:homework/ui/concierge/model/concierge_tanant_response.dart';
import 'package:homework/ui/concierge/store/concierge_store.dart';
import 'package:homework/widget/image_picker_widget.dart';
import 'package:mobx/mobx.dart';

class LeasedTenantManagerWidget extends StatefulWidget {
  const LeasedTenantManagerWidget({super.key});

  @override
  State<LeasedTenantManagerWidget> createState() =>
      _LeasedTenantManagerWidgetState();
}

class _LeasedTenantManagerWidgetState extends State<LeasedTenantManagerWidget> {
  final _addPropertyController = TextEditingController();
  final conciergeStore = ConciergeStore();
  List<ReactionDisposer>? _disposers;
  List<ConciergeTenant>? tenants;

  @override
  void initState() {
    super.initState();
    conciergeStore.conciergeTenantAll();
    _addReactions();
  }

  void _addReactions() {
    _disposers ??= [
      reaction((_) => conciergeStore.conciergePropertyAddResponse, (response) {
        if (response?.success ?? false) {
          alertManager.showSuccess(context, "Property Added to dropdown");
          _addPropertyController.clear();
        }
      }),
      reaction((_) => conciergeStore.conciergeTenantAllResponse, (response) {
        tenants = response?.tenants?.leasingTenants;
        setState(() {});
      }),
      reaction((_) => conciergeStore.errorMessage, (msg) {
        if (msg != null) {
          alertManager.showError(context, msg);
        }
      }),
    ];
  }

  @override
  void dispose() {
    for (final disposer in _disposers ?? []) {
      disposer();
    }
    _addPropertyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24).r,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12).r,
          border: Border.all(color: Colors.black.withOpacity(.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderText(
              theme: theme,
              title: "tenant manager w/ lease",
              subtitle:
                  "tenant data automatically comes here if they have a lease, but if you want add tenant data manually; you may do it on the tenant manager box on the module below.",
            ),
            24.verticalSpace,
            const Divider(),
            24.verticalSpace,
            ScanSection(onScan: _handleScan),
            24.verticalSpace,
            TenantList(
                type: "leasing-tenant",
                tenants: tenants ?? [],
                store: conciergeStore),
          ],
        ),
      ),
    );
  }

  void _handleScan() {
    ImagePickerWidget.showSourceSheet(
      context: context,
      onImageSelected: (path) async {
        if (tenants == null || tenants!.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No tenants available to match.")),
          );
          return;
        }
        final scanner =
            TenantScanner(type: "leasing-tenant", allTenants: tenants!);
        await scanner.scanAndMatch(
          context: context,
          imagePath: path,
          onTenantSelected: (selectedTenant) {
            conciergeStore.parcelAdd("leasing-tenant", selectedTenant.Id!);
          },
        );
      },
    );
  }
}
