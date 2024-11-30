import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:balcony/core/alert/alert_manager.dart';
import 'package:balcony/data/model/response/workspace_data.dart';
import 'package:balcony/generated/assets.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/store/workspace_store.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/ui/workspace_details/booking_calender.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/ui/workspace_details/custom_dropdown.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/ui/workspace_payment/workspace_payment_page.dart';
import 'package:balcony/values/colors.dart';
import 'package:balcony/values/extensions/assets_helper.dart';
import 'package:balcony/values/extensions/theme_ext.dart';
import 'package:balcony/widget/app_back_button.dart';
import 'package:balcony/widget/app_image.dart';
import 'package:balcony/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
  ValueNotifier<bool> dateSelected = ValueNotifier(false);
  String? selectedDate ;
  int? selectedDays;
  String? startDateIso;
  String? endDateIso;

  final workspaceStore = WorkspaceStore();

  @override
  void initState() {
    addDisposer();
    workspaceStore.getWorkspaceDetail(
        id: widget.workspaceId);
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


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Observer(
          builder: (context) {
            var data = workspaceStore.workspaceDetailsResponse;
            return workspaceStore.workspaceResponse?.isNotEmpty == true ||
                    workspaceStore.isLoading
                ? Center(
                    child:
                        CircularProgressIndicator(color: appColor.primaryColor),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24).r,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        45.verticalSpace,
                        const AppBackButton(
                          text: "back",
                        ),
                        30.verticalSpace,
                        AppImage(
                          url: data?.images?.first ??
                              Assets.fontsHostYourWorkspaceOrProperty,
                          height: 173.h,
                          width: double.infinity,
                          boxFit: BoxFit.cover,
                          radius: 10,
                        ),
                        12.verticalSpace,
                        Row(
                          children:
                              data?.images != null && data!.images!.length > 1
                                  ? List.generate(
                                      2,
                                      (index) => Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            right: index == 0 ? 12.w : 0,
                                          ),
                                          child: AppImage(
                                            url: data.images?[index + 1],
                                            height: 173.h,
                                            boxFit: BoxFit.cover,
                                            radius: 10,
                                            color: appColor.primaryColor,
                                          ),
                                        ),
                                      ),
                                    )
                                  : [Container()],
                        ),
                        47.verticalSpace,
                        Text(
                          data?.info?.name ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: 28.spMin,
                          ),
                        ),
                        20.verticalSpace,
                        Row(
                          children: [
                            buildRatingStars(
                                theme, data?.ratings?.toDouble() ?? 0),
                            6.horizontalSpace,
                            Text(
                              "(${data?.ratings ?? 0})",
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: 11.spMax,
                              ),
                            ),
                            40.horizontalSpace,
                            Image.asset(
                              Assets.imagesShare,
                              height: 16.h,
                              width: 16.w,
                              fit: BoxFit.cover,
                            )
                          ],
                        ),
                        29.verticalSpace,
                        BookingCalendar(
                          onDateSelected: (String onDateSelected,int days,String startDate, String endDate ) {
                            selectedDate = onDateSelected;
                            selectedDays = days ;
                            dateSelected.value = true;
                            startDateIso = startDate ;
                            endDateIso = endDate ;
                          },
                        ),
                        30.verticalSpace,
                        ValueListenableBuilder<bool>(
                          valueListenable: dateSelected,
                          builder: (context, value, child) {
                            return !value
                                ? const Text(
                              "Please select a date",
                              style: TextStyle(color: Colors.red),
                            )
                                : SizedBox.shrink();
                          },
                        ),
                        PrimaryButton(
                          text: "Book Workspace",
                          onPressed:() {
                            openBottomSheet(context , data);
                          },
                        ),
                        30.verticalSpace,
                        const Divider(
                          color: Color(0xff005451),
                          thickness: 0.5,
                        ),
                        16.verticalSpace,
                        Text(
                          "Contact Host for Support",
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontSize: 14.spMin,
                            color: appColor.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        4.verticalSpace,
                        Container(
                          width: 200.w,
                          child: Text(
                            "Chat &/or call with the workspace host before booking",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontSize: 14.spMin,
                              color: appColor.primaryColor,
                            ),
                          ),
                        ),
                        16.verticalSpace,
                        Container(
                          width: 200.w,
                          child: const Divider(
                            color: Color(0xff005451),
                            thickness: 0.5,
                          ),
                        ),
                        16.verticalSpace,
                        Row(
                          children: [
                            Text(
                              "chat",
                              style: theme.textTheme.titleMedium?.copyWith(
                                  fontSize: 14.spMin,
                                  color: appColor.primaryColor,
                                  decoration: TextDecoration.underline),
                            ),
                            16.horizontalSpace,
                            Container(
                              color: const Color(0xff005451),
                              height: 20.h,
                              width: 1.w,
                            ),
                            16.horizontalSpace,
                            Text(
                              "call",
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontSize: 14.spMin,
                                decoration: TextDecoration.underline,
                                color: appColor.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        25.verticalSpace,
                        CustomDropdown(
                          title: 'Locations',
                          items: data?.info?.address != null
                              ? [
                                  {
                                    'icon': Icons.location_pin,
                                    'title': data?.info?.address
                                  }
                                ]
                              : [],
                          visibleItem: 1,
                          iconImage: Assets.imagesLocationOn,
                        ),
                        18.verticalSpace,
                        CustomDropdown(
                          title: 'Amenities',
                          items: data?.amenities
                                  ?.map((amenity) => {
                                        'icon': Icons.check,
                                        'title': amenity,
                                      })
                                  .toList() ??
                              [],
                          visibleItem: 9,
                        ),
                        18.verticalSpace,
                        CustomDropdown(
                          title: 'workspace booking info',
                          items: [
                            {
                              'title': "\$${data?.pricing?.totalPerDay} per person",
                            },{
                              'title': "${data?.other?.additionalGuests} extra guests allowed",
                            }
                          ],
                          visibleItem: 3,iconImage: Assets.imagesProfile,
                        ),
                        18.verticalSpace,
                        CustomDropdown(
                          title: 'Hours of Service (Time Frame)',
                          items:
                              TimesHelper.mapTimesToDropdownItems(data?.times),
                          visibleItem: 3,iconImage: Assets.imagesClock,
                        ),
                        18.verticalSpace,
                        CustomDropdown(
                          title: 'workspace info',
                          items: [
                           if(data?.other?.isCoWorkingWorkspace ?? false) {
                              'title': "shared co-working space",
                            },if(data?.other?.isIndoorSpace ?? false){
                              'title': "conference room",
                            }
                          ],
                          visibleItem: 3,
                        ),
                        23.verticalSpace,
                        // Workspace Overview
                        Container(
                          width: 1.sw,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8).r,
                            border: Border.all(color: appColor.primaryColor),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12).r,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                24.verticalSpace,
                                Text(
                                  "Workspace Overview",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontSize: 28.spMin,
                                    color: appColor.primaryColor,
                                  ),
                                ),
                                30.verticalSpace,
                                Text(
                                  data?.info?.summary ?? "",
                                  maxLines: 70,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontSize: 15.spMin,
                                    color: appColor.primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                30.verticalSpace
                              ],
                            ),
                          ),
                        ),
                        23.verticalSpace,
                        // Map Image Placeholder
                        Image.asset(
                          Assets.dummyMap,
                          height: 200.h,
                          width: 1.sw,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  );
          },
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

  void openBottomSheet(BuildContext context , WorkspaceData? data) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: WorkspacePaymentPage(
            workspaceData: data,
            selectedData: selectedDate,
              selectedDays: selectedDays,
            startDate: startDateIso,
            endDate: endDateIso,
          ),
        );
      },
    );
  }
}
