import 'package:auto_route/auto_route.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/data/model/response/card_data.dart';
import 'package:homework/data/model/response/subscription_list_model.dart';
import 'package:homework/router/app_router.dart';
import 'package:homework/ui/auth/store/auth_store.dart';
import 'package:homework/ui/home/ui/tabs/more/ui/wallet/store/wallet_store.dart';
import 'package:homework/ui/home/ui/tabs/more/ui/wallet/ui/wallet_page.dart';
import 'package:homework/ui/home/ui/tabs/more/ui/wallet/widget/card_listing_widget.dart';
import 'package:homework/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlanPaymentPage extends StatefulWidget {
  final String currencySymbol;
  final Plan plan;

  PlanPaymentPage(
      {super.key, required this.plan, required this.currencySymbol});

  @override
  State<PlanPaymentPage> createState() => _PlanPaymentPageState();
}

class _PlanPaymentPageState extends State<PlanPaymentPage> {
  CardData? selectedCard;
  final ValueNotifier<String> selectedOption = ValueNotifier<String>("Card");
  bool isConciergeSelected = false; // Tracks if the checkbox is selected
  var store = AuthStore();

  @override
  void initState() {
    walletStore.getCards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final int planTotal = widget.plan.price ?? 0;
    final num subtotal = isConciergeSelected
        ? planTotal + (widget.plan.concierge ?? 0)
        : planTotal;

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
                _buildSectionTitle(
                    "${widget.plan.name}", widget.plan.units ?? 0),
                _buildUserInfoSection(),
                if (widget.plan.name != "free plan")
                  _buildCheckboxSection(planTotal, subtotal.toInt()),
                if (widget.plan.name != "free plan") 20.verticalSpace,
                if (widget.plan.name != "free plan")
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0).r,
                    child: Divider(),
                  ),
                if (widget.plan.name != "free plan")  _buildPaymentSection(),
                if (widget.plan.name == "free plan") 15.verticalSpace,
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
      height: 85.h,
      decoration: BoxDecoration(
          color: const Color(0xffCCDDDC),
          borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))
              .r),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27).r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600, fontSize: 13.spMin)),
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
          _buildKeyValueRow(
              "Plan Total", "${widget.currencySymbol} ${planTotal}"),
          if (isConciergeSelected) 20.verticalSpace,
          if (isConciergeSelected)
            _buildKeyValueRow("+ Concierge CRM",
                "${widget.currencySymbol} ${widget.plan.concierge ?? 0}"),
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
            child: Observer(
              builder: (context) {
                var isLoading = walletStore.isLoading;
                var cards = walletStore.cardsResponse;
                return isLoading
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.r),
                          child: const CircularProgressIndicator(),
                        ),
                      )
                    : cards?.isNotEmpty == true
                        ? Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: CardListingWidget(
                              cards: cards!,
                              onEditClicked: (p0) {
                                selectedCard = p0;
                                selectedOption.value = "Edit Card";
                              },
                              onDeleteClicked: (p0) {
                                alertManager.showSystemAlertDialog(
                                  context: context,
                                  onConfirm: () {
                                    walletStore.deleteCard(p0.id.toString());
                                  },
                                );
                              },
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'No card yet!',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.spMin,
                                  ),
                            ),
                          );
              },
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
        text: widget.plan.name == "free plan" ? "Start" : "Start Subscription and Pay",
        onPressed: () {
          if (widget.plan.name == "free plan") {
            appRouter.push(CreatePropertyRoute());
          } else {
            var request = {
              "productId": widget.plan.id,
              "addConcierge": isConciergeSelected
            };
            store.subscriptionPurchase(request);
          }
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
