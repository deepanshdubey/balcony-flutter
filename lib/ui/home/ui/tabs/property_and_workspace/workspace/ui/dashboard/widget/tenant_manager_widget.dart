import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/data/model/response/tenant_details.dart';
import 'package:homework/generated/assets.dart';
import 'package:homework/router/app_router.dart';
import 'package:homework/ui/home/ui/tabs/more/ui/support_tickets/widget/section_title.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/store/property_store.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/store/workspace_store.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/ui/dashboard/widget/property_row_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/ui/dashboard/widget/review_tenant_application.dart';
import 'package:homework/values/extensions/context_ext.dart';
import 'package:homework/widget/app_image.dart';
import 'package:homework/widget/app_outlined_button.dart';

class TenantManagerWidget extends StatefulWidget {
  const TenantManagerWidget({Key? key}) : super(key: key);

  @override
  State<TenantManagerWidget> createState() => _TenantManagerWidgetState();
}

class _TenantManagerWidgetState extends State<TenantManagerWidget> {
  final store = PropertyStore();

  @override
  void initState() {
    super.initState();
    store.getTenantsByHostId();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Observer(builder: (context) {
      var tenants = store.tenantsByHostResponse;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: "Tenant manager", subtitle: ""),
          8.h.verticalSpace,
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
              border: Border.all(color: Colors.black.withOpacity(.25)),
            ),
            child: Column(
              children: [
                // Header Row
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        topRight: Radius.circular(12.r)),
                    color: Colors.grey[200],
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8.r, horizontal: 0.r),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Checkbox(
                          value: false,
                          onChanged: (value) {},
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Tenant\'s name',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: Text(
                            'lease overview',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      10.horizontalSpace
                    ],
                  ),
                ),
                // Data Rows
                store.isLoading
                    ? Padding(
                  padding: EdgeInsets.all(20.r),
                  child: const CircularProgressIndicator(),
                )
                    : tenants?.isNotEmpty == true
                    ? ListView.separated(
                  itemCount: tenants!.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final tenant = tenants[index];
                    return TenantRowWidget(
                      onDelete: () {
                        // workspaceStore
                        //     .deleteWorkspace(property.id.toString());
                      }, tenants: tenant,
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    height: 1.h,
                    color: Colors.black26,
                  ),
                )
                    : Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.r),
                    child: const Text('no properties available.'),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }


}


class TenantRowWidget extends StatefulWidget {
  final Tenants tenants;
  final VoidCallback onDelete;

  const TenantRowWidget({
    Key? key,
    required this.onDelete, required this.tenants,
  }) : super(key: key);

  @override
  State<TenantRowWidget> createState() => _TenantRowWidgetState();
}

class _TenantRowWidgetState extends State<TenantRowWidget> {



  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Checkbox(
          value: false,
          onChanged: (value) {

          },
        ),
        Expanded(
          flex: 3,
          child: Text(
            widget.tenants?.info?.firstName ?? "no name",
            style: theme.textTheme.bodyLarge,
          ),
        ),
        Expanded(
          flex: 1,
          child: AppOutlinedButton(
            padding: EdgeInsets.zero,
            style: TextStyle(fontSize: 13.spMin),
            text: "view",
            onPressed: ()  {
              showAppBottomSheet(
                context,
                ReviewTenantApplication(tenant: widget.tenants , onlyShowData: false, ),
              );
            },
          ),
        ),
        20.horizontalSpace

      ],
    );
  }
}

