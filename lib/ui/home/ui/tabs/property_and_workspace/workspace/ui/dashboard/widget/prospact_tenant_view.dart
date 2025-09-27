import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/data/model/response/tenant_details.dart';
import 'package:homework/generated/assets.dart';
import 'package:homework/router/app_router.dart';
import 'package:homework/ui/home/ui/tabs/chat/ui/chat_page.dart';
import 'package:homework/ui/home/ui/tabs/more/ui/support_tickets/widget/section_title.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/store/property_store.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/store/workspace_store.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/ui/dashboard/widget/property_row_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/ui/dashboard/widget/review_tenant_application.dart';
import 'package:homework/widget/app_image.dart';
import 'package:homework/widget/app_outlined_button.dart';
import 'package:mobx/mobx.dart';

class ProspactTenantWidget extends StatefulWidget {
  const ProspactTenantWidget({Key? key}) : super(key: key);

  @override
  State<ProspactTenantWidget> createState() => _ProspactTenantWidgetState();
}

class _ProspactTenantWidgetState extends State<ProspactTenantWidget> {
  final store = PropertyStore();
  List<ReactionDisposer>? disposers;


  @override
  void initState() {
    store.getProspectTenantsByHostId();
    addDisposer();
    super.initState();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => store.prospectTenantsByHostResponse, (response) {
setState(() {
});
      }),
    ];
  }

  void removeDisposer() {
    if (disposers == null) return;
    for (final element in disposers!) {
      element.reaction.dispose();
    }
  }

  @override
  void dispose() {
    removeDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Observer(builder: (context) {
      var tenants = store.prospectTenantsByHostResponse;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: "prospect tenant", subtitle: ""),
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
                      Checkbox(
                        value: false,
                        onChanged: (value) {},
                      ),
                      Expanded(
                        child: Text(
                          'tenant application',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.black54,
                          ),
                        ),
                      ),
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
                  itemCount: tenants?.length ?? 0,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final tenant = tenants?[index];
                    return TenantRowWidget(
                     tenants: tenant,
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
                    child: const Text('no Tenant available.'),
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
  final Tenants? tenants;

  const TenantRowWidget({
    Key? key,
    required this.tenants,
  }) : super(key: key);

  @override
  State<TenantRowWidget> createState() => _TenantRowWidgetState();
}

class _TenantRowWidgetState extends State<TenantRowWidget> {
  final store = PropertyStore();


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
          flex: 2,
          child: AppOutlinedButton(
            padding: EdgeInsets.zero,
            style: TextStyle(fontSize: 13.spMin),
            text: "view",
            onPressed: ()  {
               showAppBottomSheet(
                context,
                ReviewTenantApplication(tenant: widget.tenants),
              );
            },
          ),
        ),

        20.horizontalSpace
      ],
    );
  }
}

