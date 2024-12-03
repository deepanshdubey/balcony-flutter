import 'package:auto_route/auto_route.dart';
import 'package:balcony/ui/home/ui/tabs/more/ui/wallet/ui/wallet_page.dart';
import 'package:balcony/values/colors.dart';
import 'package:balcony/values/extensions/theme_ext.dart';
import 'package:balcony/widget/app_back_button.dart';
import 'package:balcony/widget/app_text_field.dart';
import 'package:balcony/widget/bokking_dialog.dart';
import 'package:balcony/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RentPaymentDetailsPage extends StatefulWidget {
  const RentPaymentDetailsPage({super.key});

  @override
  State<RentPaymentDetailsPage> createState() => _RentPaymentDetailsPageState();
}

class _RentPaymentDetailsPageState extends State<RentPaymentDetailsPage> {
  final TextEditingController promoController = TextEditingController();
  final TextEditingController routingController = TextEditingController();
  final TextEditingController accountController = TextEditingController();
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpace,
              const AppBackButton(
                text: "Back",
              ),
              20.verticalSpace,
              _buildPropertyDetailsSection(context),
              40.verticalSpace,
              Text(
                "- OR -",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 23.spMin,
                    ),
              ),
              40.verticalSpace,
              _buildAutopaySection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPropertyDetailsSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8).r,
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader("Property Name"),
          Padding(
            padding: const EdgeInsets.all(16.0).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "leasing details",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.spMin,
                      ),
                ),
                20.verticalSpace,
                _buildLeasingDetails(),
                20.verticalSpace,
                Divider(color: Colors.grey.shade400),
                20.verticalSpace,
                _buildLeaseDates(),
                20.verticalSpace,
                Divider(color: Colors.grey.shade400),
                20.verticalSpace,
                Text(
                  "User info",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.spMin,
                      ),
                ),
                20.verticalSpace,
                _buildUserInfo(),
                20.verticalSpace,
                Divider(color: Colors.grey.shade400),
                20.verticalSpace,
                _buildPromoCodeSection(),
                _buildPaymentSection(),
                PrimaryButton(
                  text: "Pay Rant",
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CompleteDialog(
                          title: "Your all set!",
                          message:
                              "You should receive an email with the booking details. You can also visit the booking detail page as well.",
                          primaryButtonText: "visit rental manager page",
                          secondaryButtonText: "Done",
                          onPrimaryButtonPressed: () {
                            Navigator.of(context).pop();
                          },
                          onSecondaryButtonPressed: () {
                            Navigator.of(context).pop(); // Dismiss the dialog
                          },
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        20.verticalSpace,
        Divider(color: Colors.grey.shade400),
        20.verticalSpace,
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
                return FractionallySizedBox(
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
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      height: 60.h,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12).r,
      decoration: BoxDecoration(
        color: const Color(0xFFCCDDDC),
        borderRadius: BorderRadius.vertical(top: Radius.circular(8).r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 17.spMin,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeasingDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildKeyValueRow("Rent Amount", "\$3000.00"),
        20.verticalSpace,
        _buildKeyValueRow("Service Fee", "\$5.00"),
        20.verticalSpace,
        _buildKeyValueRow("Total", "\$3005.00", isBold: true),
      ],
    );
  }

  Widget _buildLeaseDates() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildKeyValueRow("Lease Start Date", "01/01/2025"),
        20.verticalSpace,
        _buildKeyValueRow("Lease End Date", "01/01/2026"),
      ],
    );
  }

  Widget _buildUserInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildKeyValueRow("Name", "Liam Johnson"),
        20.verticalSpace,
        _buildKeyValueRow("Email", "liam@acme.com"),
        20.verticalSpace,
        _buildKeyValueRow("Phone", "+1 234 567 890"),
      ],
    );
  }

  Widget _buildPromoCodeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          label: 'Promo code',
          hintText: "Promo code",
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          controller: promoController,
        ),
      ],
    );
  }

  Widget _buildAutopaySection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8).r,
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Set-up Autopay",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 23.spMin,
                  ),
            ),
            20.verticalSpace,
            Text(
              "You can automatically accept bookings as they come in or manually accept orders.",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.spMin,
                  ),
            ),
            20.verticalSpace,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.r)),
                  border: Border.all(color: Colors.black.withOpacity(.25))),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTab("manual pay", 0),
                  _buildTab("autopay", 1),
                ],
              ),
            ),
            if (_currentIndex == 1)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.verticalSpace,
                  Text(
                    "bank account info",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 20.spMin,
                        ),
                  ),
                  20.verticalSpace,
                  AppTextField(
                    controller: routingController,
                    label: "routing number",
                    hintText: "0023",
                  ),
                  20.verticalSpace,
                  AppTextField(
                    controller: accountController,
                    label: "account number",
                    hintText: "0023",
                  ),
                  20.verticalSpace,
                  Text(
                    "- OR -",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 23.spMin,
                        ),
                  ),
                  20.verticalSpace,
                  Text(
                    "wallet (card)",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 20.spMin,
                        ),
                  ),
                  20.verticalSpace,
                  Text(
                    "add from wallet",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          fontSize: 12.spMin,
                        ),
                  ),
                  20.verticalSpace,
                  Divider(color: Colors.grey.shade400),
                  20.verticalSpace,
                  AgreementCheckboxes(
                    onAllChecked: () {},
                  ),
                  20.verticalSpace,
                  Center(
                    child: PrimaryButton(
                      text: "complete autopay setup",
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CompleteDialog(
                              title: "Your all set!",
                              message:
                                  "You should receive an email with the booking details. You can also visit the booking detail page as well.",
                              primaryButtonText: "visit rental manager page",
                              secondaryButtonText: "Done",
                              onPrimaryButtonPressed: () {
                                context.router.canPop();
                              },
                              onSecondaryButtonPressed: () {
                                context.router.canPop();
                              },
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              )
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String text, int index) {
    bool isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
            color: isActive
                ? Theme.of(context).colors.primaryColor
                : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(12.r))),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16.spMin,
                fontWeight: FontWeight.w500,
                color: _currentIndex == index
                    ? Theme.of(context).colors.backgroundColor
                    : Theme.of(context).colors.primaryColor,
              ),
        ),
      ),
    );
  }

  Widget _buildKeyValueRow(String key, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          key,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 13.spMin,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 13.spMin,
              ),
        ),
      ],
    );
  }
}

