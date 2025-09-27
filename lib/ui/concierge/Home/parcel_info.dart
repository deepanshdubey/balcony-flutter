import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/generated/assets.dart';
import 'package:homework/values/extensions/theme_ext.dart';
import 'package:homework/widget/primary_button.dart';

/// A stateless parcel info card showing pending parcel count and an email button.
class ParcelInfo extends StatelessWidget {
  /// Whether the data is currently loading.
  final bool isLoading;
  final bool isRemindingForPendingParcel;

  /// The number of parcels pending pickup.
  final int pendingParcelCount;

  /// Callback when the email button is pressed.
  final VoidCallback onEmailPressed;

  const ParcelInfo({
    super.key,
    this.isLoading = false,
    this.isRemindingForPendingParcel = false,
    required this.pendingParcelCount,
    required this.onEmailPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: theme.colors.primaryColor,
        ),
      );
    }

    return Container(
      width: 235.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.black.withOpacity(.25)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 22.h),
            Row(
              children: [
                Image.asset(
                  Assets.imagesAlertCircle,
                  height: 22.r,
                  width: 22.r,
                ),
                SizedBox(width: 5.w),
                Text(
                  pendingParcelCount.toString(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 43.spMin,
                    color: theme.colors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 9.h),
            const Text(
              'This is the total amount of tenants that have yet to pick-up their parcel. '
              'You may mass email tenants to remind them to pick-up.',
            ),
            SizedBox(height: 20.h),
            PrimaryButton(
              text: 'email',
              isLoading: isRemindingForPendingParcel,
              onPressed: onEmailPressed,
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
