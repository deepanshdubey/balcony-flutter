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
import 'package:homework/widget/app_image.dart';

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
                          'property',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Text(
                            'status',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: Text(
                            'update space',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.black54,
                            ),
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
  State<PropertyRowWidget> createState() => _PropertyRowWidgetState();
}

class _PropertyRowWidgetState extends State<PropertyRowWidget> {
  // bool isSelected = false;
  // bool isActive = false;
  // final propertyStore = PropertyStore();

  @override
  void initState() {
  //  isActive = widget.property.status == 'active';
/*    reaction((_) => propertyStore.propertyStatusResponse, (response) {
      if (response != null) {
        setState(() {
          isActive = !isActive;
        });
      }
    });

    reaction((_) => propertyStore.errorMessage, (response) {
      if (response != null) {
        alertManager.showError(context, response);
      }
    });*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        // Expanded(
        //   flex: 1,
        //   child: Checkbox(
        //     value: isSelected,
        //     onChanged: (value) {
        //       setState(() {
        //         isSelected = value ?? false;
        //       });
        //     },
        //   ),
        // ),
        Expanded(
          flex: 3,
          child: Text(
            widget.property.info?.name ?? "no name",
            style: theme.textTheme.bodyLarge,
          ),
        ),
/*        Expanded(
          flex: 2,
          child: Observer(builder: (context) {
            var isLoading = propertyStore.isLoading;
            return Center(
              child: SizedBox(
                width: 24.r,
                height: 24.r,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : Switch(
                  value: isActive,
                  onChanged: (value) {
                    propertyStore.updatePropertyStatus(
                        widget.property.id.toString(), value);
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            );
          }),
        ),*/
       /* Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  onTap: () {
                    appRouter.push(CreatePropertyRoute(existingProperty: widget.property));
                  },
                  child: Text(
                    "update",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        decoration: TextDecoration.underline,
                        fontSize: 12.spMin),
                  )),
              GestureDetector(
                  onTap: () {
                    alertManager.showSystemAlertDialog(
                        context: context, onConfirm: widget.onDelete);
                  },
                  child: Text(
                    "delete",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        decoration: TextDecoration.underline,
                        fontSize: 12.spMin),
                  )),
            ],
          ),
        ),*/
      ],
    );
  }
}

