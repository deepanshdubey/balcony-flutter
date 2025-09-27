import 'package:auto_route/auto_route.dart';
import 'package:homework/data/model/response/property_data.dart';
import 'package:homework/data/model/response/workspace_data.dart';
import 'package:homework/router/app_router.dart';
import 'package:homework/values/extensions/context_ext.dart';
import 'package:homework/widget/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MapWorkspaceWidget<T> extends StatelessWidget {
  final T data;

  const MapWorkspaceWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Check the type of data and handle accordingly
    if (data is WorkspaceData) {
      final workspaceData = data as WorkspaceData;
      return _buildWorkspaceView(context, theme, workspaceData);
    } else if (data is PropertyData) {
      final propertyData = data as PropertyData;
      return _buildPropertyView(context, theme, propertyData);
    } else {
      return const Center(
        child: Text('Unsupported data type'),
      );
    }
  }

  // Workspace-specific view
  Widget _buildWorkspaceView(
      BuildContext context, ThemeData theme, WorkspaceData workspaceData) {
    return GestureDetector(
      onTap: () {
        context.router.push(
          WorkspaceDetailRoute(workspaceId: workspaceData.id),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 160.h,
          width: 230.w,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                5.verticalSpace,
                Stack(
                  children: [
                    AppImage(
                      url: workspaceData.images?.firstOrNull,
                      height: 140.h,
                      width: 220.w,
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
                            Text(workspaceData.info?.city ?? "",
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontSize: 12.spMin,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                          chip(
                            Text(
                                workspaceData.pricing?.formattedTotalPerDay ??
                                    "0",
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
                    "${workspaceData.info?.name} | ${workspaceData.info?.address}",
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
                    buildRatingStars(
                        theme, workspaceData.ratings?.toDouble() ?? 0),
                    6.horizontalSpace,
                    Text(
                      "(${workspaceData.ratings.toString()})",
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
          ),
        ),
      ),
    );
  }

  // Property-specific view
  Widget _buildPropertyView(
      BuildContext context, ThemeData theme, PropertyData propertyData) {
    return GestureDetector(
      onTap: () {
        context.router.push(
          PropertyDetailRoute(propertyId: propertyData.id),
        );
      },
      child: Card(
        child: Container(
          height: 160.h,
          width: 230.w,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                5.verticalSpace,
                AppImage(
                  url: propertyData.images?[0],
                  height: 140.h,
                  width: 220.w,
                  radius: 10,
                ),
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Text(
                    propertyData.info?.name ?? "Unnamed Property",
                    style: theme.textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget chip(Widget text,
      {double? horizontalPadding, double? verticalMargin}) {
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
            spreadRadius: 0,
          ),
        ],
      ),
      child: text,
    );
  }

  Widget buildRatingStars(ThemeData theme, double rating) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;

    return Row(
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: .5.w),
            child: Icon(Icons.star, color: theme.primaryColor, size: 12.r),
          );
        } else if (index == fullStars && hasHalfStar) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: .5.w),
            child: Icon(Icons.star_half, color: theme.primaryColor, size: 12.r),
          );
        } else {
          return Icon(Icons.star_border, color: theme.primaryColor, size: 12.r);
        }
      }),
    );
  }
}
