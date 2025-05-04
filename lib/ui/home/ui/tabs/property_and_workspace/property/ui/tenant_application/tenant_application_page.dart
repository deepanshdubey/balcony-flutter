import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/core/session/app_session.dart';
import 'package:homework/data/model/response/property_data.dart';
import 'package:homework/data/model/response/tenant_details.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/base_state.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/widget/terms_of_service_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/ui/tenant_application/additional_note_for_host_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/ui/tenant_application/credit_report_check_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/ui/tenant_application/default_card_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/ui/tenant_application/emergency_contact_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/ui/tenant_application/employement_details_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/ui/tenant_application/personal_document_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/ui/tenant_application/residential_info_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/ui/tenant_application/store/tenant_application_store.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/ui/tenant_application/tenant_application_form.dart';
import 'package:homework/values/colors.dart';
import 'package:homework/values/extensions/map_ext.dart';
import 'package:homework/widget/app_back_button.dart';
import 'package:homework/widget/primary_button.dart';
import 'package:mobx/mobx.dart';

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
  late TenantApplicationStore _store;
  List<ReactionDisposer>? _disposers;
  late GlobalKey<BaseState> _tenantApplicationFormKey;
  late GlobalKey<BaseState> _additionalNoteKey;
  late GlobalKey<BaseState> _creditReportCheckKey;
  late GlobalKey<BaseState> _residentialHistoryKey;
  late GlobalKey<BaseState> _employmentDetailsKey;
  late GlobalKey<BaseState> _emergencyContactKey;
  late GlobalKey<BaseState> _termsKey;

  @override
  void initState() {
    super.initState();
    _store = TenantApplicationStore(propertyId: widget.propertyData!.id!);
    _tenantApplicationFormKey = GlobalKey<BaseState>();
    _additionalNoteKey = GlobalKey<BaseState>();
    _creditReportCheckKey = GlobalKey<BaseState>();
    _residentialHistoryKey = GlobalKey<BaseState>();
    _employmentDetailsKey = GlobalKey<BaseState>();
    _emergencyContactKey = GlobalKey<BaseState>();
    _termsKey = GlobalKey<BaseState>();
    _addDisposers();
  }

  void _addDisposers() {
    _disposers ??= [
      reaction((_) => _store.errorMessage, (String? error) {
        if (error != null) {
          alertManager.showError(context, error);
        }
      }),
      reaction((_) => _store.applyTenantResponse, (response) {
        if (response?.success ?? false) {
          alertManager.showSuccess(context, response?.message ?? "");
        }
      }),
    ];
  }

  void _removeDisposers() {
    if (_disposers == null) return;
    for (final d in _disposers!) {
      d.reaction.dispose();
    }
  }

  @override
  void dispose() {
    _removeDisposers();
    _tenantApplicationFormKey.currentState?.dispose();
    _additionalNoteKey.currentState?.dispose();
    _creditReportCheckKey.currentState?.dispose();
    _residentialHistoryKey.currentState?.dispose();
    _employmentDetailsKey.currentState?.dispose();
    _emergencyContactKey.currentState?.dispose();
    _termsKey.currentState?.dispose();

    super.dispose();
  }

  void onSubmit() {
    if (validate()) {
      var request = {
        ..._tenantApplicationFormKey.currentState!.getApiData(),
        "note": _additionalNoteKey.currentState!.getApiData(),
        "currency": "USD",
        ...(_creditReportCheckKey.currentState?.getApiData() ?? {}),
        ...(_employmentDetailsKey.currentState?.getApiData() ?? {}),
        "residentialHistories":
            (_residentialHistoryKey.currentState?.getApiData() ?? {}),
        "emergencyContacts":
            (_emergencyContactKey.currentState?.getApiData() ?? {}),
        "additionalPeople": [
          {
            "firstName": "John",
            "lastName": "Smith",
            "email": "john.smith@example.com"
          }
        ],
        "isCompleted": true,
        "docs": [
          "https://example.com/doc1.pdf",
          "https://example.com/doc2.pdf"
        ],
      }.dropNull();
      _store.applyForTenancy(request);
    }
  }

  bool validate() {
    for (var element in [
      _tenantApplicationFormKey,
      _additionalNoteKey,
      _creditReportCheckKey,
      _residentialHistoryKey,
      _employmentDetailsKey,
      _emergencyContactKey,
      _termsKey,
    ]) {
      if (!validateAndScrollTo(element)) {
        return false;
      }
    }
    return true;
  }

  bool validateAndScrollTo(GlobalKey<BaseState> key) {
    if (key.currentState?.validate() != true) {
      String? error = key.currentState?.getError();
      if (error != null) {
        alertManager.showError(context, error);
      }
      scrollTo(key);
      return false;
    }
    return true;
  }

  void scrollTo(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Scaffold(
          body: SingleChildScrollView(
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
                  key: _tenantApplicationFormKey,
                  propertyData: widget.propertyData,
                  tenant: widget.tenant,
                  isUpdate: widget.isUpdate,
                ),
                16.verticalSpace,
                AdditionalNoteForHostWidget(
                  key: _additionalNoteKey,
                ),
                16.verticalSpace,
                CreditReportCheckWidget(
                  key: _creditReportCheckKey,
                ),
                16.verticalSpace,
                ResidentialInfoWidget(
                  key: _residentialHistoryKey,
                ),
                16.verticalSpace,
                EmploymentDetailsWidget(key: _employmentDetailsKey),
                16.verticalSpace,
                EmergencyContactWidget(
                  key: _emergencyContactKey,
                ),
                16.verticalSpace,
                const PersonalDocumentWidget(),
                16.verticalSpace,
                TermsOfServiceWidget(
                  isEdit: false,
                  showLeasingPolicy: true,
                  key: _termsKey,
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
                ? const Center(child: CircularProgressIndicator())
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
    return Observer(builder: (context) {
      var isLoading = _store.isApplyingForTenancy;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PrimaryButton(
            isLoading: isLoading,
            enabled: !_store.isLoadingApplicationFee,
            text: "pay & submit application",
            onPressed: onSubmit,
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
    });
  }
}
