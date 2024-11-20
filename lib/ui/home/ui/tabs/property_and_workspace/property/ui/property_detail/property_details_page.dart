import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:balcony/generated/assets.dart';
import 'package:balcony/ui/home/ui/tabs/chat/ui/chat_page.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/property/ui/tenant_application/tenant_application_page.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/store/workspace_store.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/ui/workspace_details/custom_dropdown.dart';
import 'package:balcony/values/colors.dart';
import 'package:balcony/values/extensions/theme_ext.dart';
import 'package:balcony/widget/app_back_button.dart';
import 'package:balcony/widget/app_image.dart';
import 'package:balcony/widget/app_text_field.dart';
import 'package:balcony/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';

@RoutePage()
class PropertyDetailPage extends StatefulWidget {
  const PropertyDetailPage({super.key});

  @override
  State<PropertyDetailPage> createState() => _PropertyDetailPageState();
}

class _PropertyDetailPageState extends State<PropertyDetailPage> {
  List<ReactionDisposer>? disposers;
  late TextEditingController leaseController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }



  final List<Map<String, dynamic>> facilities = [
    {'icon': Icons.local_parking, 'title': 'Parking'},
    {'icon': Icons.pool, 'title': 'Swimming Pool'},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Observer(
          builder: (context) {
            var data = workspaceStore.workspaceDetailsResponse;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  25.verticalSpace,
                  const AppBackButton(
                    text: "back",
                  ),
                  20.verticalSpace,
                  AppImage(
                    assetPath: data?.images?.first ??
                        Assets.fontsHostYourWorkspaceOrProperty,
                    height: 173.h,
                    width: double.infinity,
                    boxFit: BoxFit.cover,
                    radius: 10,
                  ),
                  12.verticalSpace,
                  Row(
                    children: data?.images != null && data!.images!.length > 1
                        ? List.generate(
                            2,
                            (index) => Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: index == 0 ? 12.w : 0,
                                ),
                                child: AppImage(
                                  assetPath: data.images?[index + 1] ??
                                      Assets.fontsHostYourWorkspaceOrProperty,
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
                      buildRatingStars(theme, data?.ratings?.toDouble() ?? 0),
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
                  48.verticalSpace,
                  PrimaryButton(
                    text: "apply for tenancy",
                    onPressed: () {
                      showAppBottomSheet(context,  const TenantApplicationPage());
                    },


                  ),
                  32.verticalSpace,
                  const Divider(
                    color: Color(0xff005451),
                    thickness: 0.5,
                  ),
                  24.verticalSpace,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8).r,
                      border: Border.all(color: appColor.grayBorder),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24).r,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("lease duration",
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontSize: 23.spMin,
                                color: appColor.primaryColor,
                                fontWeight: FontWeight.w600,
                              )),
                          12.verticalSpace,
                          Container(
                            width: 50.w,
                            child: AppTextField(
                              hintText: '1.5',
                              keyboardType: TextInputType.number, label: 'months to years', controller: leaseController,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  30.verticalSpace,
                  Text(
                    "Contact Host for Support",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 14.spMin,
                      color: appColor.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Chat &/or call with the workspace host before booking",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 14.spMin,
                      color: appColor.primaryColor,
                    ),
                  ),
                  16.verticalSpace,
                  const Divider(
                    color: Color(0xff005451),
                    thickness: 0.5,
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
                    visibleItem: 1,
                    title: 'Locations',
                    items: data?.geocode != null
                        ? [
                            {'icon': Icons.location_pin, 'title': "Unknown"}
                          ]
                        : [],
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
                        [], visibleItem: 9,
                  ),
                  18.verticalSpace,
                  CustomDropdown(
                    title: 'Facilities',
                    items: facilities, visibleItem: 3,
                  ),
                  23.verticalSpace,
                  // Workspace Overview
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
                            "No description available.",
                            maxLines: 70,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontSize: 15.spMin,
                              color: appColor.primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
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
}
