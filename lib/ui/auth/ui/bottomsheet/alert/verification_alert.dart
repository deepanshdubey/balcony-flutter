import 'dart:async';

import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/core/session/app_session.dart';
import 'package:homework/ui/auth/store/auth_store.dart';
import 'package:homework/widget/app_outlined_button.dart';
import 'package:homework/widget/app_text_field.dart';
import 'package:homework/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';

enum VerificationAlertType {
  register,
  login,
  forgotPassword,
}

class VerificationAlert extends StatefulWidget {
  final VerificationAlertType type;
  final Function() onSuccess;
  final Map<String, dynamic> apiRequest;

  const VerificationAlert(
      {super.key,
      required this.type,
      required this.onSuccess,
      required this.apiRequest});

  @override
  State<VerificationAlert> createState() => _VerificationAlertState();
}

class _VerificationAlertState extends State<VerificationAlert> {
  late Timer timer;
  int remainingTime = 60;
  final formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  List<ReactionDisposer>? disposers;
  final authStore = AuthStore();

  // Method to get the title based on the dialog type
  String _getTitle() {
    switch (widget.type) {
      case VerificationAlertType.register:
        return 'registration one-time passcode';
      case VerificationAlertType.login:
        return 'Login One-Time Passcode';
      case VerificationAlertType.forgotPassword:
        return 'password reset one-time passcode';
      default:
        return '';
    }
  }

  // Method to get the timer text
  String _getTimerText() {
    return "Resend in: $remainingTime seconds";
  }

  @override
  void initState() {
    startTimer();
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
          session.user = response.user!;
          session.isLogin = true;
          session.token = response.token! ;
          Navigator.of(context).pop();
          widget.onSuccess();
        }
      }),
      reaction((_) => authStore.registerResponse, (response) {
        if (response != null) {
          alertManager.showSuccess(context, "otp resend successfully");
          remainingTime = 60;
          startTimer();
        }
      }),
      reaction((_) => authStore.forgotPasswordResponse, (response) {
        if (response != null) {
          alertManager.showSuccess(context, "otp resend successfully");
          remainingTime = 60;
          startTimer();
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

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        _getTitle(),
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
            remainingTime == 0
                ? GestureDetector(
                    onTap: () {
                      if (widget.type == VerificationAlertType.register) {
                        authStore.register(widget.apiRequest);
                      } else {
                        authStore.forgotPassword(widget.apiRequest);
                      }
                    },
                    child: Text(
                      "resend passcode",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: 16.spMin,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : Text(
                    _getTimerText(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 14.spMin,
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
                  child: AppTextField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    label: '',
                    showLabelAboveField: false,
                    maxLength: 6,
                    validator: (otp) {
                      if (otp?.length != 6) {
                        return 'please enter passcode';
                      } else {
                        return null;
                      }
                    },
                    hintText: '******',
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
                        authStore.verifyOtp(
                            widget.type, otpController.text.trim());
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
