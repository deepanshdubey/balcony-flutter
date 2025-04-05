import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/core/session/app_session.dart';
import 'package:homework/router/app_router.dart';
import 'package:homework/ui/concierge/store/concierge_store.dart';
import 'package:homework/values/extensions/context_ext.dart';
import 'package:homework/values/extensions/string_ext.dart';
import 'package:homework/values/extensions/theme_ext.dart';
import 'package:homework/values/validators.dart';
import 'package:homework/widget/app_back_button.dart';
import 'package:homework/widget/app_text_field.dart';
import 'package:homework/widget/password_field.dart';
import 'package:homework/widget/primary_button.dart';
import 'package:mobx/mobx.dart';

class ConciergeSignInPage extends StatefulWidget {
  const ConciergeSignInPage({super.key});

  @override
  State<ConciergeSignInPage> createState() => _ConciergeSignInPageState();
}

class _ConciergeSignInPageState extends State<ConciergeSignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late FocusNode emailNode;
  late FocusNode passwordNode;
  List<ReactionDisposer>? disposers;
  final conciergeStore = ConciergeStore();
  int _currentIndex = 0;

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
      reaction((_) => conciergeStore.loginResponse, (response) {
        if (response != null) {
          session.isConcierge = true;
          context.router.push(const ConciergeHomeRoute());
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
    final theme = Theme.of(context);
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                child: const AppBackButton(
                  text: 'back to user login',
                ),
              ),
              10.verticalSpace,
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  margin: EdgeInsets.only(left: 12.w, right: 12.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12.r)),
                      border: Border.all(color: Colors.black.withOpacity(.25))),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTab(theme, "concierge access", 0),
                      _buildTab(theme, "maintenance access", 1),
                    ],
                  ),
                ),
              ),
              10.h.verticalSpace,
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
                      final isLoading = conciergeStore.isLoading;
                      return PrimaryButton(
                        text: "login",
                        onPressed: () {
                          if (_formKey.currentState!.validate() == true) {
                            conciergeStore.conciergeLogin({
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
                    RichText(
                      text: TextSpan(
                        style: theme.textTheme.bodyMedium,
                        children: const [
                          TextSpan(
                            text: 'side note: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          // Bold text), // Normal text
                          TextSpan(
                              text:
                                  'if you forgot your password, please reach out to the admin for password reset.'),
                          // Normal text
                        ],
                      ),
                    ),
                    16.h.verticalSpace,
                  ],
                ),
              ),
            ],
          ),
          20.h.verticalSpace,
        ],
      ),
    );
  }

  Widget _buildTab(ThemeData theme, String text, int index) {
    bool isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
            color: isActive ? theme.colors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(12.r))),
        child: Text(
          text,
          maxLines: 1,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 14.spMin,
            fontWeight: FontWeight.w500,
            color: _currentIndex == index
                ? theme.colors.backgroundColor
                : theme.colors.primaryColor,
          ),
        ),
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
