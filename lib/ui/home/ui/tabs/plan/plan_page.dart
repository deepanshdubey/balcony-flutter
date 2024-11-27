import 'package:auto_route/annotations.dart';
import 'package:balcony/core/alert/alert_manager.dart';
import 'package:balcony/data/model/response/subscription_list_model.dart';
import 'package:balcony/generated/assets.dart';
import 'package:balcony/ui/auth/store/auth_store.dart';
import 'package:balcony/ui/home/ui/tabs/plan/plan_payment.dart';
import 'package:balcony/values/colors.dart';
import 'package:balcony/widget/app_back_button.dart';
import 'package:balcony/widget/currencies.dart';
import 'package:balcony/widget/plan_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';

@RoutePage()
class PlansPage extends StatefulWidget {
  @override
  _PlansPageState createState() => _PlansPageState();
}

class _PlansPageState extends State<PlansPage> {
  final ValueNotifier<int> selectedPlanNotifier = ValueNotifier<int>(0);
  List<ReactionDisposer>? disposers;
  String selectedCurrency = 'USD'; // Default selected currency
  String selectedSymbol = '\$'; // Default selected symbol

  final authStore = AuthStore();

  @override
  void initState() {
    authStore.getSubscriptionList(selectedCurrency.toLowerCase());
    addDisposer();
    super.initState();
  }

