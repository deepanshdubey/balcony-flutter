import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BulkEmailWidget extends StatelessWidget {
  final int totalTenant;

  const BulkEmailWidget({super.key, required this.totalTenant});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24).r,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12).r,
          border: Border.all(color: Colors.black.withOpacity(.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "send bulk email\n(announcements)",
              style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 23.spMin,
                  fontWeight: FontWeight.w500,
                  color: theme.primaryColor),
            ),
            4.verticalSpace,
            Text(
                "total tenants from all the properties: $totalTenant\n You cam email all tenants from all the properties or you can email a specific property."),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }
}
