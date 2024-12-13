import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/generated/assets.dart';
import 'package:homework/router/app_router.dart';
import 'package:homework/ui/home/ui/tabs/more/ui/support_tickets/widget/section_title.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/store/property_store.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/store/workspace_store.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/ui/dashboard/widget/property_row_widget.dart';
import 'package:homework/widget/app_image.dart';

class PropertyManagerWidget extends StatefulWidget {
  const PropertyManagerWidget({Key? key}) : super(key: key);

  @override
  State<PropertyManagerWidget> createState() => _PropertyManagerWidgetState();
}

class _PropertyManagerWidgetState extends State<PropertyManagerWidget> {
  final store = PropertyStore();

  @override
  void initState() {
    super.initState();
    store.getHostProperties();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Observer(builder: (context) {
      var properties = store.propertyResponse;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: "property manager", subtitle: ""),
          8.h.verticalSpace,
          addNewProperty(),
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
                    : properties?.isNotEmpty == true
                        ? ListView.separated(
                            itemCount: properties!.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              final property = properties[index];
                              return PropertyRowWidget(
                                property: property,
                                onDelete: () {
                                  workspaceStore
                                      .deleteWorkspace(property.id.toString());
                                },
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

  Widget addNewProperty() {
    return GestureDetector(
        onTap: () {
          appRouter.push(CreatePropertyRoute(
              /*onEdited: () {
              workspaceStore.getHostWorkspaces();
            },*/
              ));
        },
        child: Row(
          children: [
            AppImage(
                height: 30.r, width: 30.r, assetPath: Assets.imagesLargePlus),
            16.w.horizontalSpace,
            Expanded(
              child: Text(
                "add new property",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            )
          ],
        ));
  }
}
