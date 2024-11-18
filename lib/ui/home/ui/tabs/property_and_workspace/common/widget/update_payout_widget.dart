import 'package:balcony/values/extensions/context_ext.dart';
import 'package:balcony/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef UpdatePayoutClickListener = Function();

class UpdatePayoutWidget extends StatelessWidget {
  final UpdatePayoutClickListener onUpdatePayoutClickListener;

  const UpdatePayoutWidget(
      {super.key, required this.onUpdatePayoutClickListener});

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
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'update payout',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 24.spMin,
                ),
          ),
          16.h.verticalSpace,
          Text(
            "please click the link below as it would prompt you to a different link which is with our payment partner Stripe. You are able to update your payout info there.",
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w300,
              color: theme.primaryColor,
            ),
          ),
          16.h.verticalSpace,
          PrimaryButton(
            text: "update payout info",
            onPressed: () {},
            icon: Icon(
              Icons.open_in_new,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
