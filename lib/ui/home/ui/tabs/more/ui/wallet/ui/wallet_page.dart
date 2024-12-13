import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/data/model/response/card_data.dart';
import 'package:homework/ui/home/ui/tabs/more/ui/wallet/store/wallet_store.dart';
import 'package:homework/ui/home/ui/tabs/more/ui/wallet/widget/add_card_widget.dart';
import 'package:homework/ui/home/ui/tabs/more/ui/wallet/widget/card_listing_widget.dart';
import 'package:homework/ui/home/ui/tabs/more/ui/wallet/widget/edit_card_widget.dart';
import 'package:homework/widget/app_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final ValueNotifier<String> selectedOption = ValueNotifier<String>("Card");
  List<ReactionDisposer>? disposers;
  CardData? selectedCard;

  @override
  void initState() {
    super.initState();
    addDisposer();
  }

  @override
  void dispose() {
    removeDisposer();
    super.dispose();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => walletStore.createCardResponse, (response) {
        selectedOption.value = "Card";
      }),
      reaction((_) => walletStore.deleteCardResponse, (response) {
        selectedOption.value = "Card";
      }),
      reaction((_) => walletStore.errorMessage, (String? errorMessage) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.r)),
                  border: Border.all(color: Colors.black.withOpacity(.25))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  20.verticalSpace,
                  _buildPaymentMethodSection(),
                  ValueListenableBuilder<String>(
                    valueListenable: selectedOption,
                    builder: (context, value, _) {
                      if (value == "Card") {
                        walletStore.getCards();
                        return _buildSavedCardsSection();
                      } else if (value == "Add Card") {
                        return AddCardWidget();
                      } else if (value == "Edit Card" && selectedCard != null) {
                        return EditCardWidget(cardData: selectedCard!);
                      }
                      return const SizedBox
                          .shrink(); // Default view if nothing is selected
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
    return Observer(
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
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.spMin,
                          ),
                    ),
                  );
      },
    );
  }
}
