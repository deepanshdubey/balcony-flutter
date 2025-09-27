import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/core/session/app_session.dart';
import 'package:homework/generated/assets.dart';
import 'package:homework/router/app_router.dart';
import 'package:homework/ui/auth/store/auth_store.dart';
import 'package:homework/values/extensions/context_ext.dart';
import 'package:homework/values/validators.dart';
import 'package:homework/widget/app_back_button.dart';
import 'package:homework/widget/app_image.dart';
import 'package:homework/widget/app_text_field.dart';
import 'package:homework/widget/image_picker_widget.dart';
import 'package:homework/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  bool firstName = true, lastName = true, email = true, phone = true;
  late FocusNode firstNameNode;
  late FocusNode lastNameNode;
  late FocusNode emailNode;
  late FocusNode phoneNode;
  List<ReactionDisposer>? disposers;
  final authStore = AuthStore();
  String? imagePath;

  @override
  void initState() {
    var user = session.user;
    _formKey = GlobalKey<FormState>();
    firstNameController = TextEditingController(text: user.firstName ?? "");
    lastNameController = TextEditingController(text: user.lastName ?? "");
    emailController = TextEditingController(text: user.email ?? "");
    phoneController = TextEditingController(text: user.phone ?? "");
    firstNameNode = FocusNode();
    lastNameNode = FocusNode();
    emailNode = FocusNode();
    phoneNode = FocusNode();
    addDisposer();
    super.initState();
  }

  @override
  void dispose() {
    removeDisposer();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    firstNameNode.dispose();
    lastNameNode.dispose();
    emailNode.dispose();
    phoneNode.dispose();
    super.dispose();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => authStore.updateProfileResponse, (response) {
        if (response != null) {
          alertManager.showSuccess(context, "profile updated successfully");
        }
      }),
      reaction((_) => authStore.errorMessage, (String? errorMessage) {
        if (errorMessage != null) {
          alertManager.showError(context, errorMessage);
        }
      }),
      reaction((_) => authStore.deleteAccountResponse, (response) {
        if (response?.success ?? false) {
          session.logout();
          context.router.replaceAll([StartRoute()]);
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
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCustomAppBar(context),
          32.h.verticalSpace,
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              children: [
                _addProfilePic(theme),
                12.h.verticalSpace,
                _editProfileForm(theme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        20.w.horizontalSpace,
        AppBackButton(
          text: "back to menu",
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget _addProfilePic(ThemeData theme) {
    return ImagePickerWidget(
      onImageSelected: (path) {
        setState(() {
          imagePath = path;
        });
      },
      child: Row(
        children: [
          AppImage(
            radius: 25.r,
            file: imagePath,
            url: imagePath == null ? session.user.image : null,
            boxFit: BoxFit.cover,
            assetPath: Assets.imagesProfilePlaceholder,
          ),
          12.w.horizontalSpace,
          Text(
            "${imagePath == null ? "add" : "update"} profile image",
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 15.spMin,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _editProfileForm(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: context.width,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
              border: Border.all(color: Colors.black.withOpacity(.25))),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                12.h.verticalSpace,
                editableField(
                  theme,
                  onChanged: () {
                    setState(() {
                      firstName = false;
                    });
                  },
                  child: AppTextField(
                    controller: firstNameController,
                    focusNode: firstNameNode,
                    validator: firstNameValidator.call,
                    label: 'first name',
                    hintText: 'first name',
                    readOnly: firstName,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                12.h.verticalSpace,
                editableField(
                  theme,
                  onChanged: () {
                    setState(() {
                      lastName = false;
                    });
                  },
                  child: AppTextField(
                    controller: lastNameController,
                    focusNode: lastNameNode,
                    validator: lastNameValidator.call,
                    label: 'last name',
                    hintText: 'last name',
                    readOnly: lastName,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                12.h.verticalSpace,
                editableField(
                  theme,
                  onChanged: () {
                    setState(() {
                      email = false;
                    });
                  },
                  child: AppTextField(
                    controller: emailController,
                    focusNode: emailNode,
                    validator: emailValidator.call,
                    label: 'email',
                    readOnly: email,
                    hintText: 'name@email.com',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                12.h.verticalSpace,
                editableField(
                  theme,
                  onChanged: () {
                    setState(() {
                      phone = false;
                    });
                  },
                  child: AppTextField(
                    controller: phoneController,
                    focusNode: phoneNode,
                    keyboardType: TextInputType.number,
                    validator: phoneValidator.call,
                    label: 'phone',
                    hintText: '###-###-####',
                    readOnly: phone,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                10.h.verticalSpace,
                Observer(builder: (context) {
                  var isLoading = authStore.isLoading;
                  return PrimaryButton(
                    isLoading: isLoading,
                    text: "update profile",
                    onPressed: () async {
                      if (_formKey.currentState?.validate() == true) {
                        if (imagePath != null) {
                          authStore.updateProfileWithImage(
                              firstNameController.text.trim(),
                              lastNameController.text.trim(),
                              emailController.text.trim(),
                              phoneController.text.trim(),
                              File(imagePath!));
                        } else {
                          var apiRequest = {
                            "firstName": firstNameController.text.trim(),
                            "lastName": lastNameController.text.trim(),
                            "email": emailController.text.trim(),
                            "phone": phoneController.text.trim(),
                            "image": session.user.image,
                          };
                          authStore.updateProfile(apiRequest);
                        }
                      }
                    },
                  );
                }),
                12.h.verticalSpace,
              ],
            ),
          ),
        ),
        30.verticalSpace,
        PrimaryButton(
          //  isLoading: isLoading,
          text: "Delete profile",
          onPressed: showDeleteAccountDialog,
        ),
        30.verticalSpace
      ],
    );
  }

  Widget editableField(ThemeData theme,
      {required Widget child, VoidCallback? onChanged}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: child),
        4.w.horizontalSpace,
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: TextButton(
            onPressed: onChanged,
            child: Text(
              "edit",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 15.spMin,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        )
      ],
    );
  }

  void showDeleteAccountDialog() {

    String? selectedReason;
    List<String> reasons = [
      "I no longer need this account",
      "I have multiple accounts and want to delete this one",
      "I am concerned about my privacy and data",
      "I don’t find the app useful anymore",
      "I am facing technical issues with the app",
      "I am switching to another service",
      "I created this account by mistake",
      "My account was hacked or compromised",
      "Other (please specify in the textbox)"
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Observer(builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            title: Text(
              "Are you sure you want to delete?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Reason for deleting your account:",
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(height: 8.0),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                  ),
                  isExpanded: true,
                  hint: Text("Select a reason"),
                  items: reasons.map((String reason) {
                    return DropdownMenuItem<String>(
                      value: reason,
                      child: Text(
                        reason,
                        maxLines: 2,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedReason = value;
                  },
                ),
                TextButton(
                    onPressed: () {
                      context.router.push(WebViewRoute(
                          url: "https://homework.ws/delete-account",
                          title: "Account deletion policy"));
                    },
                    child: Text(
                      "Account Deletion Policy",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ))
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              PrimaryButton(
                isLoading: authStore.isLoading,
                text: 'Continue',
                onPressed: () {
                  var data = {"reason": selectedReason};
                  authStore.deleteAccount(data);
                },
              ),
            ],
          );
        });
      },
    );
  }
}

/*
class DeleteAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Delete Account")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "We're sorry to see you go! If you wish to delete your account, please read the following information carefully before proceeding.",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 20),
              _buildSectionHeader(Icons.info, "Important Information About Account Deletion"),
              const SizedBox(height: 10),
              _buildBulletPoint("Your account will be deleted immediately upon request."),
              _buildBulletPoint("All your data will be permanently removed from our servers within 30 days."),
              _buildBulletPoint("If you have any ongoing services, active subscriptions, or pending transactions, please resolve them before requesting deletion."),
              _buildBulletPoint("You will receive email updates regarding the status of your request."),
              const SizedBox(height: 20),
              _buildSectionHeader(Icons.delete, "Before You Delete Your Account"),
              _buildBulletPoint("If you're facing issues, consider reaching out to our Support Team."),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: Colors.black87),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 18)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}


*/
