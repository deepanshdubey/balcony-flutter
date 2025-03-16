import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/values/extensions/context_ext.dart';

class EarningWidget extends StatelessWidget {
  final int progress;
  final String title, formattedEarningsWithCurrency, formattedTimePeriod;

  final bool isLoading;

  const EarningWidget({
    super.key,
    required this.progress,
    required this.formattedEarningsWithCurrency,
    required this.formattedTimePeriod,
    required this.title,
    bool this.isLoading = false,
  });

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
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w300,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.r),
            child: Text(
              formattedEarningsWithCurrency,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 32.spMin,
              ),
            ),
          ),
          Text(
            formattedTimePeriod,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w300,
            ),
          ),
          24.h.verticalSpace,
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const SizedBox
                  .shrink() /*ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: SizedBox(
                    height: 16.r,
                    child: Row(
                      children: [
                        Flexible(
                            flex: progress,
                            child: Container(
                              color: appColor.primaryColor,
                            )),
                        Flexible(
                            flex: 100 - progress,
                            child: Container(
                              color: appColor.grayBorder.withOpacity(.2),
                            )),
                      ],
                    ),
                  ),
                )*/
          ,
        ],
      ),
    );
  }
}
