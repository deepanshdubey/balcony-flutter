import 'package:auto_route/auto_route.dart';
import 'package:balcony/data/model/response/workspace_data.dart';
import 'package:balcony/router/app_router.dart';
import 'package:balcony/values/extensions/context_ext.dart';
import 'package:balcony/values/extensions/theme_ext.dart';
import 'package:balcony/widget/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkspaceWidget extends StatelessWidget {
  final WorkspaceData data;

  const WorkspaceWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        context.router.push(WorkspaceDetailRoute());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AppImage(
                url: data.images?.firstOrNull,
                height: 200.h,
                width: context.width,
                radius: 10,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    chip(
                      Text(data.info?.city ?? "",
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontSize: 12.spMin,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                    chip(
                      Text(data.pricing?.formattedTotalPerDay ?? "0",
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontSize: 12.spMin,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                    6.w.horizontalSpace,
                  ],
                ),
              ),
            ],
          ),
          8.h.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              "${data.info?.name} | ${data.info?.address}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          3.h.verticalSpace,
          Row(
            children: [
              8.horizontalSpace,
              buildRatingStars(theme, data.ratings?.toDouble() ?? 0),
              // Display stars based on rating
              6.horizontalSpace,
              Text(
                "(${data.ratings.toString()})",
                maxLines: 1,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 11.spMax,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget chip(
    Widget text, {
    double? horizontalPadding,
    double? verticalMargin,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 12.w, vertical: 5.h),
      margin: EdgeInsets.symmetric(
          vertical: verticalMargin ?? 12.h, horizontal: 6.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.r),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 4),
                blurRadius: 4,
                spreadRadius: 0)
          ]),
      child: text,
    );
  }

  // Method to build stars based on the rating
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
              height: 12.r,
              width: 12.r,
            ),
          );
        } else if (index == fullStars && hasHalfStar) {
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: .5.w),
              child: Icon(
                Icons.star,
                color: theme.primaryColor,
                size: 12.r,
              ));
        } else {
          return Icon(
            Icons.star_border,
            color: theme.primaryColor,
            size: 12.r,
          );
        }
      }),
    );
  }
}
