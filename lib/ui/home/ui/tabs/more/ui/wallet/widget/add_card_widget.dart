import 'package:homework/values/extensions/context_ext.dart';
import 'package:homework/widget/app_dropdown_field.dart';
import 'package:homework/widget/app_text_field.dart';
import 'package:homework/widget/primary_button.dart';
import 'package:credit_card_form/credit_card_form.dart';
import 'package:credit_card_form/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../store/wallet_store.dart';

class AddCardWidget extends StatefulWidget {
  const AddCardWidget({super.key});

  @override
  State<AddCardWidget> createState() => _AddCardWidgetState();
}

class _AddCardWidgetState extends State<AddCardWidget> {
  final GlobalKey<FormState> formKey = GlobalKey();
  late TextEditingController cardNumberController;
  late TextEditingController cardHolderNameController;
  late TextEditingController cvcController;
  late TextEditingController expiryMonthController;
  late TextEditingController expiryYearController;

  List<int> months = List.generate(12, (index) => index + 1);
  List<int> years = List.generate(10, (index) => DateTime.now().year + index);

  @override
  void initState() {
    super.initState();

    // Initialize controllers
    cardNumberController = TextEditingController();
    cardHolderNameController = TextEditingController();
    cvcController = TextEditingController();
    expiryMonthController = TextEditingController();
    expiryYearController = TextEditingController();

    // Initialize Stripe
    Stripe.publishableKey =
        "pk_live_51KDWm4CkzJlZYL9OLjpzmrrsra1Gk2rsZVe49r9QrhST705V4VEmI86KE5DTchyokr7QpEg2KUbyT1Yh42yolMf200MIURqLq6";
  }

  @override
  void dispose() {
    // Dispose controllers
    cardNumberController.dispose();
    cardHolderNameController.dispose();
    cvcController.dispose();
    expiryMonthController.dispose();
    expiryYearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Observer(builder: (context) {
          var isLoading = walletStore.isLoading;
          return createCardWidget(isLoading);
        }),
      ],
    );
  }

  Widget createCardWidget(bool isLoading) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          // Cardholder Name Field
          AppTextField(
            label: 'full name',
            hintText: 'enter full name',
            controller: cardHolderNameController,
            keyboardType: TextInputType.name,
            validator: (value) => (value == null || value.isEmpty)
                ? 'full name is required'
                : null,
          ),
          16.h.verticalSpace,

          // Card Number Field
          AppTextField(
            controller: cardNumberController,
            label: 'card number',
            keyboardType: TextInputType.number,
            hintText: '1234 1234 1234 1234',
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(16),
              CardNumberInputFormatter(),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'card number is required';
              }
              if (value.length < 16) return 'card number must be 16 digits';
              return null;
            },
          ),
          16.h.verticalSpace,

          // Expiry Month, Year, and CVC
          Row(
            children: [
              Expanded(
                child: AppDropdownField<int>(
                  controller: expiryMonthController,
                  label: 'expires',
                  hintText: 'month',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                  items: months,
                  itemLabel: (item) => item.toString().padLeft(2, '0'),
                  selectedItem: months.first,
                  onItemSelected: (item) =>
                      expiryMonthController.text = item.toString(),
                ),
              ),
              8.w.horizontalSpace,
              Expanded(
                child: AppDropdownField<int>(
                  controller: expiryYearController,
                  label: 'year',
                  hintText: 'year',
                  items: years,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                  itemLabel: (item) => item.toString(),
                  selectedItem: years.first,
                  onItemSelected: (item) =>
                      expiryYearController.text = item.toString(),
                ),
              ),
              16.w.horizontalSpace,
              Expanded(
                child: AppTextField(
                  label: 'cvc',
                  hintText: '123',
                  controller: cvcController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'cvc is required';
                    }
                    if (value.length < 3) return 'cvc must be 3 digits';
                    return null;
                  },
                ),
              ),
            ],
          ),
          16.h.verticalSpace,

          // Add to Wallet Button
          SizedBox(
            width: context.width,
            child: PrimaryButton(
              isLoading: isLoading,
              text: "add to wallet",
              onPressed: () => _addToWallet(),
            ),
          ),
          16.h.verticalSpace,
        ],
      ),
    );
  }

  Future<void> _addToWallet() async {
    if (formKey.currentState?.validate() ?? false) {
      var result = CreditCardResult(
        cardNumber: cardNumberController.text.replaceAll(' ', ''),
        cvc: cvcController.text,
        cardHolderName: cardHolderNameController.text,
        expirationMonth: expiryMonthController.text,
        expirationYear: expiryYearController.text,
      );
      walletStore.createCard(result);
    }
  }
}
