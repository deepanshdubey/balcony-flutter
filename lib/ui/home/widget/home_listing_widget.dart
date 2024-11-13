import 'package:balcony/values/extensions/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeListingWidget extends StatelessWidget {
  final String title;
  final VoidCallback onMoreClick;
  final List<Widget> children;
  final bool isReverse;
  final bool isLoading;

  HomeListingWidget({
    required this.title,
    required this.onMoreClick,
    required this.children,
    this.isReverse = false,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment:
                isReverse ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              isReverse ? showMore(theme) : titleText(theme),
              Container(
                color: theme.dividerColor,
                height: 30.h,
                width: 1,
                margin: EdgeInsets.symmetric(horizontal: 10.w),
              ),
              isReverse ? titleText(theme) : showMore(theme),
            ],
          ),
        ),
        8.h.verticalSpace,
        SizedBox(
          height: 220.h + 40.h + 20.h,
          child: ListView(
              reverse: isReverse,
              scrollDirection: Axis.horizontal,
              children: children
                  .map(
                    (e) => Container(
                        width: context.width * .7,
                        margin: EdgeInsets.symmetric(horizontal: 10.w),
                        child: e),
                  )
                  .toList()),
        ),
      ],
    );
  }

  Widget showMore(ThemeData theme) {
    return isLoading
        ? SizedBox(
            height: 40.r, width: 40.r, child: const CircularProgressIndicator())
        : GestureDetector(
            onTap: onMoreClick,
            child: Row(
              children: [
                Text(
                  "show more",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: 16.spMin,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                8.w.horizontalSpace,
                Icon(
                  Icons.add_circle_outline,
                  color: theme.primaryColor,
                  size: 20.r,
                ),
              ],
            ),
          );
  }

  Widget titleText(ThemeData theme) {
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(
        fontSize: 20.spMin,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
