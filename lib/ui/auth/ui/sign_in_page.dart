import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/core/session/app_session.dart';
import 'package:homework/ui/auth/store/auth_store.dart';
import 'package:homework/values/extensions/context_ext.dart';
import 'package:homework/values/extensions/string_ext.dart';
import 'package:homework/values/extensions/theme_ext.dart';
import 'package:homework/values/validators.dart';
import 'package:homework/widget/app_image.dart';
import 'package:homework/widget/app_text_field.dart';
import 'package:homework/widget/password_field.dart';
import 'package:homework/widget/primary_button.dart';
import 'package:mobx/mobx.dart';

class SignInPage extends StatefulWidget {
  final VoidCallback onSuccess;

  const SignInPage({super.key, required this.onSuccess});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late GlobalKey<FormState> _formKey = GlobalKey();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late FocusNode emailNode;
  late FocusNode passwordNode;
  List<ReactionDisposer>? disposers;
  final authStore = AuthStore();

  @override
  void initState() {
    addDisposer();
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailNode = FocusNode();
    passwordNode = FocusNode();
  }

  @override
  void dispose() {
    removeDisposer();
    emailController.dispose();
    passwordController.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    super.dispose();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => authStore.loginResponse, (response) {
        if (response != null) {
          session.isLogin = true;
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
    return Form(
      key: _formKey,
      child: ListView(
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
                16.h.verticalSpace,
                AppTextField(
                  controller: emailController,
                  focusNode: emailNode,
                  validator: emailOrPhoneValidator.call,
                  label: 'email or phone number',
                  hintText: "email or phone number",
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                16.h.verticalSpace,
                PasswordField(
                  controller: passwordController,
                  focusNode: passwordNode,
                  validator: passwordValidator.call,
                  label: 'password',
                  hintText: 'password',
                ),
                10.h.verticalSpace,
                Observer(builder: (context) {
                  final isLoading = authStore.isLoading;
                  return PrimaryButton(
                    text: "login",
                    onPressed: () {
                      if (_formKey.currentState!.validate() == true) {
                        authStore.login({
                          emailController.text.trim().isValidEmail()
                              ? "email"
                              : "phone": emailController.text.trim(),
                          "password": passwordController.text.trim(),
                        });
                      }
                    },
                    isLoading: isLoading,
                  );
                }),
                16.h.verticalSpace,
              ],
            ),
          ),
          20.h.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Container(
                color: theme.colors.primaryColor,
                height: 1.w,
                margin: EdgeInsets.all(
                  16.r,
                ),
              )),
              Text(
                "OR CONTINUE WITH",
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 14.spMin,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Expanded(
                  child: Container(
                color: theme.colors.primaryColor,
                height: 1.w,
                margin: EdgeInsets.all(
                  16.r,
                ),
              )),
            ],
          ),
          25.h.verticalSpace,
          Row(
            children: [
              20.w.horizontalSpace,
              socialButton(
                theme,
                image: theme.assets.facebook,
                text: "facebook",
                onPressed: () {
                  alertManager.showError(context, "under development");
                },
              ),
              10.w.horizontalSpace,
              socialButton(
                theme,
                image: theme.assets.google,
                text: "google",
                onPressed: () {
                  authStore.socialAuth();
                },
              ),
              20.w.horizontalSpace,
            ],
          )
        ],
      ),
    );
  }

  Widget socialButton(ThemeData theme,
      {required String image,
      required String text,
      required VoidCallback onPressed}) {
    return Expanded(
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            backgroundColor: Colors.transparent,
            side: BorderSide(color: Theme.of(context).colors.strokeColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            )),
        icon: AppImage(
          assetPath: image,
          height: 16.r,
          width: 16.r,
        ),
        onPressed: onPressed,
        label: Text(
          text,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 14.spMin,
          ),
        ),
      ),
    );
  }
}
