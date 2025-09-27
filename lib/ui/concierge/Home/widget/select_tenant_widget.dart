import 'package:flutter/material.dart';
import 'package:homework/ui/concierge/model/concierge_tanant_response.dart';
import 'package:homework/widget/primary_button.dart';

class SelectTenantWidget extends StatefulWidget {
  final List<ConciergeTenant> matchedTenants;
  final void Function(ConciergeTenant) onTenantSelected;
  final void Function(ConciergeTenant) onTenantInfoTapped;

  const SelectTenantWidget({
    super.key,
    required this.matchedTenants,
    required this.onTenantSelected,
    required this.onTenantInfoTapped,
  });

  static Future<void> showAsBottomSheet({
    required BuildContext context,
    required List<ConciergeTenant> matchedTenants,
    required void Function(ConciergeTenant) onTenantSelected,
    required void Function(ConciergeTenant) onTenantInfoTapped,
  }) async {
    await showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SelectTenantWidget(
        matchedTenants: matchedTenants,
        onTenantSelected: onTenantSelected,
        onTenantInfoTapped: onTenantInfoTapped,
      ),
    );
  }

  @override
  State<SelectTenantWidget> createState() => _SelectTenantWidgetState();
}

class _SelectTenantWidgetState extends State<SelectTenantWidget> {
  ConciergeTenant? selectedTenant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Choose Tenant", style: theme.textTheme.titleLarge),
          const SizedBox(height: 16),
          ListView.builder(
            itemCount: widget.matchedTenants.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final tenant = widget.matchedTenants[index];
              return Row(
                children: [
                  Radio<ConciergeTenant>(
                    value: tenant,
                    groupValue: selectedTenant,
                    onChanged: (value) {
                      setState(() => selectedTenant = value);
                    },
                  ),
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: () {
                        setState(() => selectedTenant = tenant);
                      },
                      child: Text(
                        "${tenant.info?.firstName ?? ''} ${tenant.info?.lastName ?? ''}",
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.info_outline,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () => widget.onTenantInfoTapped(tenant),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              text: "confirm",
              enabled: selectedTenant != null,
              onPressed: () {
                Navigator.pop(context);
                widget.onTenantSelected(selectedTenant!);
              },
            ),
          ),
        ],
      ),
    );
  }
}
