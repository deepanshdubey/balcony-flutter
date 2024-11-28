import 'package:balcony/core/alert/alert_manager.dart';
import 'package:balcony/router/app_router.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/property/store/property_store.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/property/widget/property_widget.dart';
import 'package:balcony/ui/home/widget/home_listing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class PropertyHomeWidget extends StatefulWidget {
  const PropertyHomeWidget({super.key});

  @override
  State<PropertyHomeWidget> createState() => _PropertyHomeWidgetState();
}

class _PropertyHomeWidgetState extends State<PropertyHomeWidget> {
  List<ReactionDisposer>? disposers;
  final store = PropertyStore();

  @override
  void initState() {
    super.initState();
    addDisposer();
    store.getProperty(status: "inactive");
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
            store.propertyResponse?.isNotEmpty == true || store.isLoading
                ? HomeListingWidget(
                    title: "properties",
                    onMoreClick: () {
                      appRouter.push(PropertyRoute());
                    },
                    isLoading: store.isLoading,

                    children: store.propertyResponse
                            ?.map(
                              (e) => PropertyWidget(data: e),
                            )
                            .toList() ??
                        [])
                : const SizedBox.shrink());
  }
}
