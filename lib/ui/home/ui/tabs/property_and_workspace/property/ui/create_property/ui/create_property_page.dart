import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:balcony/core/alert/alert_manager.dart';
import 'package:balcony/data/model/response/workspace_data.dart';
import 'package:balcony/router/app_router.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/common/base_state.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/common/widget/address_widget.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/common/widget/amenities_widget.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/common/widget/photos_widget.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/common/widget/short_summary_widget.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/common/widget/terms_of_service_widget.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/property/store/property_store.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/property/ui/create_property/widget/lease_duration_widget.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/property/ui/create_property/widget/lease_terms_and_policy_widget.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/property/ui/create_property/widget/processing_fee_widget.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/property/ui/create_property/widget/unit_list_widget.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/ui/create_workspace/model/amenities_item.dart';
import 'package:balcony/widget/app_back_button.dart';
import 'package:balcony/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';

@RoutePage()
class CreatePropertyPage extends StatefulWidget {
  const CreatePropertyPage({super.key});

  @override
  State<CreatePropertyPage> createState() => _CreatePropertyPageState();
}

class _CreatePropertyPageState extends State<CreatePropertyPage> {
  ThemeData get theme => Theme.of(context);

  late GlobalKey<BaseState> propertyAddressKey;
  late GlobalKey<BaseState> processingFeeKey;
  late GlobalKey<BaseState> photosKey;
  late GlobalKey<BaseState> unitListKey;
  late GlobalKey<BaseState> leasingTermsKey;
  late GlobalKey<BaseState> amenitiesKey;
  late GlobalKey<BaseState> termsOfServiceKey;
  late TextEditingController summaryController;
  double? leaseDuration;
  final store = PropertyStore();
  List<ReactionDisposer>? disposers;

  @override
  void initState() {
    propertyAddressKey = GlobalKey<BaseState>();
    processingFeeKey = GlobalKey<BaseState>();
    photosKey = GlobalKey<BaseState>();
    unitListKey = GlobalKey<BaseState>();
    leasingTermsKey = GlobalKey<BaseState>();
    amenitiesKey = GlobalKey<BaseState>();
    termsOfServiceKey = GlobalKey<BaseState>();
    summaryController = TextEditingController();
    addDisposer();
    super.initState();
  }

  @override
  void dispose() {
    propertyAddressKey.currentState?.dispose();
    unitListKey.currentState?.dispose();
    photosKey.currentState?.dispose();
    processingFeeKey.currentState?.dispose();
    leasingTermsKey.currentState?.dispose();
    termsOfServiceKey.currentState?.dispose();
    amenitiesKey.currentState?.dispose();
    summaryController.dispose();
    removeDisposer();
    super.dispose();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => store.errorMessage, (String? errorMessage) {
        if (errorMessage != null) {
          alertManager.showError(context, errorMessage);
        }
      }),
      reaction((_) => store.createPropertyResponse, (res) {
        if (res != null) {
          alertManager.showSuccess(
            context,
            'property added successfully',
            afterAlert: () {
              appRouter.back();
            },
          );
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
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: const AppBackButton(
                  text: "back",
                )),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                  child: Column(
                    children: [
                      title(),
                      divider(),
                      PhotosWidget(
                        key: photosKey,
                        isWorkspace: false,
                      ),
                      30.h.verticalSpace,
                      AddressWidget(
                        key: propertyAddressKey,
                        isWorkSpace: false,
                      ),
                      30.h.verticalSpace,
                      ProcessingFeeWidget(
                        key: processingFeeKey,
                      ),
                      30.h.verticalSpace,
                      UnitListWidget(
                        key: unitListKey,
                      ),
                      30.h.verticalSpace,
                      ShortSummaryWidget(
                        formKey: GlobalKey(),
                        summaryController: summaryController,
                        isWorkspace: false,
                      ),
                      30.h.verticalSpace,
                      LeaseDurationWidget(
                        onLeaseDurationUpdated: (duration) {
                          leaseDuration = duration;
                        },
                      ),
                      30.h.verticalSpace,
                      AmenitiesWidget(
                        key: amenitiesKey,
                        isWorkspace: false,
                        amenities: AmenitiesItem.preset(),
                      ),
                      30.h.verticalSpace,
                      LeaseTermsAndPolicyWidget(
                        key: leasingTermsKey,
                      ),
                      divider(),
                      TermsOfServiceWidget(
                        key: termsOfServiceKey,
                      ),
                      30.h.verticalSpace,
                      Observer(builder: (context) {
                        var isLoading = store.isLoading;
                        return PrimaryButton(
                          text: "add new property",
                          onPressed: submit,
                          isLoading: isLoading,
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget title() {
    return Text(
      "we need a few information about your property.",
      style: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 28.spMin,
      ),
    );
  }

  Widget divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 24.h),
      height: 1.h,
      color: theme.primaryColor,
    );
  }

  void scrollTo(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
    );
  }

  void submit() {
    if (validate()) {
      Map<String, dynamic> unitData = unitListKey.currentState!.getApiData();
      List<File> floorPlanImages = unitData['floor_plan_images'];
      String currency = unitData['currency'];
      List<Map<String, dynamic>> units = unitData['units'];
      Info info = propertyAddressKey.currentState!.getApiData();
      info.summary = summaryController.text.trim();
      bool other = processingFeeKey.currentState!.getApiData();

      store.createProperty(
        photosKey.currentState!.getApiData(),
        floorPlanImages,
        info,
        currency,
        {
          "chargeFeeFromRent": other,
          "chargeFeeAsAddition": !other,
          "leaseDuration": leaseDuration
        },
        amenitiesKey.currentState!.getApiData(),
        leasingTermsKey.currentState!.getApiData(),
        units,
      );
    }
  }

  bool validate() {
    for (var element in [
      photosKey,
      propertyAddressKey,
      processingFeeKey,
      unitListKey,
      leasingTermsKey,
      termsOfServiceKey,
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
}
