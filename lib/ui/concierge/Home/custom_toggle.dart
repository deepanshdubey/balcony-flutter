import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/ui/concierge/store/concierge_store.dart';
import 'package:mobx/mobx.dart';

class CustomToggle extends StatefulWidget {
  final String? tenantId;

  const CustomToggle({Key? key, required this.tenantId}) : super(key: key);


  @override
  _CustomToggleState createState() => _CustomToggleState();
}

class _CustomToggleState extends State<CustomToggle> {
  bool isCompleted = false;

  List<ReactionDisposer>? disposers;
  final conciergeStore = ConciergeStore();


  @override
  void initState() {
    addDisposer();
    super.initState();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => conciergeStore.maintenanceToggleResponse, (response) {
        if (response?.success ?? false) {

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
    return Container(
      height: 30.h,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          // Completed
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  conciergeStore.maintenanceToggle(widget.tenantId ?? "");
                  isCompleted = true;
                });
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isCompleted ? Theme.of(context).primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "completed",
                  style: TextStyle(
                    color: isCompleted ? Colors.white :Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          // Awaiting Completion
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  conciergeStore.maintenanceToggle(widget.tenantId ?? "");
                  isCompleted = false;
                });
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: !isCompleted ? Theme.of(context).primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "awaiting completion",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: !isCompleted ? Colors.white : Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
