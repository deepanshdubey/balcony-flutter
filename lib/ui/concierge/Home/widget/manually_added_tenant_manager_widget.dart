import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/ui/concierge/Home/utils/tenant_scanner.dart';
import 'package:homework/ui/concierge/Home/widget/tenant_manager/header_text.dart';
import 'package:homework/ui/concierge/Home/widget/tenant_manager/tenant_list.dart';
import 'package:homework/ui/concierge/model/concierge_tanant_response.dart';
import 'package:homework/ui/concierge/store/concierge_store.dart';
import 'package:homework/widget/image_picker_widget.dart';
import 'package:mobx/mobx.dart';

import 'tenant_manager/property_input.dart';
import 'tenant_manager/scan_section.dart';

class ManuallyAddedTenantManagerWidget extends StatefulWidget {
  const ManuallyAddedTenantManagerWidget({super.key});

  @override
  State<ManuallyAddedTenantManagerWidget> createState() =>
      _ManuallyAddedTenantManagerWidgetState();
}

class _ManuallyAddedTenantManagerWidgetState
    extends State<ManuallyAddedTenantManagerWidget> {
  final conciergeStore = ConciergeStore();
  final TextEditingController _addPropertyController = TextEditingController();
  List<ReactionDisposer>? disposers;
  List<ConciergeTenant>? tenants;

  @override
  void initState() {
    super.initState();
    conciergeStore.conciergeTenantAll();
    _addReactions();
  }

  void _addReactions() {
    disposers ??= [
      reaction((_) => conciergeStore.conciergePropertyAddResponse, (response) {
        if (response?.success ?? false) {
          alertManager.showSuccess(context, "Property Added to dropdown");
          _addPropertyController.clear();
        }
      }),
      reaction((_) => conciergeStore.conciergeTenantAllResponse, (response) {
        tenants = response?.tenants?.conciergeTenants;
        setState(() {});
      }),
      reaction((_) => conciergeStore.errorMessage, (msg) {
        if (msg != null) alertManager.showError(context, msg);
      }),
    ];
  }

  @override
  void dispose() {
    for (final disposer in disposers ?? []) {
      disposer();
    }
    _addPropertyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Observer(
      builder: (_) {
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
                  title: "manually add tenant manager",
                  subtitle:
                      "this manager module is used if you do not use the leasing software...",
                ),
                24.verticalSpace,
                const Divider(),
                24.verticalSpace,
                ScanSection(onScan: _handleScan),
                24.verticalSpace,
                const Divider(),
                18.verticalSpace,
                PropertyInput(
                  controller: _addPropertyController,
                  onAdd: _handleAddProperty,
                ),
                24.verticalSpace,
                TenantList(
                    type: "concierge-tenant",
                    tenants: tenants ?? [],
                    store: conciergeStore),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleAddProperty() {
    final name = _addPropertyController.text;
    if (name.isNotEmpty) {
      conciergeStore.conciergePropertyAdd({"name": name});
    }
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
            TenantScanner(type: "concierge-tenant", allTenants: tenants!);
        await scanner.scanAndMatch(
          context: context,
          imagePath: path,
          onTenantSelected: (selectedTenant) {
            conciergeStore.parcelAdd("concierge-tenant", selectedTenant.Id!);
          },
        );
      },
    );
  }
}
