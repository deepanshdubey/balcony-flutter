import 'package:auto_route/auto_route.dart';
import 'package:balcony/data/model/response/subscription_list_model.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/ui/wallets/wallet_page.dart';
import 'package:balcony/values/colors.dart';
import 'package:balcony/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlanPaymentPage extends StatefulWidget {
  final String currencySymbol;
  final Plan plan;

  PlanPaymentPage({super.key, required this.plan, required this.currencySymbol});

  @override
  State<PlanPaymentPage> createState() => _PlanPaymentPageState();
}

class _PlanPaymentPageState extends State<PlanPaymentPage> {

  bool isConciergeSelected = false; // Tracks if the checkbox is selected

  @override
  Widget build(BuildContext context) {
    final int planTotal = widget.plan.price ?? 0;
    final num subtotal = isConciergeSelected ? planTotal + ( widget.plan.concierge ?? 0) : planTotal;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle("${widget.plan.name}", widget.plan.units ?? 0),
                _buildUserInfoSection(),
                _buildCheckboxSection(planTotal, subtotal.toInt()),
             20.verticalSpace,
                Padding(

                  padding: const EdgeInsets.symmetric(horizontal: 16.0).r,
                  child: Divider(),
                ),
                _buildPaymentSection(),
                _buildBookButton(context),
                32.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, int units) {
    final theme = Theme.of(context);
    return Container(
      width: 1.sw,
      height: 80.h,
      decoration: BoxDecoration(
          color: const Color(0xffCCDDDC),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))
              .r),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.verticalSpace,
            Text(
              title,
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700, fontSize: 17.spMin),
            ),
            4.verticalSpace,
            Text(
              "Up to $units total property units, dashboard access leasing onboarding, tenant rental payment access",
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w500, fontSize: 13.spMin),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16).r,
            child: Text('Order Details',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w600, fontSize: 13.spMin)),
          ),
          16.verticalSpace,
          const SizedBox(height: 4),
          _buildKeyValueRow(widget.plan.name ?? "",

              "${widget.currencySymbol} ${widget.plan.price.toString()}"),
        ],
      ),
    );
  }

  Widget _buildCheckboxSection(int planTotal, int subtotal) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.verticalSpace,
          Row(
            children: [
              Checkbox(
                value: isConciergeSelected,
                onChanged: (bool? value) {
                  setState(() {
                    isConciergeSelected = value ?? false;
                  });
                },
              ),
              Text('Add Concierge CRM',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontSize: 14.spMin)),
            ],
          ),
          10.verticalSpace,

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0).r,
            child: Divider(),
          ),
          20.verticalSpace,
          _buildKeyValueRow("Plan Total", "${widget.currencySymbol} ${planTotal}"),
          if (isConciergeSelected) 20.verticalSpace,
          if (isConciergeSelected)
            _buildKeyValueRow("+ Concierge CRM", "${widget.currencySymbol} ${ widget.plan.concierge ?? 0}"),
          20.verticalSpace,

          _buildKeyValueRow("Subtotal", "${widget.currencySymbol} ${subtotal}"),
        ],
      ),
    );
  }

  Widget _buildPaymentSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.verticalSpace,
          Text('Payment Information',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w600, fontSize: 13.spMin)),
          12.verticalSpace,
          GestureDetector(
            onTap: () {
              context.maybePop();
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                builder: (BuildContext context) {
                  return const FractionallySizedBox(
                    heightFactor: 0.8,
                    child: WalletPage(),
                  );
                },
              );
            },
            child: Row(
              children: [
                Text("No card yet!"),
                Spacer(),
                Text('add',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 14.spMin,
                        color: appColor.primaryColor,
                        decoration: TextDecoration.underline)),
              ],
            ),
          ),
          16.verticalSpace
        ],
      ),
    );
  }

  Widget _buildBookButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24).r,
      child: PrimaryButton(
        text: "Start Subscription and Pay",
        onPressed: () {
          // Handle subscription logic
        },
      ),
    );
  }

  Widget _buildKeyValueRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0).r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(key,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 13.spMin,
                  color: const Color(0xff71717A))),
          Text(value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.normal, fontSize: 13.spMin)),
        ],
      ),
    );
  }
}
