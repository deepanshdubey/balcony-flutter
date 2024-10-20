import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PropertyWidget extends StatelessWidget {
  final String title;
  final String location;
  final String price;
  final double rating; // New rating field as float
  final int reviews;

  PropertyWidget({
    required this.title,
    required this.location,
    required this.price,
    required this.rating, // Pass the rating value
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 220.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: theme.primaryColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.025),
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                    spreadRadius: 0)
              ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              chip(
                  Text(location,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: 12.spMin,
                        fontWeight: FontWeight.w300,

                      )),
                  horizontalPadding: 30.w),
              chip(
                Text(price,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 12.spMin,
                      fontWeight: FontWeight.w300,
                    )),
              ),
              6.w.horizontalSpace,
            ],
          ),
        ),
        8.h.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        3.h.verticalSpace,
        Row(
          children: [
            8.horizontalSpace,
            buildRatingStars(theme, rating), // Display stars based on rating
            8.horizontalSpace,
            Text(
              '($reviews)',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 11.spMax,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
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
            BoxShadow(offset: Offset(0, 4), blurRadius: 4, spreadRadius: 0)
          ]),
      child: text,
    );
  }

  // Method to build stars based on the rating
  Widget buildRatingStars(ThemeData theme, double rating) {
    int fullStars = rating.floor(); // Full stars to show
    bool hasHalfStar =
        (rating - fullStars) >= 0.5; // Whether to show a half star
    int totalStars =
        fullStars + (hasHalfStar ? 1 : 0); // Total stars (including half)

    return Row(
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return Icon(
            Icons.star,
            color: theme.primaryColor,
            size: 12.r,
          );
        } else if (index == fullStars && hasHalfStar) {
          return Icon(
            Icons.star_half,
            color: theme.primaryColor,
            size: 12.r,
          );
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