  @override
  void dispose() {
    removeDisposer();
    super.dispose();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => authStore.errorMessage, (String? errorMessage) {
        if (errorMessage != null) {
          alertManager.showError(context, errorMessage);
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

  void _onCurrencyChanged(String? newValue) {
    setState(() {
      selectedCurrency = newValue!;
      selectedSymbol = currencies.firstWhere(
          (currency) => currency['code'] == selectedCurrency)['symbol']!;
      authStore.getSubscriptionList(selectedCurrency.toLowerCase());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16).r,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpace,
              const AppBackButton(
                text: "back",
              ),
              20.verticalSpace,
              Row(
                children: [
                  Text(
                    "pricing",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 28.spMin,
                          color: appColor.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Spacer(),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius:
                          BorderRadius.circular(12), // For rounded corners
                    ),
                    child: DropdownButton<String>(
                      underline: 0.verticalSpace,
                      value: selectedCurrency,
                      onChanged: _onCurrencyChanged,
                      items:
                          currencies.map<DropdownMenuItem<String>>((currency) {
                        return DropdownMenuItem<String>(
                          value: currency['code'],
                          child: Text('(${currency['code']})'),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              40.verticalSpace,
              Observer(
                builder: (context) {
                  if (authStore.isLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: appColor.primaryColor,
                      ),
                    );
                  }

                  final subscriptions = authStore.subscriptionListResponse;

                  if (subscriptions == null || subscriptions.isEmpty) {
                    return Center(
                      child: Text(
                        "No plans available",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: appColor.primaryColor,
                            ),
                      ),
                    );
                  }

                  return Column(
                    children: subscriptions.asMap().entries.map((entry) {
                      final index = entry.key;
                      final plan = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: PlanCard(
                          symbole: selectedSymbol,
                          plan: plan,
                          isSelected: 0 == index,
                          onTap: () {
                            selectedPlanNotifier.value = index;
                            openBottomSheet(context, plan);
                          },
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openBottomSheet(BuildContext context, Plan plan) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: PlanPaymentPage(
            currencySymbol: selectedSymbol,
            plan: plan,
          ),
        );
      },
    );
  }
}

class PlanCard extends StatelessWidget {
  final String symbole;
  final Plan plan;
  final bool isSelected;
  final VoidCallback onTap;

  const PlanCard({
    Key? key,
    required this.plan,
    required this.isSelected,
    required this.onTap,
    required this.symbole,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius:
                BorderRadius.circular(16).r, // Rounded corners for the image
            child: Image.asset(
              isSelected
                  ? Assets.imagesContainerEmpty
                  : Assets
                      .imagesContainerFill, // Replace with your image asset path
              width: 1.sw,
              height: plan.id != "free_plan_subscription"
                  ? plan.id == "custom_plan"
                      ? 200.h
                      : 650.h
                  : 560.h,
              // Width of the image
              fit: BoxFit.fill, // Make the image cover the entire container
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(16.0).r,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.verticalSpace,
                  Text(
                    plan.name ?? "",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 27.spMin,
                          color: appColor.primaryColor,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  25.verticalSpace,
                  PlanButton(
                    text: "Get Started",
                    isSelected: isSelected,
                    isLoading: false, // Loader condition can be added
                    onPressed: onTap,
                  ),
                  14.verticalSpace,
                  if (plan.id != "custom_plan")
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: plan.price == 0
                                ? "Always free"
                                : "${symbole} ${plan.price}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: 27.spMin,
                                  color: appColor.primaryColor,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          if (plan.price != 0)
                            TextSpan(
                              text: "/mo",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontSize: 12.spMin,
                                    color: appColor.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                        ],
                      ),
                    ),
                  if (plan.id != "custom_plan") 18.verticalSpace,
                  if (plan.id != "custom_plan")
                    Divider(
                      color: appColor.grayBorder,
                    ),
                  if (plan.id != "custom_plan") 20.verticalSpace,
                  if (plan.id != "custom_plan")
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0).r,
                          child: Row(
                            children: [
                              Image.asset(
                                Assets.imagesCheckCircle,
                                height: 14.r,
                                width: 14.r,
                              ),
                              10.horizontalSpace,
                              Expanded(
                                child: Text(
                                  "up to ${plan.units} total property units",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontSize: 13.spMin,
                                        color: appColor.primaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: appColor.primaryColor.withOpacity(0.5),
                          thickness: 1.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0).r,
                          child: Row(
                            children: [
                              Image.asset(
                                Assets.imagesCheckCircle,
                                height: 14.r,
                                width: 14.r,
                              ),
                              10.horizontalSpace,
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Dashboard access",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontSize: 13.spMin,
                                            color: appColor.primaryColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    Text(
                                      "• property listing / showcasing",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontSize: 13.spMin,
                                            color: appColor.primaryColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    Text(
                                      "• **prospect tenant screening** (coming soon)",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontSize: 13.spMin,
                                            color: appColor.primaryColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    Text(
                                      "• communication (leads / tenants)",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontSize: 13.spMin,
                                            color: appColor.primaryColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        5.verticalSpace,
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0).r,
                          child: Row(
                            children: [
                              Image.asset(
                                Assets.imagesCheckCircle,
                                height: 14.r,
                                width: 14.r,
                              ),
                              10.horizontalSpace,
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Stripe connect (Express):",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontSize: 13.spMin,
                                            color: appColor.primaryColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    Text(
                                      "• analytics and reporting tools",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontSize: 13.spMin,
                                            color: appColor.primaryColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    Text(
                                      "• cash flow analysis",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontSize: 13.spMin,
                                            color: appColor.primaryColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    Text(
                                      "• rent payouts",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontSize: 13.spMin,
                                            color: appColor.primaryColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        5.verticalSpace,
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0).r,
                          child: Row(
                            children: [
                              Image.asset(
                                Assets.imagesCheckCircle,
                                height: 14.r,
                                width: 14.r,
                              ),
                              10.horizontalSpace,
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "leasing onboarding & automation",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontSize: 13.spMin,
                                            color: appColor.primaryColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        5.verticalSpace,
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0).r,
                          child: Row(
                            children: [
                              Image.asset(
                                Assets.imagesCheckCircle,
                                height: 14.r,
                                width: 14.r,
                              ),
                              10.horizontalSpace,
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "tenant rental payment access",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontSize: 13.spMin,
                                            color: appColor.primaryColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    Text(
                                      "• Collect rent by card & /or ACH transfer",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontSize: 13.spMin,
                                            color: appColor.primaryColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    Text(
                                      "• tenant maintence request",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontSize: 13.spMin,
                                            color: appColor.primaryColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        5.verticalSpace,
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0).r,
                          child: Row(
                            children: [
                              Image.asset(
                                Assets.imagesCheckCircle,
                                height: 14.r,
                                width: 14.r,
                              ),
                              10.horizontalSpace,
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "send automated payment reminders",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontSize: 13.spMin,
                                            color: appColor.primaryColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (plan.id != "free_plan_subscription" &&
                            plan.id != "custom_plan")
                          5.verticalSpace,
                        if (plan.id != "free_plan_subscription" &&
                            plan.id != "custom_plan")
                          Divider(
                            color: appColor.primaryColor.withOpacity(0.5),
                            thickness: 1.0,
                          ),
                        if (plan.id != "free_plan_subscription" &&
                            plan.id != "custom_plan")
                          Text(
                            "add-ons if needed*",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  decoration: TextDecoration.underline,
                                  fontSize: 13.spMin,
                                  color: appColor.primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        if (plan.id != "free_plan_subscription" &&
                            plan.id != "custom_plan")
                          5.verticalSpace,
                        if (plan.id != "free_plan_subscription" &&
                            plan.id != "custom_plan")
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 10.0).r,
                            child: Row(
                              children: [
                                Image.asset(
                                  Assets.imagesCheckCircle,
                                  height: 14.r,
                                  width: 14.r,
                                ),
                                10.horizontalSpace,
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "+ \$${plan.concierge} : Concierge CRM",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontSize: 13.spMin,
                                              color: appColor.primaryColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      Text(
                                        "• Package / Parcel Management",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontSize: 13.spMin,
                                              color: appColor.primaryColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      Text(
                                        "• Tenant Notification",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontSize: 13.spMin,
                                              color: appColor.primaryColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      Text(
                                        "• rent payouts",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontSize: 13.spMin,
                                              color: appColor.primaryColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
