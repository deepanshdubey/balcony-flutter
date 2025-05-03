import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/core/session/app_session.dart';
import 'package:homework/data/model/response/property_data.dart';
import 'package:homework/data/model/response/tenant_details.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/widget/terms_of_service_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/ui/tenant_application/additional_note_for_host_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/ui/tenant_application/credit_report_check_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/ui/tenant_application/default_card_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/ui/tenant_application/emergency_contact_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/ui/tenant_application/employement_details_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/ui/tenant_application/personal_document_widget.dart'
    show PersonalDocumentWidget;
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/ui/tenant_application/residential_info_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/ui/tenant_application/store/tenant_application_store.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/ui/tenant_application/tenant_application_controller.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/ui/tenant_application/tenant_application_form.dart';
import 'package:homework/values/colors.dart';
import 'package:homework/widget/app_back_button.dart';
import 'package:homework/widget/primary_button.dart';

class TenantApplicationPage extends StatefulWidget {
  final PropertyData? propertyData;
  final Tenants? tenant;
  final bool isUpdate;

  const TenantApplicationPage({
    super.key,
    this.propertyData,
    this.tenant,
    this.isUpdate = false,
  });

  @override
  State<TenantApplicationPage> createState() => _TenantApplicationPageState();
}

class _TenantApplicationPageState extends State<TenantApplicationPage> {
  late final TenantApplicationController controller;
  late TenantApplicationStore _store;

  @override
  void initState() {
    super.initState();
    controller = TenantApplicationController(widget.propertyData!);
    controller.addDisposers(context);
    _store = TenantApplicationStore(propertyId: widget.propertyData!.id!);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onSubmit() {
    if (widget.isUpdate) {
      controller.updateApplication(context, widget.tenant?.Id ?? "");
    } else {
      controller.submitApplication(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Scaffold(
          body: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  20.h.verticalSpace,
                  Text(
                    "hello ${session.user.firstName} we need a few information about you.",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 28.spMin,
                          fontWeight: FontWeight.w600,
                          color: appColor.primaryColor,
                        ),
                  ),
                  16.h.verticalSpace,
                  TenantApplicationForm(
                    controller: controller,
                    propertyData: widget.propertyData,
                    tenant: widget.tenant,
                    isUpdate: widget.isUpdate,
                  ),
                  16.verticalSpace,
                  AdditionalNoteForHostWidget(
                      noteController: TextEditingController()),
                  16.verticalSpace,
                  const CreditReportCheckWidget(),
                  16.verticalSpace,
                  const ResidentialInfoWidget(),
                  16.verticalSpace,
                  const EmploymentDetailsWidget(),
                  16.verticalSpace,
                  const EmergencyContactWidget(),
                  16.verticalSpace,
                  const PersonalDocumentWidget(),
                  16.verticalSpace,
                  const TermsOfServiceWidget(
                    isEdit: false,
                    showLeasingPolicy: true,
                  ),
                  16.verticalSpace,
                  const DefaultCardWidget(),
                  16.verticalSpace,
                  _applicationFeeTotal(),
                  16.verticalSpace,
                  _submitApplication(),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20.w),
          color: Colors.white,
          child: const AppBackButton(),
        ),
      ],
    );
  }

  Widget _applicationFeeTotal() {
    return Observer(builder: (context) {
      var isLoading = _store.isLoadingApplicationFee;
      var applicationFee = _store.applicationFeeResponse;
      return Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "application fee total",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : Text(
                    "\$$applicationFee",
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
          ),
        ],
      );
    });
  }

  Widget _submitApplication() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PrimaryButton(
          text: "pay & submit application",
          onPressed: () {},
        ),
        2.h.verticalSpace,
        Text(
          "**Note: If application is approved by property manager then you will be prompted to next step(s) which is usually agreement & first month rent & security",
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontSize: 8.spMin),
        )
      ],
    );
  }
}
