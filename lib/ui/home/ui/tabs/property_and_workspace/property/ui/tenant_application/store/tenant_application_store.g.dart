// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_application_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TenantApplicationStore on _TenantApplicationStoreBase, Store {
  late final _$isLoadingApplicationFeeAtom = Atom(
      name: '_TenantApplicationStoreBase.isLoadingApplicationFee',
      context: context);

  @override
  bool get isLoadingApplicationFee {
    _$isLoadingApplicationFeeAtom.reportRead();
    return super.isLoadingApplicationFee;
  }

  @override
  set isLoadingApplicationFee(bool value) {
    _$isLoadingApplicationFeeAtom
        .reportWrite(value, super.isLoadingApplicationFee, () {
      super.isLoadingApplicationFee = value;
    });
  }

  late final _$isApplyingForTenancyAtom = Atom(
      name: '_TenantApplicationStoreBase.isApplyingForTenancy',
      context: context);

  @override
  bool get isApplyingForTenancy {
    _$isApplyingForTenancyAtom.reportRead();
    return super.isApplyingForTenancy;
  }

  @override
  set isApplyingForTenancy(bool value) {
    _$isApplyingForTenancyAtom.reportWrite(value, super.isApplyingForTenancy,
        () {
      super.isApplyingForTenancy = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_TenantApplicationStoreBase.errorMessage', context: context);

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

  late final _$applicationFeeResponseAtom = Atom(
      name: '_TenantApplicationStoreBase.applicationFeeResponse',
      context: context);

  @override
  num get applicationFeeResponse {
    _$applicationFeeResponseAtom.reportRead();
    return super.applicationFeeResponse;
  }

  @override
  set applicationFeeResponse(num value) {
    _$applicationFeeResponseAtom
        .reportWrite(value, super.applicationFeeResponse, () {
      super.applicationFeeResponse = value;
    });
  }

  late final _$shouldVerifyIdAtom = Atom(
      name: '_TenantApplicationStoreBase.shouldVerifyId', context: context);

  @override
  bool get shouldVerifyId {
    _$shouldVerifyIdAtom.reportRead();
    return super.shouldVerifyId;
  }

  @override
  set shouldVerifyId(bool value) {
    _$shouldVerifyIdAtom.reportWrite(value, super.shouldVerifyId, () {
      super.shouldVerifyId = value;
    });
  }

  late final _$shouldVerifyBankAtom = Atom(
      name: '_TenantApplicationStoreBase.shouldVerifyBank', context: context);

  @override
  bool get shouldVerifyBank {
    _$shouldVerifyBankAtom.reportRead();
    return super.shouldVerifyBank;
  }

  @override
  set shouldVerifyBank(bool value) {
    _$shouldVerifyBankAtom.reportWrite(value, super.shouldVerifyBank, () {
      super.shouldVerifyBank = value;
    });
  }

  late final _$isBankVerifiedAtom = Atom(
      name: '_TenantApplicationStoreBase.isBankVerified', context: context);

  @override
  bool? get isBankVerified {
    _$isBankVerifiedAtom.reportRead();
    return super.isBankVerified;
  }

  @override
  set isBankVerified(bool? value) {
    _$isBankVerifiedAtom.reportWrite(value, super.isBankVerified, () {
      super.isBankVerified = value;
    });
  }

  late final _$isIdVerifiedAtom =
      Atom(name: '_TenantApplicationStoreBase.isIdVerified', context: context);

  @override
  bool? get isIdVerified {
    _$isIdVerifiedAtom.reportRead();
    return super.isIdVerified;
  }

  @override
  set isIdVerified(bool? value) {
    _$isIdVerifiedAtom.reportWrite(value, super.isIdVerified, () {
      super.isIdVerified = value;
    });
  }

  late final _$applyTenantResponseAtom = Atom(
      name: '_TenantApplicationStoreBase.applyTenantResponse',
      context: context);

  @override
  CommonData? get applyTenantResponse {
    _$applyTenantResponseAtom.reportRead();
    return super.applyTenantResponse;
  }

  @override
  set applyTenantResponse(CommonData? value) {
    _$applyTenantResponseAtom.reportWrite(value, super.applyTenantResponse, () {
      super.applyTenantResponse = value;
    });
  }

  late final _$isLoadingCardAtom =
      Atom(name: '_TenantApplicationStoreBase.isLoadingCard', context: context);

  @override
  bool get isLoadingCard {
    _$isLoadingCardAtom.reportRead();
    return super.isLoadingCard;
  }

  @override
  set isLoadingCard(bool value) {
    _$isLoadingCardAtom.reportWrite(value, super.isLoadingCard, () {
      super.isLoadingCard = value;
    });
  }

  late final _$defaultCardAtom =
      Atom(name: '_TenantApplicationStoreBase.defaultCard', context: context);

  @override
  CardData? get defaultCard {
    _$defaultCardAtom.reportRead();
    return super.defaultCard;
  }

  @override
  set defaultCard(CardData? value) {
    _$defaultCardAtom.reportWrite(value, super.defaultCard, () {
      super.defaultCard = value;
    });
  }

  late final _$getPropertyApplicationFeeAsyncAction = AsyncAction(
      '_TenantApplicationStoreBase.getPropertyApplicationFee',
      context: context);

  @override
  Future<dynamic> getPropertyApplicationFee({required String id}) {
    return _$getPropertyApplicationFeeAsyncAction
        .run(() => super.getPropertyApplicationFee(id: id));
  }

  late final _$applyForTenancyAsyncAction = AsyncAction(
      '_TenantApplicationStoreBase.applyForTenancy',
      context: context);

  @override
  Future<dynamic> applyForTenancy(Map<String, dynamic> request,
      {String? verificationType}) {
    return _$applyForTenancyAsyncAction.run(() =>
        super.applyForTenancy(request, verificationType: verificationType));
  }

  late final _$onCountrySelectedAsyncAction = AsyncAction(
      '_TenantApplicationStoreBase.onCountrySelected',
      context: context);

  @override
  Future<dynamic> onCountrySelected(String country) {
    return _$onCountrySelectedAsyncAction
        .run(() => super.onCountrySelected(country));
  }

  late final _$getCardsAsyncAction =
      AsyncAction('_TenantApplicationStoreBase.getCards', context: context);

  @override
  Future<dynamic> getCards() {
    return _$getCardsAsyncAction.run(() => super.getCards());
  }

  late final _$_TenantApplicationStoreBaseActionController =
      ActionController(name: '_TenantApplicationStoreBase', context: context);

  @override
  void _onSuccess(LinkSuccess event) {
    final _$actionInfo = _$_TenantApplicationStoreBaseActionController
        .startAction(name: '_TenantApplicationStoreBase._onSuccess');
    try {
      return super._onSuccess(event);
    } finally {
      _$_TenantApplicationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _onExit(LinkExit event) {
    final _$actionInfo = _$_TenantApplicationStoreBaseActionController
        .startAction(name: '_TenantApplicationStoreBase._onExit');
    try {
      return super._onExit(event);
    } finally {
      _$_TenantApplicationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoadingApplicationFee: ${isLoadingApplicationFee},
isApplyingForTenancy: ${isApplyingForTenancy},
errorMessage: ${errorMessage},
applicationFeeResponse: ${applicationFeeResponse},
shouldVerifyId: ${shouldVerifyId},
shouldVerifyBank: ${shouldVerifyBank},
isBankVerified: ${isBankVerified},
isIdVerified: ${isIdVerified},
applyTenantResponse: ${applyTenantResponse},
isLoadingCard: ${isLoadingCard},
defaultCard: ${defaultCard}
    ''';
  }
}
