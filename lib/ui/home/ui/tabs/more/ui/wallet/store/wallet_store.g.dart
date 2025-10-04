// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WalletStore on _WalletStoreBase, Store {
  late final _$cardsResponseAtom =
      Atom(name: '_WalletStoreBase.cardsResponse', context: context);

  @override
  List<CardData>? get cardsResponse {
    _$cardsResponseAtom.reportRead();
    return super.cardsResponse;
  }

  @override
  set cardsResponse(List<CardData>? value) {
    _$cardsResponseAtom.reportWrite(value, super.cardsResponse, () {
      super.cardsResponse = value;
    });
  }

  late final _$createCardResponseAtom =
      Atom(name: '_WalletStoreBase.createCardResponse', context: context);

  @override
  CommonData? get createCardResponse {
    _$createCardResponseAtom.reportRead();
    return super.createCardResponse;
  }

  @override
  set createCardResponse(CommonData? value) {
    _$createCardResponseAtom.reportWrite(value, super.createCardResponse, () {
      super.createCardResponse = value;
    });
  }

  late final _$updateCardResponseAtom =
      Atom(name: '_WalletStoreBase.updateCardResponse', context: context);

  @override
  CommonData? get updateCardResponse {
    _$updateCardResponseAtom.reportRead();
    return super.updateCardResponse;
  }

  @override
  set updateCardResponse(CommonData? value) {
    _$updateCardResponseAtom.reportWrite(value, super.updateCardResponse, () {
      super.updateCardResponse = value;
    });
  }

  late final _$setDefaultCardResponseAtom =
      Atom(name: '_WalletStoreBase.setDefaultCardResponse', context: context);

  @override
  CommonData? get setDefaultCardResponse {
    _$setDefaultCardResponseAtom.reportRead();
    return super.setDefaultCardResponse;
  }

  @override
  set setDefaultCardResponse(CommonData? value) {
    _$setDefaultCardResponseAtom
        .reportWrite(value, super.setDefaultCardResponse, () {
      super.setDefaultCardResponse = value;
    });
  }

  late final _$deleteCardResponseAtom =
      Atom(name: '_WalletStoreBase.deleteCardResponse', context: context);

  @override
  CommonData? get deleteCardResponse {
    _$deleteCardResponseAtom.reportRead();
    return super.deleteCardResponse;
  }

  @override
  set deleteCardResponse(CommonData? value) {
    _$deleteCardResponseAtom.reportWrite(value, super.deleteCardResponse, () {
      super.deleteCardResponse = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_WalletStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_WalletStoreBase.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$getCardsAsyncAction =
      AsyncAction('_WalletStoreBase.getCards', context: context);

  @override
  Future<dynamic> getCards() {
    return _$getCardsAsyncAction.run(() => super.getCards());
  }

  late final _$createCardAsyncAction =
      AsyncAction('_WalletStoreBase.createCard', context: context);

  @override
  Future<dynamic> createCard(CreditCardResult cardResult) {
    return _$createCardAsyncAction.run(() => super.createCard(cardResult));
  }

  late final _$updateCardAsyncAction =
      AsyncAction('_WalletStoreBase.updateCard', context: context);

  @override
  Future<dynamic> updateCard(String id, Map<String, dynamic> request) {
    return _$updateCardAsyncAction.run(() => super.updateCard(id, request));
  }

  late final _$setDefaultCardAsyncAction =
      AsyncAction('_WalletStoreBase.setDefaultCard', context: context);

  @override
  Future<dynamic> setDefaultCard(String id) {
    return _$setDefaultCardAsyncAction.run(() => super.setDefaultCard(id));
  }

  late final _$deleteCardAsyncAction =
      AsyncAction('_WalletStoreBase.deleteCard', context: context);

  @override
  Future<dynamic> deleteCard(String id) {
    return _$deleteCardAsyncAction.run(() => super.deleteCard(id));
  }

  @override
  String toString() {
    return '''
cardsResponse: ${cardsResponse},
createCardResponse: ${createCardResponse},
updateCardResponse: ${updateCardResponse},
setDefaultCardResponse: ${setDefaultCardResponse},
deleteCardResponse: ${deleteCardResponse},
isLoading: ${isLoading},
errorMessage: ${errorMessage}
    ''';
  }
}
