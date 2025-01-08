import 'package:homework/core/locator/locator.dart';
import 'package:flutter/cupertino.dart';

abstract class AlertManager {
  void showSuccess(BuildContext context, String message, {VoidCallback? afterAlert});

  void showError(BuildContext context, String message);

  void showAlert(BuildContext context, Widget alert);

  Future<void> showSystemAlertDialog({
    required BuildContext context,
    String title = "Alert",
    String message = "Are you sure you want to proceed?",
    String confirmButtonText = "OK",
    String cancelButtonText = "Cancel",
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool isCancelable = true,
  });

/*  Future<void> comingSoonDialog({
    required BuildContext context,
    bool isCancelable = true,
  });*/
}

AlertManager alertManager = locator<AlertManager>();
