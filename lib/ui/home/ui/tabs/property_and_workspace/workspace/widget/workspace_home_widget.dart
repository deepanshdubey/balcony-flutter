import 'package:balcony/core/alert/alert_manager.dart';
import 'package:balcony/router/app_router.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/store/workspace_store.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/ui/workspace_page.dart';
import 'package:balcony/ui/home/widget/home_listing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import 'workspace_widget.dart';

class WorkspaceHomeWidget extends StatefulWidget {
  const WorkspaceHomeWidget({super.key});

  @override
  State<WorkspaceHomeWidget> createState() => _WorkspaceHomeWidgetState();
}

class _WorkspaceHomeWidgetState extends State<WorkspaceHomeWidget> {
  List<ReactionDisposer>? disposers;
  final store = WorkspaceStore();

  @override
  void initState() {
    super.initState();
    addDisposer();
    store.getWorkspace();
  }

  @override
  void dispose() {
    removeDisposer();
    super.dispose();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => store.errorMessage, (String? errorMessage) {
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
    return Observer(
        builder: (context) =>
            store.workspaceResponse?.isNotEmpty == true || store.isLoading
                ? HomeListingWidget(
                    title: "workspace",
                    onMoreClick: () {
                      appRouter.push( WorkspaceRoute());
                    },
                    isReverse: true,
                    isLoading: store.isLoading,
                    children: store.workspaceResponse
                            ?.map(
                              (e) => WorkspaceWidget(data: e),
                            )
                            .toList() ??
                        [])
                : const SizedBox.shrink());
  }
}
