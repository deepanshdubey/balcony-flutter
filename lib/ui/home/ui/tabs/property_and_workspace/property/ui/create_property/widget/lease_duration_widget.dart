import 'package:balcony/values/extensions/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaseDurationWidget extends StatefulWidget {
  const LeaseDurationWidget({
    super.key,
  });

  @override
  State<LeaseDurationWidget> createState() => _LeaseDurationWidgetState();
}

class _LeaseDurationWidgetState extends State<LeaseDurationWidget> {
  double? selectedLeaseDuration;

  ThemeData get theme => Theme.of(context);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          border: Border.all(
              color: Theme.of(context).primaryColor.withOpacity(.25))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.h.verticalSpace,
          Text(
            'lease duration',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 24.spMin,
                ),
          ),
          16.h.verticalSpace,
          Row(
            children: [
              Expanded(
                  child: Slider(
                    min: 1,
                max: 10,
                value: selectedLeaseDuration ?? 1,
                onChanged: (value) {
                  setState(() {
                    selectedLeaseDuration = value;
                  });
                },
              )),
              SizedBox(
                width: context.width * .2,
                child: Column(
                  children: [
                    Text(
                      "year",
                      style: theme.textTheme.titleMedium,
                      maxLines: 1,
                    ),
                    6.h.verticalSpace,
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12.r)),
                          border: Border.all(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.25))),
                      child: Text(
                        selectedLeaseDuration == null
                            ? '##'
                            : selectedLeaseDuration!.toStringAsFixed(0),
                        style: theme.textTheme.titleMedium?.copyWith(
                            color: selectedLeaseDuration == null
                                ? theme.primaryColor.withOpacity(.5)
                                : theme.primaryColor),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          16.h.verticalSpace,
        ],
      ),
    );
  }
}
