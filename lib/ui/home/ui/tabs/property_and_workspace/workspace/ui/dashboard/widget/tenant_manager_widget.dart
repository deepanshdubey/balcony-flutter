import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/data/model/response/tenant_details.dart';
import 'package:homework/ui/home/ui/tabs/more/ui/support_tickets/widget/section_title.dart';import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/widget/tenant_row_widget.dart';

/// Displays a list of tenants with selection checkboxes and a “view” button.
class TenantManagerWidget extends StatelessWidget {
  /// The list of tenants to show.
  final List<Tenants>? tenants;

  /// Whether the list is currently loading.
  final bool isLoading;

  /// The set of tenant IDs that are currently selected.
  final Set<String> selectedTenantIds;

  /// Called when the header checkbox is toggled (select/unselect all).
  final VoidCallback onSelectAll;

  /// Called when an individual tenant’s checkbox is toggled.
  final ValueChanged<String> onTenantSelectionChanged;

  /// Called when the “view” button is tapped for a tenant.
  final ValueChanged<Tenants> onViewTenant;

  const TenantManagerWidget({
    super.key,
    required this.tenants,
    required this.isLoading,
    required this.selectedTenantIds,
    required this.onSelectAll,
    required this.onTenantSelectionChanged,
    required this.onViewTenant,
  });

  @override
  Widget build(BuildContext context) {
    final headerStyle = Theme.of(context)
        .textTheme
        .titleMedium
        ?.copyWith(color: Colors.black54);

    final allSelected = tenants != null &&
        tenants!.isNotEmpty &&
        selectedTenantIds.length == tenants!.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: "tenant manager", subtitle: ""),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.black.withAlpha(60)),
          ),
          child: Column(
            children: [
              // Header row with “select all”
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(12.r)),
                ),
                padding: EdgeInsets.symmetric(vertical: 8.r),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Checkbox(
                        value: allSelected,
                        onChanged: (_) => onSelectAll(),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text("Tenant's name", style: headerStyle),
                    ),
                    Expanded(
                      flex: 3,
                      child: Center(
                          child: Text("lease overview", style: headerStyle)),
                    ),
                    SizedBox(width: 10.w),
                  ],
                ),
              ),

              // Body: loading / list / empty
              if (isLoading)
                Padding(
                  padding: EdgeInsets.all(20.r),
                  child: const CircularProgressIndicator(),
                )
              else if (tenants != null && tenants!.isNotEmpty)
                ListView.separated(
                  itemCount: tenants!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  separatorBuilder: (_, __) =>
                      Divider(height: 1.h, color: Colors.black26),
                  itemBuilder: (context, i) {
                    final t = tenants![i];
                    final id = t.Id.toString();
                    final isSelected = selectedTenantIds.contains(id);
                    return TenantRowWidget(
                      tenant: t,
                      isSelected: isSelected,
                      onSelected: (_) => onTenantSelectionChanged(id),
                      onView: () => onViewTenant(t),
                    );
                  },
                )
              else
                Padding(
                  padding: EdgeInsets.all(20.r),
                  child: const Center(child: Text('no tenants available.')),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
