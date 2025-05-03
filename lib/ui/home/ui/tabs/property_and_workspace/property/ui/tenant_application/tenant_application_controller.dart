import 'package:flutter/material.dart';
import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/core/session/app_session.dart';
import 'package:homework/data/model/response/common_data.dart';
import 'package:homework/data/model/response/property_data.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/store/property_store.dart';
import 'package:mobx/mobx.dart';

class TenantApplicationController {
  late final PropertyData property;
  final PropertyStore propertyStore = PropertyStore();
  final formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> isAgreedNotifier = ValueNotifier(false);

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneNumberController;
  late TextEditingController emailController;
  late TextEditingController selectedUnitController;
  late TextEditingController anticipateController;
  late TextEditingController socialSecurityController;
  late TextEditingController buildingController;

  late FocusNode firstNameNode;
  late FocusNode lastNameNode;
  late FocusNode phoneNumberNode;
  late FocusNode emailNode;
  late FocusNode selectedUnitNode;
  late FocusNode socialSecurityNode;

  List<ReactionDisposer>? disposers;

  String? selectedUnit;
  String? selectedMoveInDate;

  TenantApplicationController(PropertyData propertyData) {
    property = propertyData;
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    emailController = TextEditingController();
    anticipateController = TextEditingController();
    selectedUnitController = TextEditingController();
    socialSecurityController = TextEditingController();
    buildingController = TextEditingController();

    firstNameNode = FocusNode();
    lastNameNode = FocusNode();
    phoneNumberNode = FocusNode();
    emailNode = FocusNode();
    selectedUnitNode = FocusNode();
    socialSecurityNode = FocusNode();

    firstNameController.text = session.user.firstName ?? "";
    lastNameController.text = session.user.lastName ?? "";
    phoneNumberController.text = session.user.phone ?? "";
    emailController.text = session.user.email ?? "";
    selectedUnitController.text = selectedUnit ?? "";
    buildingController.text = propertyData.info?.name ?? "Unknown";
  }

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    anticipateController.dispose();
    socialSecurityController.dispose();

    firstNameNode.dispose();
    lastNameNode.dispose();
    phoneNumberNode.dispose();
    emailNode.dispose();
    socialSecurityNode.dispose();

    removeDisposers();
  }

  void addDisposers(BuildContext context) {
    disposers ??= [
      reaction((_) => propertyStore.errorMessage, (String? error) {
        if (error != null) {
          alertManager.showError(context, error);
        }
      }),
      reaction((_) => propertyStore.applyTenantResponse,
              (CommonData? response) {
            if (response?.success ?? false) {
              alertManager.showSuccess(context, response?.message ?? "");
            }
          }),
    ];
  }

  void removeDisposers() {
    if (disposers == null) return;
    for (final d in disposers!) {
      d.reaction.dispose();
    }
  }

  void submitApplication(BuildContext context) {
    if (!isAgreedNotifier.value) {
      alertManager.showError(
          context, "Please agree to all terms and conditions");
      return;
    }
    final request = {
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "email": emailController.text,
      "phone": phoneNumberController.text,
      "selectedUnitId": selectedUnit,
      "moveInRequest": selectedMoveInDate,
      "currency": "USD",
    };
    propertyStore.applyTenant(request);
  }

  void updateApplication(BuildContext context, String tenantId) {
    if (!isAgreedNotifier.value) {
      alertManager.showError(
          context, "Please agree to all terms and conditions");
      return;
    }
    final request = {
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "email": emailController.text,
      "phone": phoneNumberController.text,
      "selectedUnitId": selectedUnit,
      "moveInRequest": selectedMoveInDate,
    };
    propertyStore.updateTenant(tenantId, request);
  }
}
