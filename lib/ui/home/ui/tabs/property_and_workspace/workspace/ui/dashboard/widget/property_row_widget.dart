import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/data/model/response/property_data.dart';

import 'package:homework/router/app_router.dart';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/store/property_store.dart';
import 'package:mobx/mobx.dart';

class PropertyRowWidget extends StatefulWidget {
  final PropertyData property;
  final VoidCallback onDelete;

  const PropertyRowWidget({
    Key? key,
    required this.property,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<PropertyRowWidget> createState() => _PropertyRowWidgetState();
}

class _PropertyRowWidgetState extends State<PropertyRowWidget> {
  bool isSelected = false;
  bool isActive = false;
  final propertyStore = PropertyStore();

  @override
  void initState() {
    isActive = widget.property.status == 'active';
    reaction((_) => propertyStore.propertyStatusResponse, (response) {
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
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Checkbox(
            value: isSelected,
            onChanged: (value) {
              setState(() {
                isSelected = value ?? false;
              });
            },
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            widget.property.info?.name ?? "no name",
            style: theme.textTheme.bodyLarge,
          ),
        ),
        Expanded(
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
        ),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  onTap: () {
                    appRouter.push(CreatePropertyRoute(/*editWorkspaceItem: widget.property*/));
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
    );
  }
}