class AgreementCheckboxes extends StatefulWidget {
  final VoidCallback onAllChecked;

  const AgreementCheckboxes({Key? key, required this.onAllChecked})
      : super(key: key);

  @override
  _AgreementCheckboxesState createState() => _AgreementCheckboxesState();
}

class _AgreementCheckboxesState extends State<AgreementCheckboxes> {
  // ValueNotifiers to track checkbox states
  final ValueNotifier<bool> _termsAccepted = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _serviceFeeAccepted = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    // Listen to both checkboxes and call the onAllChecked when both are true
    _termsAccepted.addListener(_checkAllAccepted);
    _serviceFeeAccepted.addListener(_checkAllAccepted);
  }

  @override
  void dispose() {
    _termsAccepted.dispose();
    _serviceFeeAccepted.dispose();
    super.dispose();
  }

  void _checkAllAccepted() {
    if (_termsAccepted.value && _serviceFeeAccepted.value) {
      widget.onAllChecked();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: _termsAccepted,
          builder: (context, isChecked, _) {
            return CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              // Removes horizontal padding
              value: isChecked,
              onChanged: (value) {
                _termsAccepted.value = value ?? false;
              },
              title: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "I agree to homework ",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.spMin,
                          ),
                    ),
                    TextSpan(
                      text: "terms of service",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.spMin,
                          ),
                    ),
                    TextSpan(
                      text: " and ",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.spMin,
                          ),
                    ),
                    TextSpan(
                      text: "privacy policy.",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.spMin,
                          ),
                    ),
                  ],
                ),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            );
          },
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _serviceFeeAccepted,
          builder: (context, isChecked, _) {
            return CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              // Removes horizontal padding
              value: isChecked,
              onChanged: (value) {
                _serviceFeeAccepted.value = value ?? false;
              },
              title: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "I agree to the service fee charge which is usually a real small amount per ",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.spMin,
                          ),
                    ),
                    TextSpan(
                      text: "terms of service",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            fontSize: 12.spMin,
                          ),
                    ),
                    TextSpan(
                      text: " of our payment gateway.",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.spMin,
                          ),
                    ),
                  ],
                ),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            );
          },
        ),
      ],
    );
  }
}
