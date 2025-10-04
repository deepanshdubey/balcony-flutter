// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promo_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PromoStore on _PromoStoreBase, Store {
  late final _$promoResponseAtom =
      Atom(name: '_PromoStoreBase.promoResponse', context: context);

  @override
  PromoModel? get promoResponse {
    _$promoResponseAtom.reportRead();
    return super.promoResponse;
  }

  @override
  set promoResponse(PromoModel? value) {
    _$promoResponseAtom.reportWrite(value, super.promoResponse, () {
      super.promoResponse = value;
    });
  }

  late final _$createPromoResponseAtom =
      Atom(name: '_PromoStoreBase.createPromoResponse', context: context);

  @override
  PromoModel? get createPromoResponse {
    _$createPromoResponseAtom.reportRead();
    return super.createPromoResponse;
  }

  @override
  set createPromoResponse(PromoModel? value) {
    _$createPromoResponseAtom.reportWrite(value, super.createPromoResponse, () {
      super.createPromoResponse = value;
    });
  }

  late final _$promoListResponseAtom =
      Atom(name: '_PromoStoreBase.promoListResponse', context: context);

  @override
  PromoListModel? get promoListResponse {
    _$promoListResponseAtom.reportRead();
    return super.promoListResponse;
  }

  @override
  set promoListResponse(PromoListModel? value) {
    _$promoListResponseAtom.reportWrite(value, super.promoListResponse, () {
      super.promoListResponse = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_PromoStoreBase.isLoading', context: context);

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
      Atom(name: '_PromoStoreBase.errorMessage', context: context);

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

  late final _$getPromoAsyncAction =
      AsyncAction('_PromoStoreBase.getPromo', context: context);

  @override
  Future<dynamic> getPromo({String? code}) {
    return _$getPromoAsyncAction.run(() => super.getPromo(code: code));
  }

  late final _$createPromoAsyncAction =
      AsyncAction('_PromoStoreBase.createPromo', context: context);

  @override
  Future<dynamic> createPromo({required Map<String, dynamic> request}) {
    return _$createPromoAsyncAction
        .run(() => super.createPromo(request: request));
  }

  late final _$getPromoListAsyncAction =
      AsyncAction('_PromoStoreBase.getPromoList', context: context);

  @override
  Future<dynamic> getPromoList({String? hostId}) {
    return _$getPromoListAsyncAction
        .run(() => super.getPromoList(hostId: hostId));
  }

  @override
  String toString() {
    return '''
promoResponse: ${promoResponse},
createPromoResponse: ${createPromoResponse},
promoListResponse: ${promoListResponse},
isLoading: ${isLoading},
errorMessage: ${errorMessage}
    ''';
  }
}
