import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/values/extensions/theme_ext.dart';
import 'package:homework/widget/app_outlined_button.dart';
import 'package:homework/widget/primary_button.dart';
import 'package:homework/widget/top_snack_bar.dart';
import 'package:flutter/material.dart';

class AlertManagerImpl implements AlertManager {
  @override
  void showSuccess(BuildContext context, String message,
      {VoidCallback? afterAlert}) {
    _showAlert(context, message, Theme.of(context).colors.greenColor,
        afterAlert: afterAlert);
  }

  @override
  void showError(BuildContext context, String message) {
    _showAlert(context, message, Colors.redAccent);
  }

  void _showAlert(BuildContext context, String message, Color color,
      {VoidCallback? afterAlert}) {
    showAdaptiveDialog(
      useSafeArea: true,
      context: context,
      builder: (context) {
        return SafeArea(
          top: false,
          child: TopSnackBar(
            message: message,
            color: color,
            theme: Theme.of(context),
            afterAlert: afterAlert,
          ),
        );
      },
    );
  }

  @override
  Future<void> showSystemAlertDialog(
      {required BuildContext context,
      String title = "Alert",
      String message = "Are you sure you want to proceed?",
      String confirmButtonText = "OK",
      String cancelButtonText = "Cancel",
      VoidCallback? onConfirm,
      VoidCallback? onCancel,
      bool isCancelable = true}) {
    return showDialog<void>(
      context: context,
      barrierDismissible: isCancelable,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            AppOutlinedButton(
              onPressed: () {
                if (onCancel != null) onCancel();
                Navigator.of(context).pop();
              },
              text: cancelButtonText,
            ),
            PrimaryButton(
              onPressed: () {
                if (onConfirm != null) onConfirm();
                Navigator.of(context).pop();
              },
              text: confirmButtonText,
            ),
          ],
        );
      },
    );
  }

  @override
  void showAlert(BuildContext context, Widget alert) {
    showDialog(
      context: context,
      builder: (BuildContext context) => alert,
    );
  }
}
