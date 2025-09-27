import 'package:homework/generated/assets.dart';
import 'package:homework/router/app_router.dart';
import 'package:homework/ui/home/ui/tabs/more/ui/support_tickets/widget/section_title.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/store/workspace_store.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/ui/dashboard/widget/workspace_row_widget.dart';
import 'package:homework/widget/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkspaceManagerWidget extends StatefulWidget {
  const WorkspaceManagerWidget({Key? key}) : super(key: key);

  @override
  State<WorkspaceManagerWidget> createState() => _WorkspaceManagerWidgetState();
}

class _WorkspaceManagerWidgetState extends State<WorkspaceManagerWidget> {
  final workspaceStore = WorkspaceStore();

  @override
  void initState() {
    super.initState();
    workspaceStore
        .getHostWorkspaces(); // Trigger the API call to fetch workspaces
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Observer(builder: (context) {
      var workspaces = workspaceStore.workspaceResponse;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: "workspace manager", subtitle: ""),
          8.h.verticalSpace,
          addNewWorkspace(),
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
                  padding: EdgeInsets.symmetric(vertical: 8.r, horizontal: 10.r),
                  child: Row(
                    children: [
                     /* Expanded(
                        flex: 1,
                        child: Checkbox(
                          value: false,
                          onChanged: (value) {},
                        ),
                      ),*/
                      Expanded(
                        flex: 3,
                        child: Text(
                          'workspace',
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
                workspaceStore.isLoading
                    ? Padding(
                        padding: EdgeInsets.all(20.r),
                        child: const CircularProgressIndicator(),
                      )
                    : workspaces?.isNotEmpty == true
                        ? ListView.separated(
                            itemCount: workspaces!.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              final workspace = workspaces[index];
                              return WorkspaceRowWidget(
                                workspace: workspace,
                                onDelete: () {
                                  workspaceStore
                                      .deleteWorkspace(workspace.id.toString());
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
                              child: const Text('no workspaces available.'),
                            ),
                          ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget addNewWorkspace() {
    return GestureDetector(
        onTap: () {
          appRouter.push(CreateWorkspaceRoute(
            onEdited: () {
              workspaceStore.getHostWorkspaces();
            },
          ));
        },
        child: Row(
          children: [
            AppImage(
                height: 30.r, width: 30.r, assetPath: Assets.imagesLargePlus),
            16.w.horizontalSpace,
            Expanded(
              child: Text(
                "add new workspace",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            )
          ],
        ));
  }
}
