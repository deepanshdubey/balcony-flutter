import 'package:homework/data/model/response/card_data.dart';
import 'package:homework/values/extensions/context_ext.dart';
import 'package:homework/widget/app_dropdown_field.dart';
import 'package:homework/widget/app_text_field.dart';
import 'package:homework/widget/primary_button.dart';
import 'package:credit_card_form/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../store/wallet_store.dart';

class EditCardWidget extends StatefulWidget {
  final CardData cardData;

  const EditCardWidget({super.key, required this.cardData});

  @override
  State<EditCardWidget> createState() => _EditCardWidgetState();
}

class _EditCardWidgetState extends State<EditCardWidget> {
  final GlobalKey<FormState> formKey = GlobalKey();
  late TextEditingController cardNumberController;
  late TextEditingController cardHolderNameController;
  late TextEditingController cvcController;
  late TextEditingController expiryMonthController;
  late TextEditingController expiryYearController;

  List<int> months = List.generate(12, (index) => index + 1);
  List<int> years = List.generate(10, (index) =>
  DateTime
      .now()
      .year + index);

  @override
  void initState() {
    super.initState();

    // Initialize controllers
    cardNumberController = TextEditingController(
        text: "**** **** **** ${widget.cardData.cardNumber}");
    cardHolderNameController =
        TextEditingController(text: widget.cardData.name);
    cvcController = TextEditingController(text: "***");
    expiryMonthController =
        TextEditingController(text: widget.cardData.expiry?.split('-')[1]);
    expiryYearController =
        TextEditingController(text: widget.cardData.expiry
            ?.split('-')
            .first);
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
            validator: (value) =>
            (value == null || value.isEmpty)
                ? 'full name is required'
                : null,
          ),
          16.h.verticalSpace,

          // Card Number Field
          AppTextField(
            readOnly: true,
            controller: cardNumberController,
            label: 'card number',
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
                  readOnly: true,
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
                  readOnly: true,
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
                  readOnly: true,
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
              text: "update card",
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
      walletStore.updateCard(widget.cardData.id.toString(), {
      "name": cardHolderNameController.text.trim(),
      "expiry": DateFormat("yyyy-MM-dd").format(DateTime(int.parse(expiryYearController.text), int.parse((expiryMonthController.text))))
      });
    }
  }
}
