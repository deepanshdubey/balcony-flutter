import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/router/app_router.dart';
import 'package:homework/ui/concierge/Home/widget/tenant_manager/tenant_row.dart';
import 'package:homework/ui/concierge/model/concierge_tanant_response.dart';
import 'package:homework/ui/concierge/store/concierge_store.dart';
import 'package:homework/widget/primary_button.dart';

class TenantList extends StatelessWidget {
  final List<ConciergeTenant> tenants;
  final ConciergeStore store;
  final String type;

  const TenantList(
      {super.key,
      required this.tenants,
      required this.store,
      required this.type});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.black.withOpacity(.25)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.r),
            color: Colors.grey[200],
            child: Row(
              children: [
                const Expanded(
                    flex: 1, child: Checkbox(value: false, onChanged: null)),
                Expanded(
                  flex: 3,
                  child: Text('tenant\'s name',
                      style: theme.textTheme.titleMedium),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: PrimaryButton(
                      text: "add",
                      onPressed: () {
                        context.router.push(const TenantFormRoute()).then((_) {
                          store.conciergeTenantAll();
                        });
                      },
                    ),
                  ),
                ),
                10.horizontalSpace,
              ],
            ),
          ),
          if (store.isLoading)
            const Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            )
          else if (tenants.isNotEmpty)
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: tenants.length,
              itemBuilder: (_, i) => TenantRow(
                conciergeTenant: tenants[i],
                onInfo: () => context.router
                    .push(ConciergeTenantDetailsRoute(conciergeTenant: tenants[i], type: type))
                    .then((_) => store.conciergeTenantAll()),
              ),
              separatorBuilder: (_, __) =>
                  const Divider(height: 1, color: Colors.black26),
            )
          else
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text('no tenant available.'),
            ),
        ],
      ),
    );
  }
}
