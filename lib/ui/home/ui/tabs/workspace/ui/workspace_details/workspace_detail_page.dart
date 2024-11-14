import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:balcony/core/alert/alert_manager.dart';
import 'package:balcony/generated/assets.dart';
import 'package:balcony/ui/home/ui/tabs/workspace/store/workspace_store.dart';
import 'package:balcony/ui/home/ui/tabs/workspace/ui/workspace_details/booking_calender.dart';
import 'package:balcony/ui/home/ui/tabs/workspace/ui/workspace_details/custom_dropdown.dart';
import 'package:balcony/ui/home/ui/tabs/workspace/ui/workspace_payment/workspace_payment_page.dart';
import 'package:balcony/values/colors.dart';
import 'package:balcony/values/extensions/theme_ext.dart';
import 'package:balcony/widget/app_image.dart';
import 'package:balcony/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';

@RoutePage()
class WorkspaceDetailPage extends StatefulWidget {
  final String? workspaceId;

  const WorkspaceDetailPage({super.key, this.workspaceId});

  @override
  State<WorkspaceDetailPage> createState() => _WorkspaceDetailPageState();
}

class _WorkspaceDetailPageState extends State<WorkspaceDetailPage> {
  List<ReactionDisposer>? disposers;

  final workspaceStore = WorkspaceStore();

  @override
  void initState() {
    addDisposer();
    workspaceStore.getWorkspaceDetail(id: widget.workspaceId);
    super.initState();
  }

  @override
  void dispose() {
    removeDisposer();
    super.dispose();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => workspaceStore.errorMessage, (String? errorMessage) {
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

  final List<Map<String, dynamic>> amenities = [
    {'icon': Icons.home, 'title': 'residential'},
    {'icon': Icons.table_bar, 'title': '16 table'},
    {'icon': Icons.chair, 'title': '8 chair'},
  ];

  final List<Map<String, dynamic>> location = [
    {'icon': Icons.location_pin, 'title': 'residential'},
  ];

  final List<Map<String, dynamic>> facilities = [
    {'icon': Icons.local_parking, 'title': 'Parking'},
    {'icon': Icons.pool, 'title': 'Swimming Pool'},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              60.verticalSpace,
              AppImage(
                assetPath: Assets.fontsHostYourWorkspaceOrProperty,
                height: 173.h,
                width: double.infinity,
                boxFit: BoxFit.cover,
                radius: 10,
              ),
              12.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: AppImage(
                      assetPath: Assets.fontsHostYourWorkspaceOrProperty,
                      height: 173.h,
                      boxFit: BoxFit.cover,
                      radius: 10,
                    ),
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: AppImage(
                      assetPath: Assets.fontsHostYourWorkspaceOrProperty,
                      height: 173.h,
                      boxFit: BoxFit.cover,
                      radius: 10,
                    ),
                  ),
                ],
              ),
              47.verticalSpace,
              Text(
                "bushwick lofts",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.normal, fontSize: 28.spMin),
              ),
              20.verticalSpace,
              Row(
                children: [
                  buildRatingStars(theme, 2),
                  6.horizontalSpace,
                  Text(
                    "(2)",
                    maxLines: 1,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: 11.spMax,
                    ),
                  ),
                ],
              ),
              29.verticalSpace,
              BookingCalendar(),
              51.verticalSpace,
              PrimaryButton(
                text: "book workspace",
                onPressed: () {
                  showModalBottomSheet(
                    context: context,

                    isScrollControlled: true, // Makes it a full-height bottom sheet
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return FractionallySizedBox(
                        heightFactor: 0.8, // 80% of the screen height
                        child: WorkspacePaymentPage(),
                      );
                    },
                  );
                },
              ),
              55.verticalSpace,
              const Divider(
                color: Color(0xff005451),
                thickness: 0.5,
              ),
              16.verticalSpace,
              Text(
                "contact host for support",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 14.spMin,
                    color: appColor.primaryColor,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: 200.w,
                child: Text(
                  "chat &/or call with the workspace host before booking",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 14.spMin, color: appColor.primaryColor),
                ),
              ),
              16.verticalSpace,
              const Divider(
                color: Color(0xff005451),
                thickness: 0.5,
              ),
              16.verticalSpace,
              CustomDropdown(title: 'Locations', items: location),
              CustomDropdown(title: 'Amenities', items: amenities),
              CustomDropdown(
                  title: 'workspace booking info', items: facilities),
              CustomDropdown(title: 'hours of ', items: facilities),
              23.verticalSpace,
              Container(
                width: 1.sw,
                height: 320.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8).r,
                  border: Border.all(color: appColor.primaryColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12).r,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      24.verticalSpace,
                      Text(
                        "workspace overview",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontSize: 28.spMin,
                                color: appColor.primaryColor),
                      ),
                      30.verticalSpace,
                      Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laboreLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laboreLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laboreLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laboreLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laboreLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod t",
                        maxLines: 70,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontSize: 15.spMin,
                                color: appColor.primaryColor,
                        fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              23.verticalSpace,
              Image.asset(
                Assets.dummyMap,
                height: 200.h,
                width: 1.sw,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRatingStars(ThemeData theme, double rating) {
    int fullStars = rating.floor(); // Full stars to show
    bool hasHalfStar =
        (rating - fullStars) >= 0.5; // Whether to show a half star

    return Row(
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: .5.w),
            child: AppImage(
              assetPath: theme.assets.ratingStar,
              height: 18.r,
              width: 18.r,
            ),
          );
        } else if (index == fullStars && hasHalfStar) {
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: .5.w),
              child: Icon(
                Icons.star,
                color: theme.primaryColor,
                size: 18.r,
              ));
        } else {
          return Icon(
            Icons.star_border,
            color: theme.primaryColor,
            size: 18.r,
          );
        }
      }),
    );
  }
}
