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
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/store/workspace_store.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/ui/create_workspace/model/amenities_item.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/ui/create_workspace/widget/available_workspace_hours_widget.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/ui/create_workspace/widget/hosting_space_widget.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/ui/create_workspace/widget/pricing_widget.dart';
import 'package:balcony/widget/app_back_button.dart';
import 'package:balcony/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';

@RoutePage()
class CreateWorkspacePage extends StatefulWidget {
  const CreateWorkspacePage({super.key});

  @override
  State<CreateWorkspacePage> createState() => _CreateWorkspacePageState();
}

class _CreateWorkspacePageState extends State<CreateWorkspacePage> {
  ThemeData get theme => Theme.of(context);

  late GlobalKey<BaseState> workspaceInfoKey;
  late GlobalKey<BaseState> pricingKey;
  late GlobalKey<BaseState> photosKey;
  late GlobalKey<BaseState> availableWorkspaceHoursKey;
  late GlobalKey<BaseState> hostingSpaceKey;
  late GlobalKey<BaseState> amenitiesKey;
  late GlobalKey<BaseState> termsOfServiceKey;
  late TextEditingController summaryController;
  final store = WorkspaceStore();
  List<ReactionDisposer>? disposers;

  @override
  void initState() {
    workspaceInfoKey = GlobalKey<BaseState>();
    pricingKey = GlobalKey<BaseState>();
    photosKey = GlobalKey<BaseState>();
    availableWorkspaceHoursKey = GlobalKey<BaseState>();
    hostingSpaceKey = GlobalKey<BaseState>();
    amenitiesKey = GlobalKey<BaseState>();
    termsOfServiceKey = GlobalKey<BaseState>();
    summaryController = TextEditingController();
    addDisposer();
    super.initState();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => store.errorMessage, (String? errorMessage) {
        if (errorMessage != null) {
          alertManager.showError(context, errorMessage);
        }
      }),
      reaction((_) => store.createWorkSpaceDetailsResponse, (res) {
        if (res != null) {
          alertManager.showSuccess(
            context,
            'workspace added successfully',
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
  void dispose() {
    workspaceInfoKey.currentState?.dispose();
    availableWorkspaceHoursKey.currentState?.dispose();
    photosKey.currentState?.dispose();
    pricingKey.currentState?.dispose();
    hostingSpaceKey.currentState?.dispose();
    termsOfServiceKey.currentState?.dispose();
    amenitiesKey.currentState?.dispose();
    summaryController.dispose();
    removeDisposer();
    super.dispose();
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
                      ),
                      30.h.verticalSpace,
                      AddressWidget(
                        key: workspaceInfoKey,
                      ),
                      30.h.verticalSpace,
                      ShortSummaryWidget(
                        formKey: GlobalKey(),
                        summaryController: summaryController,
                      ),
                      30.h.verticalSpace,
                      PricingWidget(
                        key: pricingKey,
                      ),
                      30.h.verticalSpace,
                      AvailableWorkspaceHoursWidget(
                        key: availableWorkspaceHoursKey,
                      ),
                      30.h.verticalSpace,
                      HostingSpaceWidget(
                        key: hostingSpaceKey,
                      ),
                      30.h.verticalSpace,
                      AmenitiesWidget(
                          key: amenitiesKey, amenities: AmenitiesItem.preset()),
                      divider(),
                      TermsOfServiceWidget(
                        key: termsOfServiceKey,
                      ),
                      30.h.verticalSpace,
                      Observer(builder: (context) {
                        var isLoading = store.isLoading;
                        return PrimaryButton(
                          text: "add new workspace",
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
      Info info = workspaceInfoKey.currentState!.getApiData();
      info.summary = summaryController.text.trim();
      store.createWorkSpace(
        photosKey.currentState!.getApiData(),
        info,
        pricingKey.currentState!.getApiData(),
        availableWorkspaceHoursKey.currentState?.getApiData()!,
        Other(
          additionalGuests: pricingKey.currentState!.additionalGuests(),
          isCoWorkingWorkspace:
              hostingSpaceKey.currentState!.isWorkspaceStyle(),
          isIndoorSpace: hostingSpaceKey.currentState!.isIndoor(),
          isOutdoorSpace: hostingSpaceKey.currentState!.isOutdoor(),
        ),
        amenitiesKey.currentState!.getApiData(),
      );
    }
  }

  bool validate() {
    for (var element in [
      photosKey,
      workspaceInfoKey,
      pricingKey,
      availableWorkspaceHoursKey,
      hostingSpaceKey,
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