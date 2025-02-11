import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/generated/assets.dart';
import 'package:homework/router/app_router.dart';
import 'package:homework/ui/concierge/model/concierge_tanant_response.dart';
import 'package:homework/ui/concierge/store/concierge_store.dart';
import 'package:homework/values/extensions/theme_ext.dart';
import 'package:homework/widget/primary_button.dart';
import 'package:mobx/mobx.dart';

class LeaseTenantTable extends StatefulWidget {
  const LeaseTenantTable({Key? key}) : super(key: key);

  @override
  State<LeaseTenantTable> createState() => _LeaseTenantTableState();
}

class _LeaseTenantTableState extends State<LeaseTenantTable> {
  TextEditingController _addPropertyController = TextEditingController();

  final conciergeStore = ConciergeStore();
  List<ReactionDisposer>? disposers;

  @override
  void initState() {
    conciergeStore.conciergeTenantAll();
    addDisposer();
    super.initState();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => conciergeStore.conciergePropertyAddResponse, (response) {
        if (response?.success ?? false) {
          alertManager.showSuccess(context, "Property Added to dropdown");
          _addPropertyController.clear();
        }
      }),
      reaction((_) => conciergeStore.errorMessage, (String? errorMessage) {
        if (errorMessage != null) {
          alertManager.showError(context, errorMessage);
        }
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return  Center(
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
            Text(
              "tenant manager w/ lease",
              style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 23.spMin,
                  fontWeight: FontWeight.w500,
                  color: theme.primaryColor),
            ),
            4.verticalSpace,
            Text(
                "tenant data automatically comes here if they have a lease, but if you want add tenant data manually; you may do it on the tenant manager box on the module below."),
            24.verticalSpace,
            Divider(
              color: Theme.of(context).colors.primaryColor,
              thickness: 1,
            ),
            24.verticalSpace,
            Row(
              children: [
                Image.asset(
                  Assets.imagesScanParcle,
                  height: 32.r,
                  width: 32.r,
                ),
                20.horizontalSpace,
                Expanded(
                  child: Text(
                    "add new parcels to the \nsystem the fast way.",
                    style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 14.spMin,
                        fontWeight: FontWeight.w500,
                        color: theme.primaryColor),
                    maxLines: 2,
                  ),
                )
              ],
            ),
            21.verticalSpace,
            PrimaryButton(
              text: "scan entire parcel label",
              onPressed: () {},
            ),
            24.verticalSpace,
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                border: Border.all(color: Colors.black.withOpacity(.25)),
              ),
              child: Observer(builder: (context) {
                var tenants = conciergeStore
                    .conciergeTenantAllResponse?.tenants?.leasingTenants;
                return Column(
                  children: [
                    // Header Row
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.r),
                            topRight: Radius.circular(12.r)),
                        color: Colors.grey[200],
                      ),
                      padding:
                      EdgeInsets.symmetric(vertical: 8.r, horizontal: 0.r),
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
                            flex: 1,
                            child: Text(
                              "•••",
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontSize: 8.spMin,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          10.horizontalSpace
                        ],
                      ),
                    ),
                    conciergeStore.isLoading
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
                        return TenantRowWidget(
                          onInfo: () {
                            context.router.push(ConciergeTenantDetailsRoute(conciergeTenant: tenants?[index])).then((value) {
                              conciergeStore.conciergeTenantAll();
                            },);
                          },
                          conciergeTenant: tenants?[index],
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
                    )
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class TenantRowWidget extends StatefulWidget {
  final ConciergeTenant? conciergeTenant;
  final VoidCallback onInfo;

  const TenantRowWidget({
    Key? key,
    required this.onInfo,
    required this.conciergeTenant,
  }) : super(key: key);

  @override
  State<TenantRowWidget> createState() => _TenantRowWidgetState();
}

class _TenantRowWidgetState extends State<TenantRowWidget> {
  final conciergeStore = ConciergeStore();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Checkbox(
          value: false,
          onChanged: (value) {},
        ),
        Expanded(
          flex: 3,
          child: Text(
           " ${widget.conciergeTenant?.info?.firstName} ${widget.conciergeTenant?.info?.lastName}" ,
            style: theme.textTheme.bodyLarge,
          ),
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: widget.onInfo,
            child: Text(
              "•••",
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 8.spMin,
                color: Colors.black54,
              ),
            ),
          ),
        ),
        20.horizontalSpace
      ],
    );
  }
}
