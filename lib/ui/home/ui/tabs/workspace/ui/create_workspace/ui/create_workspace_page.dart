import 'package:auto_route/annotations.dart';
import 'package:balcony/ui/home/ui/tabs/workspace/ui/create_workspace/model/amenities_item.dart';
import 'package:balcony/ui/home/ui/tabs/workspace/ui/create_workspace/widget/available_workspace_hours_widget.dart';
import 'package:balcony/ui/home/ui/tabs/workspace/ui/create_workspace/widget/pricing_widget.dart';
import 'package:balcony/ui/home/ui/tabs/workspace/ui/create_workspace/widget/short_summary_widget.dart';
import 'package:balcony/ui/home/ui/tabs/workspace/ui/create_workspace/widget/terms_of_service_widget.dart';
import 'package:balcony/ui/home/ui/tabs/workspace/ui/create_workspace/widget/workspace_amenities_widget.dart';
import 'package:balcony/ui/home/ui/tabs/workspace/ui/create_workspace/widget/workspace_info_widget.dart';
import 'package:balcony/ui/home/ui/tabs/workspace/ui/create_workspace/widget/workspace_photos_widget.dart';
import 'package:balcony/values/extensions/context_ext.dart';
import 'package:balcony/widget/app_back_button.dart';
import 'package:balcony/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class CreateWorkspacePage extends StatefulWidget {
  const CreateWorkspacePage({super.key});

  @override
  State<CreateWorkspacePage> createState() => _CreateWorkspacePageState();
}

class _CreateWorkspacePageState extends State<CreateWorkspacePage> {
  ThemeData get theme => Theme.of(context);

  late GlobalKey<FormState> workspaceInfoKey;
  late GlobalKey<FormState> pricingKey;
  late TextEditingController workspaceNameController;
  late TextEditingController floorController;
  late TextEditingController addressController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController countryController;
  late TextEditingController summaryController;
  late TextEditingController currencyController;
  late TextEditingController totalPerDayController;
  late TextEditingController additionalGuestsController;
  late TextEditingController cleaningFeeController;
  late TextEditingController cleaningFeeTypeController;
  late TextEditingController maintenanceFeeController;
  late TextEditingController maintenanceFeeTypeController;
  late TextEditingController additionalGeneralFeeController;
  late TextEditingController additionalGeneralFeeTypeController;
  bool hostingSpaceIndoor = false,
      hostingSpaceOutdoor = false,
      workspaceStyle = false;

  @override
  void initState() {
    workspaceInfoKey = GlobalKey<FormState>();
    pricingKey = GlobalKey<FormState>();
    workspaceNameController = TextEditingController();
    floorController = TextEditingController();
    addressController = TextEditingController();
    cityController = TextEditingController();
    stateController = TextEditingController();
    countryController = TextEditingController();
    summaryController = TextEditingController();
    currencyController = TextEditingController(text: "USD");
    totalPerDayController = TextEditingController();
    additionalGuestsController = TextEditingController();
    cleaningFeeController = TextEditingController();
    cleaningFeeTypeController = TextEditingController();
    maintenanceFeeController = TextEditingController();
    maintenanceFeeTypeController = TextEditingController();
    additionalGeneralFeeController = TextEditingController();
    additionalGeneralFeeTypeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    workspaceInfoKey.currentState?.dispose();
    workspaceNameController.dispose();
    floorController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
    summaryController.dispose();
    currencyController.dispose();
    totalPerDayController.dispose();
    additionalGuestsController.dispose();
    cleaningFeeController.dispose();
    cleaningFeeTypeController.dispose();
    maintenanceFeeController.dispose();
    maintenanceFeeTypeController.dispose();
    additionalGeneralFeeController.dispose();
    additionalGeneralFeeTypeController.dispose();
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
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                children: [
                  title(),
                  divider(),
                  const WorkspacePhotosWidget(),
                  30.h.verticalSpace,
                  WorkspaceInfoWidget(
                    formKey: workspaceInfoKey,
                    workspaceNameController: workspaceNameController,
                    floorController: floorController,
                    addressController: addressController,
                    cityController: cityController,
                    stateController: stateController,
                    countryController: countryController,
                  ),
                  30.h.verticalSpace,
                  ShortSummaryWidget(
                    formKey: GlobalKey(),
                    summaryController: summaryController,
                  ),
                  30.h.verticalSpace,
                  PricingWidget(
                    formKey: pricingKey,
                    currencyController: currencyController,
                    totalPerDayController: totalPerDayController,
                    additionalGuestsController: additionalGuestsController,
                    cleaningFeeController: cleaningFeeController,
                    cleaningFeeTypeController: cleaningFeeTypeController,
                    maintenanceFeeController: maintenanceFeeController,
                    maintenanceFeeTypeController: maintenanceFeeTypeController,
                    additionalGeneralFeeController:
                        additionalGeneralFeeController,
                    additionalGeneralFeeTypeController:
                        additionalGeneralFeeTypeController,
                  ),
                  30.h.verticalSpace,
                  const AvailableWorkspaceHoursWidget(),
                  30.h.verticalSpace,
                  hostingSpaceWidget(),
                  30.h.verticalSpace,
                  WorkspaceAmenitiesWidget(amenities: AmenitiesItem.preset()),
                  divider(),
                  const TermsOfServiceWidget(),
                  30.h.verticalSpace,
                  PrimaryButton(text: "add new workspace", onPressed: submit),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget title() {
    return Text(
      "we need a few information about your workspace.",
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

  Widget hostingSpaceWidget() {
    return StatefulBuilder(
      builder: (context, innerSetState) => Container(
        width: context.width,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(.25))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.h.verticalSpace,
            Text(
              "hosting space*",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 24.spMin,
                  ),
            ),
            16.h.verticalSpace,
            Row(
              children: [
                Checkbox(
                  value: hostingSpaceIndoor,
                  onChanged: (value) {
                    setState(
                        () => hostingSpaceIndoor = value ?? hostingSpaceIndoor);
                  },
                ),
                Expanded(
                  child: Text(
                    "indoor (ex: office, dining area, great room, etc.)",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: hostingSpaceOutdoor,
                  onChanged: (value) {
                    setState(() =>
                        hostingSpaceOutdoor = value ?? hostingSpaceOutdoor);
                  },
                ),
                Expanded(
                  child: Text(
                    "outdoor (ex: backyard, patio, terrace, homework, etc. )",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(),
                  ),
                ),
              ],
            ),
            16.h.verticalSpace,
            Text(
              "workspace style",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 24.spMin,
                  ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: workspaceStyle,
                  onChanged: (value) {
                    setState(() => workspaceStyle = value ?? workspaceStyle);
                  },
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        """co-working workspaces would be shared by multiple people within the same date & time frame.""",
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '  •  ',
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(),
                          ),
                          Expanded(
                            child: Text(
                              """if not checked, then only one user can book the workspace for a date/time at a time. Its highly advised that this is checked so multiple people can take advantage of the workspace specially if coworking is offered.""",
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            16.h.verticalSpace,
          ],
        ),
      ),
    );
  }

  void submit() {
    if (validate()) {
      //call api
    }
  }

  bool validate() {
    if (workspaceInfoKey.currentState?.validate() != true) return false;
    if (pricingKey.currentState?.validate() != true) return false;
    return true;
  }
}
