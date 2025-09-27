import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/base_state.dart';
import 'package:homework/values/colors.dart';
import 'package:homework/values/extensions/context_ext.dart';

class ProcessingFeeWidget extends StatefulWidget {
  final bool? feeType;

  const ProcessingFeeWidget({super.key, this.feeType});

  @override
  ProcessingFeeWidgetState createState() => ProcessingFeeWidgetState();
}

class ProcessingFeeWidgetState extends BaseState<ProcessingFeeWidget> {
  bool? feeType;

  @override
  void initState() {
    feeType = widget.feeType;
    super.initState();
  }

  @override
  bool validate() {
    return feeType != null;
  }

  @override
  String? getError() {
    return validate() ? null : 'please select either of one processing type';
  }

  @override
  bool getApiData() {
    return feeType!;
  }

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
            "processing fee*",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 24.spMin,
                ),
          ),
          4.h.verticalSpace,
          Text.rich(
            TextSpan(
              text: 'Important, please read: ',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: appColor.primaryColor,
                    fontSize: 12.spMin,
                  ),
              children: [
                TextSpan(
                  text:
                      'Our payment processor, Stripe, charges a processing fee for all ACH transfers, but the good news is that the cap they charge is up to \$5.\n\n',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w300,
                        color: appColor.primaryColor,
                        fontSize: 12.spMin,
                      ),
                ),
                TextSpan(
                  text:
                      'With that being said, would you like to charge your tenants that processing fee as an extra on top of the rent total or would you like to hide it from the tenant checkout UI where that fee is taken from the total of the rent. Again, the cap per Stripe’s policy is up to \$5 for ACH transfers.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w300,
                        color: appColor.primaryColor,
                        fontSize: 12.spMin,
                      ),
                ),
              ],
            ),
          ),
          16.h.verticalSpace,
          Row(
            children: [
              Checkbox(
                value: feeType == true,
                onChanged: (value) {
                  setState(() => feeType = true);
                },
              ),
              Expanded(
                child: Text(
                  "charge fee from the rent total (tenant does not see fee during checkout)",
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ),
            ],
          ),
          16.h.verticalSpace,
          Text(
            "   -- or --   ",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          16.h.verticalSpace,
          Row(
            children: [
              Checkbox(
                value: feeType == false,
                onChanged: (value) {
                  setState(() => feeType = false);
                },
              ),
              Expanded(
                child: Text(
                  "charge fee as an addition along with the rent total (tenant sees fee during checkout)",
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 16.spMin,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ),
            ],
          ),
          16.h.verticalSpace,
        ],
      ),
    );
  }
}
