import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/ui/auth/store/auth_store.dart';
import 'package:homework/values/validators.dart';
import 'package:homework/widget/app_outlined_button.dart';
import 'package:homework/widget/password_field.dart';
import 'package:homework/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';

class UpdatePasswordAlert extends StatefulWidget {
  final Function() onSuccess;

  const UpdatePasswordAlert({
    super.key,
    required this.onSuccess,
  });

  @override
  State<UpdatePasswordAlert> createState() => _UpdatePasswordAlertState();
}

class _UpdatePasswordAlertState extends State<UpdatePasswordAlert> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  List<ReactionDisposer>? disposers;
  final authStore = AuthStore();

  @override
  void initState() {
    addDisposer();
    super.initState();
  }

  @override
  void dispose() {
    removeDisposer();
    super.dispose();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => authStore.verificationResponse, (response) {
        if (response != null) {
          Navigator.of(context).pop();
          widget.onSuccess();
        }
      }),
      reaction((_) => authStore.errorMessage, (String? errorMessage) {
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
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        "enter new password",
        style: theme.textTheme.titleLarge?.copyWith(
          fontSize: 18.spMin,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "please enter new password",
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 16.spMin,
                fontWeight: FontWeight.w500,
              ),
            ),
            16.h.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: Text(
                    "passcode",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.spMin,
                    ),
                  ),
                ),
                16.w.horizontalSpace,
                Expanded(
                  child: PasswordField(
                    controller: passwordController,
                    validator: passwordValidator.call,
                    label: 'password',
                    hintText: 'password',
                    showLabelAboveField: false,
                  ),
                ),
                16.w.horizontalSpace,
              ],
            ),
            16.h.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppOutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  text: "cancel",
                ),
                8.w.horizontalSpace,
                Observer(builder: (context) {
                  final isLoading = authStore.isLoading;
                  return PrimaryButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() == true) {
                        authStore.updatePassword(passwordController.text.trim());
                      }
                    },
                    text: 'continue',
                    isLoading: isLoading,
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
