import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/core/session/app_session.dart';
import 'package:homework/data/model/response/promo_list_model.dart';
import 'package:homework/data/model/response/promo_model.dart';
import 'package:homework/ui/home/store/promo_store.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/base_state.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/model/promotion_item.dart';
import 'package:homework/values/extensions/context_ext.dart';
import 'package:homework/values/validators.dart';
import 'package:homework/widget/app_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';

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
  List<ReactionDisposer>? disposers;
  final promoStore = PromoStore();

  List<PromotionItem> promotions = [];

  @override
  void initState() {
    addDisposer();
    promoStore.getPromoList(hostId: session.user.id);
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    removeDisposer();
    formKey.currentState?.dispose();
    super.dispose();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => promoStore.errorMessage, (String? errorMessage) {
        if (errorMessage != null) {
          alertManager.showError(context, errorMessage);
        }
      }),
      reaction((_) => promoStore.createPromoResponse, (PromoModel? promo) {
        if (promo?.success ?? false) {
          alertManager.showSuccess(context, "Promo added");
        }
      }),
      reaction((_) => promoStore.promoListResponse, (PromoListModel? promo) {
        if (promo?.success ?? false) {
          setPromotionData(promo!);
          setState(() {});
        }
      }),
    ];
  }

  void removeDisposer() {
    if (disposers == null) return;
    for (final element in disposers!) {
      element.reaction.dispose();
    }
  }

  void setPromotionData(PromoListModel promoModel) {
    promotions.clear(); // Clear existing promotions
    final promoList = promoModel;

    if (promoList != null) {
      for (var promo in promoList.promos ?? []) {
        final promotionItem = PromotionItem();
        promotionItem.nameController.text =
            promo.code ?? 'Regular'; // Default to "Regular"
        promotionItem.valueController.text =
            promo.discount?.toString() ?? '0'; // Default to "0"
        promotionItem.isPercentage =
            promo.type == 'percentage'; // Check type for percentage
        promotions.add(promotionItem);
      }
    } else {
      final defaultPromotion = PromotionItem()
        ..nameController.text = 'Regular'
        ..valueController.text = '0'
        ..isPercentage = true;

      promotions.add(defaultPromotion);
    }
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
                        if (e.key.currentState?.validate() == true) {
                          var req = {
                            "code": e.nameController.text,
                            "type": !e.isPercentage ? "flat" : "percentage",
                            "discount": int.parse(e.valueController.text),
                            "applicableOn": "workspace"
                          };

                          promoStore.createPromo(request: req);
                        }
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
