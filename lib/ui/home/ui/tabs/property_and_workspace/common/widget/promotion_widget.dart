import 'package:balcony/ui/home/ui/tabs/property_and_workspace/common/base_state.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/common/model/promotion_item.dart';
import 'package:balcony/values/extensions/context_ext.dart';
import 'package:balcony/values/validators.dart';
import 'package:balcony/widget/app_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PromotionWidget extends StatefulWidget {
  const PromotionWidget({
    super.key,
  });

  @override
  State<PromotionWidget> createState() => _PromotionWidgetState();
}

class _PromotionWidgetState extends BaseState<PromotionWidget> {
  late GlobalKey<FormState> formKey;
  int maxUnits = 10;

  List<PromotionItem> promotions = [];

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    formKey.currentState?.dispose();
    super.dispose();
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
            "promotion",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 24.spMin,
                ),
          ),
          4.h.verticalSpace,
          Text(
            "add promotions so people can use in checkout ",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w300,
                  fontSize: 14.spMin,
                ),
          ),
          16.h.verticalSpace,
          promotions.isEmpty
              ? Text(
                  "no promo yet!",
                  style: theme.textTheme.titleMedium,
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: promotions
                      .map(
                        (e) => promoItem(e),
                      )
                      .toList(),
                ),
          16.h.verticalSpace,
          GestureDetector(
            onTap: () {
              if (promotions.length < maxUnits) {
                setState(() {
                  promotions.add(PromotionItem());
                });
              }
            },
            child: Row(
              children: [
                Opacity(
                  opacity: promotions.length < maxUnits ? 1 : .2,
                  child: Icon(
                    Icons.add_circle_outline_rounded,
                    color: theme.primaryColor,
                    size: 40.r,
                  ),
                ),
                8.w.horizontalSpace,
                Expanded(
                  child: Text(
                    'add new promo',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        decoration: TextDecoration.underline,
                        color: theme.primaryColor.withOpacity(
                            promotions.length <= maxUnits ? 1 : .2)),
                  ),
                )
              ],
            ),
          ),
          16.h.verticalSpace,
        ],
      ),
    );
  }

  @override
  dynamic getApiData() {
    return null;
  }

  @override
  String? getError() {
    return null;
  }

  @override
  bool validate() {
    return formKey.currentState?.validate() == true;
  }

  Widget promoItem(PromotionItem e) {
    return StatefulBuilder(builder: (context, innerSetState) {
      return Form(
        key: e.key,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            12.h.verticalSpace,
            Row(
              children: [
                Flexible(
                  flex: 5,
                  child: AppTextField(
                    controller: e.nameController,
                    label: 'promo ${promotions.indexOf(e) + 1}',
                    hintText: 'promo code',
                    validator: requiredValidator.call,
                  ),
                ),
                16.w.horizontalSpace,
                Flexible(
                  flex: 5,
                  child: Column(
                    children: [
                      RichText(
                          text: TextSpan(
                              text: 'percentage',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  if (!e.isPercentage) {
                                    innerSetState(() {
                                      e.isPercentage = true;
                                    });
                                  }
                                },
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      fontSize: 14.spMin,
                                      fontWeight: FontWeight.w500,
                                      decoration: e.isPercentage
                                          ? TextDecoration.underline
                                          : null),
                              children: [
                            TextSpan(
                                text: " / ",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(decoration: null)),
                            TextSpan(
                              text: 'flat',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  if (e.isPercentage) {
                                    innerSetState(() {
                                      e.isPercentage = false;
                                    });
                                  }
                                },
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      fontSize: 14.spMin,
                                      fontWeight: FontWeight.w500,
                                      decoration: !e.isPercentage
                                          ? TextDecoration.underline
                                          : null),
                            ),
                          ])),
                      5.h.verticalSpace,
                      AppTextField(
                        controller: e.valueController,
                        hintText: e.isPercentage ? '##%' : '\$\$',
                        label: '',
                        showLabelAboveField: false,
                        // maxLength: e.isPercentage ? 2 : 4,
                        inputFormatters: [
                          e.isPercentage
                              ? FilteringTextInputFormatter.digitsOnly
                              : FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9].'))
                        ],
                        validator: requiredValidator.call,
                      ),
                    ],
                  ),
                ),
                8.w.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (e.key.currentState?.validate() == true) {}
                      },
                      child: Text(
                        "add",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(decoration: TextDecoration.underline),
                      ),
                    ),
                    8.h.verticalSpace,
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          promotions.remove(e);
                        });
                      },
                      child: Text(
                        "delete",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 12.h),
              width: double.infinity,
              height: 1.h,
              color: theme.primaryColor,
            )
          ],
        ),
      );
    });
  }
}
