import 'package:auto_route/annotations.dart';
import 'package:balcony/generated/assets.dart';
import 'package:balcony/values/colors.dart';
import 'package:balcony/widget/app_back_button.dart';
import 'package:balcony/widget/plan_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Plan {
  final String name;
  final String description;
  final double? price; // Null for free plans
  final List<String> features;
  bool isSelected;

  Plan({
    required this.name,
    required this.description,
    this.price,
    required this.features,
    this.isSelected = false,
  });
}

@RoutePage()
class PlansPage extends StatefulWidget {
  @override
  _PlansPageState createState() => _PlansPageState();
}

class _PlansPageState extends State<PlansPage> {
  final ValueNotifier<int> selectedPlanNotifier = ValueNotifier<int>(0);

  final List<Plan> plans = [
    Plan(
      name: "Free Plan",
      description: "Always free",
      features: [
        "Up to 3 total property units",
        "Dashboard access",
        "Leasing onboarding",
        "Tenant rental payment access",
      ],
      isSelected: true,
    ),
    Plan(
      name: "Villa Plan",
      description: "\$25/mo",
      price: 25,
      features: [
        "Up to 50 total property units",
        "Dashboard access",
        "Leasing onboarding",
        "Tenant rental payment access",
      ],
    ),
    Plan(
      name: "Pro Plan",
      description: "\$50/mo",
      price: 50,
      features: [
        "Up to 100 total property units",
        "Dashboard access",
        "Leasing onboarding",
        "Priority support",
      ],
    ),
    Plan(
      name: "Enterprise Plan",
      description: "Custom Pricing",
      features: [
        "Unlimited property units",
        "Dashboard access",
        "Custom integrations",
        "Dedicated account manager",
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16).r,
        child: ValueListenableBuilder<int>(
          valueListenable: selectedPlanNotifier,
          builder: (context, selectedPlan, _) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.verticalSpace,
                   const AppBackButton(
                    text: "back",
                  ),
                  20.verticalSpace,
                  Text(
                    "pricing",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 28.spMin,
                      color: appColor.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  40.verticalSpace,
                  Column(
                    children: plans.asMap().entries.map((entry) {
                      final index = entry.key;
                      final plan = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: PlanCard(
                          plan: plan,
                          isSelected: selectedPlan == index,
                          onTap: () {
                            selectedPlanNotifier.value = index;
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  final Plan plan;
  final bool isSelected;
  final VoidCallback onTap;

  const PlanCard({
    Key? key,
    required this.plan,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16).r, // Rounded corners for the image
            child: Image.asset(
              isSelected ? Assets.imagesContainerEmpty : Assets.imagesContainerFill, // Replace with your image asset path
              width: 1.sw, // Width of the image
              height: 370.h, // Height of the image
              fit: BoxFit.fill, // Make the image cover the entire container
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(16.0).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.verticalSpace,
                  Text(
                    plan.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 27.spMin,
                          color: appColor.primaryColor,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  25.verticalSpace,
                  PlanButton(
                    text: "Book Workspace",
                    isSelected: isSelected,
                    isLoading: false, // Loader condition can be added
                    onPressed: onTap,
                  ),
                  14.verticalSpace,
                  Text(
                    plan.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 27.spMin,
                          color: appColor.primaryColor,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  18.verticalSpace,
                  Divider(
                    color: appColor.grayBorder,
                  ),
                  20.verticalSpace,
                  Column(
                    children: plan.features.map(
                      (feature) {
                        int index = plan.features.indexOf(feature);
                        return Column(
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
                                      feature,
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
                            if (index == 0) // Add a divider after all items except the last one
                              Divider(
                                color: appColor.primaryColor.withOpacity(0.5),
                                thickness: 1.0,
                              ),
                          ],
                        );
                      },
                    ).toList(),
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
