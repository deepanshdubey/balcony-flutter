import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/data/model/response/workspace_data.dart';
import 'package:homework/router/app_router.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/store/workspace_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';

class WorkspaceRowWidget extends StatefulWidget {
  final WorkspaceData workspace;
  final VoidCallback onDelete;

  const WorkspaceRowWidget({
    Key? key,
    required this.workspace,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<WorkspaceRowWidget> createState() => _WorkspaceRowWidgetState();
}

class _WorkspaceRowWidgetState extends State<WorkspaceRowWidget> {
  bool isSelected = false;
  bool isActive = false;
  final workspaceStore = WorkspaceStore();

  @override
  void initState() {
    isActive = widget.workspace.status == 'active';
    reaction((_) => workspaceStore.workspaceStatusResponse, (response) {
      if (response != null) {
        setState(() {
          isActive = !isActive;
        });
      }
    });

    reaction((_) => workspaceStore.errorMessage, (response) {
      if (response != null) {
        alertManager.showError(context, response);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 15).r,
      child: Row(
        children: [
       /*   Expanded(
            flex: 1,
            child: Checkbox(
              value: isSelected,
              onChanged: (value) {
                setState(() {
                  isSelected = value ?? false;
                });
              },
            ),
          ),*/
          Expanded(
            flex: 3,
            child: Text(
              widget.workspace.info?.name ?? "no name",
              style: theme.textTheme.bodyLarge,
            ),
          ),
          Expanded(
            flex: 2,
            child: Observer(builder: (context) {
              var isLoading = workspaceStore.isLoading;
              return Center(
                child: SizedBox(
                  width: 24.r,
                  height: 24.r,
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : Switch(
                          value: isActive,
                          onChanged: (value) {
                            workspaceStore.updateWorkspaceStatus(
                                widget.workspace.id.toString(), value);
                          },
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                ),
              );
            }),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      appRouter.push(CreateWorkspaceRoute(editWorkspaceItem: widget.workspace));
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
          ),
        ],
      ),
    );
  }
}
