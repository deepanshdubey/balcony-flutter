import 'package:balcony/core/locator/locator.dart';
import 'package:balcony/data/model/response/card_data.dart';
import 'package:balcony/data/model/response/common_data.dart';
import 'package:balcony/data/repository/wallet_repository.dart';
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
  Future createCard(Map<String, dynamic> request) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await walletRepository.createCard(request);
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
  Future updateCard(String id, Map<String, dynamic> request) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await walletRepository.updateCard(id, request);
      if (response.isSuccess) {
        updateCardResponse = response.data;
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
