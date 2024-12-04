import 'package:balcony/ui/home/ui/tabs/more/ui/support_tickets/ui/support_tickets_page.dart';
import 'package:balcony/values/extensions/context_ext.dart';
import 'package:balcony/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OpenSupportRequestWidget extends StatelessWidget {
  final int openSupportRequestCount;
  final bool isLoading;

  const OpenSupportRequestWidget(
      {super.key,
      required this.openSupportRequestCount,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: context.width,
      padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
        border: Border.all(color: Colors.black.withOpacity(.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info_outlined,
                color: theme.primaryColor,
              ),
              8.w.horizontalSpace,
              Expanded(
                child: Text(
                  "open support requests",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(6.r),
            child: Text(
              openSupportRequestCount.toStringAsFixed(0),
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 36.spMin,
              ),
            ),
          ),
          PrimaryButton(
            text: "view requests",
            isLoading: isLoading,
            onPressed: () {
              showAppBottomSheet(context, const SupportTicketsPage());
            },
          ),
        ],
      ),
    );
  }
}
