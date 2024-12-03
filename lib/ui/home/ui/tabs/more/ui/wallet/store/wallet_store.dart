import 'package:balcony/core/locator/locator.dart';
import 'package:balcony/data/model/response/card_data.dart';
import 'package:balcony/data/model/response/common_data.dart';
import 'package:balcony/data/repository/wallet_repository.dart';
import 'package:credit_card_form/credit_card_form.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:mobx/mobx.dart';

part 'wallet_store.g.dart';

class WalletStore = _WalletStoreBase with _$WalletStore;

abstract class _WalletStoreBase with Store {
  @observable
  List<CardData>? cardsResponse;

  @observable
  CommonData? createCardResponse;

  @observable
  CommonData? updateCardResponse;

  @observable
  CommonData? setDefaultCardResponse;

  @observable
  CommonData? deleteCardResponse;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future getCards() async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await walletRepository.getAllCards();
      if (response.isSuccess) {
        cardsResponse = response.data?.cards ?? [];
      } else {
        errorMessage = response.error?.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future createCard(CreditCardResult cardResult) async {
    try {
      errorMessage = null;
      isLoading = true;

      // Generate Stripe token
      String? token = await _generateStripeToken(cardResult);
      if (token == null) {
        errorMessage = "Failed to generate Stripe token.";
        return;
      }
      final response =
          await walletRepository.createCard({"stripeToken": token});
      if (response.isSuccess) {
        createCardResponse = response.data;
        getCards();
      } else {
        errorMessage = response.error?.message;
      }
    } on stripe.StripeException catch (e) {
      errorMessage = e.error.message;
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  Future<String?> _generateStripeToken(CreditCardResult result) async {
    stripe.CardTokenParams cardParams = stripe.CardTokenParams(
      type: stripe.TokenType.Card,
      name: result.cardHolderName,
    );

    await stripe.Stripe.instance
        .dangerouslyUpdateCardDetails(stripe.CardDetails(
      number: result.cardNumber,
      cvc: result.cvc,
      expirationMonth: int.tryParse(result.expirationMonth),
      expirationYear: int.tryParse(result.expirationYear),
    ));

    stripe.TokenData token = await stripe.Stripe.instance.createToken(
      stripe.CreateTokenParams.card(params: cardParams),
    );
    logger.i("Flutter Stripe token  ${token.toJson()}");
    return token.id;
  }

  @action
  Future updateCard(String id, Map<String, dynamic> request) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await walletRepository.updateCard(id, request);
      if (response.isSuccess) {
        createCardResponse = response.data;
      } else {
        errorMessage = response.error?.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future setDefaultCard(String id) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await walletRepository.setDefaultCard(id);
      if (response.isSuccess) {
        setDefaultCardResponse = response.data;
      } else {
        errorMessage = response.error?.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future deleteCard(String id) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await walletRepository.deleteCard(id);
      if (response.isSuccess) {
        getCards();
        deleteCardResponse = response.data;
      } else {
        errorMessage = response.error?.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }
}

final walletStore = locator<WalletStore>();
