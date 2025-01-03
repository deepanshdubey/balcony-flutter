import 'package:auto_route/auto_route.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/core/session/app_session.dart';
import 'package:homework/data/model/response/card_data.dart';
import 'package:homework/data/model/response/tenant_details.dart';
import 'package:homework/ui/home/ui/tabs/more/ui/wallet/store/wallet_store.dart';
import 'package:homework/ui/home/ui/tabs/more/ui/wallet/ui/wallet_page.dart';
import 'package:homework/ui/home/ui/tabs/more/ui/wallet/widget/card_listing_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/store/property_store.dart';
import 'package:homework/values/extensions/theme_ext.dart';
import 'package:homework/widget/app_back_button.dart';
import 'package:homework/widget/app_text_field.dart';
import 'package:homework/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class FinishApplicationPage extends StatefulWidget {
  final Tenants? tenants;

  const FinishApplicationPage({super.key, this.tenants});

  @override
  State<FinishApplicationPage> createState() => _FinishApplicationPageState();
}

class _FinishApplicationPageState extends State<FinishApplicationPage> {
  final TextEditingController promoController = TextEditingController();
  final TextEditingController routingController = TextEditingController();
  final TextEditingController accountController = TextEditingController();
  int _currentIndex = 0;
  CardData? selectedCard;
  final ValueNotifier<String> selectedOption = ValueNotifier<String>("Card");
  var store = PropertyStore();

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    walletStore.getCards();
    super.initState();
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
          _buildSectionHeader(
              widget.tenants?.selectedUnit?.property?.info?.name ?? ""),
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
                _buildKeyValueRow("Due on or before",
                    formatDate(widget.tenants?.agreement?.leaseStartDate)),
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
                  text: "Submit payment",
                  onPressed: () {
                   var request =  {
                      "tenantId": widget.tenants?.Id,
                    "promoCode": promoController.text,
                    "type": "card"
                  };
                    store.tenantPayment(request);
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
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      height: 60.h,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12).r,
      decoration: BoxDecoration(
        color: const Color(0xFFCCDDDC),
        borderRadius: BorderRadius.vertical(top: const Radius.circular(8).r),
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
    final rentAmount = (widget.tenants?.agreement?.rent ?? 0.0) / 100;
    final securityFee = (widget.tenants?.agreement?.securityDepositFee ?? 0.0) / 100;
    final totalAmount = rentAmount + securityFee;

    return Column(
      children: [
        _buildKeyValueRow("Rent Amount", "\$${rentAmount.toStringAsFixed(2)}"),
        20.verticalSpace,
        _buildKeyValueRow(
            "Security fee", "\$${securityFee.toStringAsFixed(2)}"),
        20.verticalSpace,
        _buildKeyValueRow("Total", "\$${totalAmount.toStringAsFixed(2)}",
            isBold: true),
      ],
    );
    ;
  }

  Widget _buildLeaseDates() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildKeyValueRow("Lease Start Date",
            formatDate(widget.tenants?.agreement?.leaseStartDate)),
        20.verticalSpace,
        _buildKeyValueRow("Lease End Date",
            formatDate(widget.tenants?.agreement?.leaseEndDate)),
      ],
    );
  }

  Widget _buildUserInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildKeyValueRow("Name", session.user.firstName ?? ""),
        20.verticalSpace,
        _buildKeyValueRow("Email", session.user.email ?? ""),
        20.verticalSpace,
        _buildKeyValueRow("Phone", session.user.phone ?? ""),
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

  String formatDate(String? date) {
    if (date == null || date.isEmpty) return "";
    try {
      return DateFormat('MM/dd/yyyy').format(DateTime.parse(date));
    } catch (e) {
      print("Error parsing date: $e");
      return "";
    }
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
  final ValueNotifier<bool> _termsAccepted = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _serviceFeeAccepted = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
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
