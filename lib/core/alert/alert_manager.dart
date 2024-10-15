import 'package:balcony/core/alert/alert_manager_impl.dart';
import 'package:balcony/core/locator/locator.dart';
import 'package:flutter/cupertino.dart';

abstract class AlertManager {
  void showSuccess(BuildContext context, String message);

  void showError(BuildContext context, String message);

  Future<void> showSystemAlertDialog({
    required BuildContext context,
    String title = "Alert",
    String message = "Are you sure you want to proceed?",
    String confirmButtonText = "OK",
    String cancelButtonText = "Cancel",
    VoidCallback? onConfirm,
    VoidCallback? onCancel = null,
    bool isCancelable = true,
  });
}

final alertManager = locator<AlertManagerImpl>();
