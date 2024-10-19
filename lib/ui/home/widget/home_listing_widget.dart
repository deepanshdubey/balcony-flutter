import 'package:balcony/values/extensions/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeListingWidget extends StatelessWidget {
  final String title;
  final VoidCallback onMoreClick;
  final List<Widget> children;
  final bool isReverse;

  HomeListingWidget({
    required this.title,
    required this.onMoreClick,
    required this.children,
    this.isReverse = false, // Default is not reversed
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
        const SizedBox(height: 16.0),
        SizedBox(
          height: context.height * .28,
          child: ListView(
              reverse: isReverse,
              scrollDirection: Axis.horizontal,
              children: children
                  .map(
                    (e) => Container(
                        width: context.width * .6,
                        margin: EdgeInsets.symmetric(horizontal: 10.w),
                        child: e),
                  )
                  .toList()),
        ),
      ],
    );
  }

  Widget showMore(ThemeData theme) {
    return GestureDetector(
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
