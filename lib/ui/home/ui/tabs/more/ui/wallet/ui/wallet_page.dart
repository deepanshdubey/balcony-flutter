import 'package:balcony/values/extensions/context_ext.dart';
import 'package:balcony/widget/app_back_button.dart';
import 'package:balcony/widget/app_text_field.dart';
import 'package:balcony/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expireController = TextEditingController();
  TextEditingController cvcController = TextEditingController();
  final ValueNotifier<String> selectedOption = ValueNotifier<String>("Card");

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: AppBackButton(
            text: "back to menu",
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        Container(
          height: context.height * .6,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
              border: Border.all(color: Colors.black.withOpacity(.25))),
          child: ListView(
            children: [
              20.verticalSpace,
              _buildPaymentMethodSection(),
              const SizedBox(height: 16),
              ValueListenableBuilder<String>(
                valueListenable: selectedOption,
                builder: (context, value, _) {
                  if (value == "Card") {
                    return _buildSavedCardsSection();
                  } else if (value == "Add Card") {
                    return _buildAddCardSection();
                  }
                  return const SizedBox
                      .shrink(); // Default view if nothing is selected
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Wallet',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 23.spMin,
                ),
          ),
          4.verticalSpace,
          Text(
            'Add a new payment method to your wallet.',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 13.spMin,
                ),
          ),
          20.verticalSpace,
          Row(
            children: [
              _buildPaymentOption("Card", Icons.credit_card),
              const SizedBox(width: 16),
              _buildPaymentOption("PayPal", Icons.paypal),
              const SizedBox(width: 16),
              _buildPaymentOption("Add Card", Icons.add),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String option, IconData icon) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          selectedOption.value = option; // Update the selected option
        },
        child: ValueListenableBuilder<String>(
          valueListenable: selectedOption,
          builder: (context, value, _) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8).r,
                border: Border.all(
                  color:
                      value == option ? const Color(0xff00695C) : Colors.grey,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon,
                      size: 28,
                      color: value == option
                          ? const Color(0xff00695C)
                          : Colors.grey),
                  12.verticalSpace,
                  Text(
                    option,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 12.spMin,
                          color: value == option
                              ? const Color(0xff00695C)
                              : Colors.grey,
                        ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSavedCardsSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'No card yet!',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.spMin,
                ),
          ),
          // const SizedBox(height: 12),
          // _buildCardInfo("John Doe", "**** **** **** 1234"),
          // _buildCardInfo("John Doe", "**** **** **** 5678"),
        ],
      ),
    );
  }

  Widget _buildAddCardSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            label: 'Full Name',
            hintText: "Full Name",
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            controller: nameController,
          ),
          20.verticalSpace,
          AppTextField(
            label: 'Card number',
            hintText: "XXXX XXXX XXXX XXXX",
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            controller: cardNumberController,
          ),
          20.verticalSpace,
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  label: 'Expires',
                  hintText: "MM/YY",
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  controller: expireController,
                ),
              ),
              20.horizontalSpace,
              Expanded(
                child: AppTextField(
                  label: 'CVV',
                  hintText: "XXX",
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  controller: cvcController,
                ),
              ),
            ],
          ),
          20.verticalSpace,
          PrimaryButton(
            text: "Add to wallet",
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildCardInfo(String name, String cardNumber) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Name: $name",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 12.spMin,
                  ),
            ),
            Text(
              cardNumber,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.spMin,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: () {}, child: const Text("Edit")),
            TextButton(onPressed: () {}, child: const Text("Delete")),
          ],
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildTextField(
      String label, String hintText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
