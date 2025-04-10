import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/generated/assets.dart';
import 'package:homework/widget/primary_button.dart';

class ScanSection extends StatelessWidget {
  final VoidCallback onScan;
  final bool isAddingParcel;

  const ScanSection(
      {super.key, required this.onScan, this.isAddingParcel = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(Assets.imagesScanParcle, height: 32.r, width: 32.r),
            20.horizontalSpace,
            Expanded(
              child: Text(
                "add new parcels to the \nsystem the fast way.",
                style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 14.spMin,
                    fontWeight: FontWeight.w500,
                    color: theme.primaryColor),
                maxLines: 2,
              ),
            ),
          ],
        ),
        20.verticalSpace,
        PrimaryButton(
          isLoading: isAddingParcel,
          text: "scan entire parcel label",
          onPressed: onScan,
        )
      ],
    );
  }
}
