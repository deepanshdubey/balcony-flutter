import 'package:auto_route/annotations.dart';
import 'package:balcony/generated/assets.dart';
import 'package:balcony/ui/home/ui/tabs/workspace/store/workspace_store.dart';
import 'package:balcony/ui/home/ui/tabs/workspace/ui/workspace_details/booking_calender.dart';
import 'package:balcony/ui/home/ui/tabs/workspace/ui/workspace_details/custom_dropdown.dart';
import 'package:balcony/values/colors.dart';
import 'package:balcony/values/extensions/theme_ext.dart';
import 'package:balcony/widget/app_image.dart';
import 'package:balcony/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class WorkspaceDetailPage extends StatefulWidget {
  final String? workspaceId ;
  const WorkspaceDetailPage({super.key, this.workspaceId});

  @override
  State<WorkspaceDetailPage> createState() => _WorkspaceDetailPageState();
}

class _WorkspaceDetailPageState extends State<WorkspaceDetailPage> {

  final workspaceStore = WorkspaceStore();

  @override
  void initState() {
    workspaceStore.getWorkspaceDetail(id:"60c72b2f9b1e8f001f2d3b59");
    super.initState();
  }


  final List<Map<String, dynamic>> amenities = [
    {'icon': Icons.home, 'title': 'residential'},
    {'icon': Icons.table_bar, 'title': '16 table'},
    {'icon': Icons.chair, 'title': '8 chair'},
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.normal, fontSize: 28.spMin),
            ),
            Row(
              children: [
                8.horizontalSpace,
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
              onPressed: () {},
            ),
            55.verticalSpace,
            Divider(
              color: appColor.primaryColor,
              thickness: 2,
            ),
            CustomDropdown(title: 'Amenities', items: amenities),
            CustomDropdown(title: 'Facilities', items: facilities),
          ],
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
