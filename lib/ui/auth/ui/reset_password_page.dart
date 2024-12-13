import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/ui/auth/store/auth_store.dart';
import 'package:homework/ui/auth/ui/bottomsheet/alert/verification_alert.dart';
import 'package:homework/values/extensions/context_ext.dart';
import 'package:homework/values/extensions/string_ext.dart';
import 'package:homework/values/validators.dart';
import 'package:homework/widget/app_text_field.dart';
import 'package:homework/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late FocusNode emailNode;
  late FocusNode passwordNode;
  List<ReactionDisposer>? disposers;
  late Map<String, dynamic> apiRequest;
  final authStore = AuthStore();

  @override
  void initState() {
    super.initState();
    addDisposer();
    _formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailNode = FocusNode();
    passwordNode = FocusNode();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    removeDisposer();

    super.dispose();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => authStore.forgotPasswordResponse, (response) {
        if (response != null) {
          alertManager.showAlert(
              context,
              VerificationAlert(
                type: VerificationAlertType.forgotPassword,
                apiRequest: apiRequest,
                onSuccess: () {
                  alertManager.showSuccess(context, "password changed successfully");
                },
              ));
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
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: context.width,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                border: Border.all(color: Colors.black.withOpacity(.25))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                25.h.verticalSpace,
                AppTextField(
                  controller: emailController,
                  focusNode: emailNode,
                  validator: emailOrPhoneValidator.call,
                  label: 'email or phone number',
                  hintText: "email or phone number",
                  textInputAction: TextInputAction.next,
                ),
                16.h.verticalSpace,
                Observer(builder: (context) {
                  var isLoading = authStore.isLoading;
                  return PrimaryButton(
                    text: "reset password",
                    onPressed: () {
                      if (_formKey.currentState?.validate() == true) {
                        String input = emailController.text.trim();
                        bool isValidEmail = input.isValidEmail();
                        apiRequest = {
                          isValidEmail ? "email" : "phone": input,
                        };
                        authStore.forgotPassword(apiRequest);
                      }
                    },
                    isLoading: isLoading,
                  );
                }),
                16.h.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
