// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DashboardStore on _DashboardStoreBase, Store {
  late final _$bookingDatesAtom =
      Atom(name: '_DashboardStoreBase.bookingDates', context: context);

  @override
  ObservableList<String> get bookingDates {
    _$bookingDatesAtom.reportRead();
    return super.bookingDates;
  }

  @override
  set bookingDates(ObservableList<String> value) {
    _$bookingDatesAtom.reportWrite(value, super.bookingDates, () {
      super.bookingDates = value;
    });
  }

  late final _$autoStatusResponseAtom =
      Atom(name: '_DashboardStoreBase.autoStatusResponse', context: context);

  @override
  CommonData? get autoStatusResponse {
    _$autoStatusResponseAtom.reportRead();
    return super.autoStatusResponse;
  }

  @override
  set autoStatusResponse(CommonData? value) {
    _$autoStatusResponseAtom.reportWrite(value, super.autoStatusResponse, () {
      super.autoStatusResponse = value;
    });
  }

  late final _$earningsResponseAtom =
      Atom(name: '_DashboardStoreBase.earningsResponse', context: context);

  @override
  CommonData? get earningsResponse {
    _$earningsResponseAtom.reportRead();
    return super.earningsResponse;
  }

  @override
  set earningsResponse(CommonData? value) {
    _$earningsResponseAtom.reportWrite(value, super.earningsResponse, () {
      super.earningsResponse = value;
    });
  }

  late final _$reAuthenticateResponseAtom = Atom(
      name: '_DashboardStoreBase.reAuthenticateResponse', context: context);

  @override
  CommonData? get reAuthenticateResponse {
    _$reAuthenticateResponseAtom.reportRead();
    return super.reAuthenticateResponse;
  }

  @override
  set reAuthenticateResponse(CommonData? value) {
    _$reAuthenticateResponseAtom
        .reportWrite(value, super.reAuthenticateResponse, () {
      super.reAuthenticateResponse = value;
    });
  }

  late final _$updatePayoutInfoResponseAtom = Atom(
      name: '_DashboardStoreBase.updatePayoutInfoResponse', context: context);

  @override
  String? get updatePayoutInfoResponse {
    _$updatePayoutInfoResponseAtom.reportRead();
    return super.updatePayoutInfoResponse;
  }

  @override
  set updatePayoutInfoResponse(String? value) {
    _$updatePayoutInfoResponseAtom
        .reportWrite(value, super.updatePayoutInfoResponse, () {
      super.updatePayoutInfoResponse = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_DashboardStoreBase.isLoading', context: context);

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
      Atom(name: '_DashboardStoreBase.errorMessage', context: context);

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

  late final _$bulkEmailResponseAtom =
      Atom(name: '_DashboardStoreBase.bulkEmailResponse', context: context);

  @override
  CommonData? get bulkEmailResponse {
    _$bulkEmailResponseAtom.reportRead();
    return super.bulkEmailResponse;
  }

  @override
  set bulkEmailResponse(CommonData? value) {
    _$bulkEmailResponseAtom.reportWrite(value, super.bulkEmailResponse, () {
      super.bulkEmailResponse = value;
    });
  }

  late final _$isSendingBulkEmailAtom =
      Atom(name: '_DashboardStoreBase.isSendingBulkEmail', context: context);

  @override
  bool get isSendingBulkEmail {
    _$isSendingBulkEmailAtom.reportRead();
    return super.isSendingBulkEmail;
  }

  @override
  set isSendingBulkEmail(bool value) {
    _$isSendingBulkEmailAtom.reportWrite(value, super.isSendingBulkEmail, () {
      super.isSendingBulkEmail = value;
    });
  }

  late final _$autoStatusAsyncAction =
      AsyncAction('_DashboardStoreBase.autoStatus', context: context);

  @override
  Future<dynamic> autoStatus({bool? isBooking}) {
    return _$autoStatusAsyncAction
        .run(() => super.autoStatus(isBooking: isBooking));
  }

  late final _$updatePayoutInfoAsyncAction =
      AsyncAction('_DashboardStoreBase.updatePayoutInfo', context: context);

  @override
  Future<dynamic> updatePayoutInfo({bool isWorkspace = true}) {
    return _$updatePayoutInfoAsyncAction
        .run(() => super.updatePayoutInfo(isWorkspace: isWorkspace));
  }

  late final _$getEarningsAsyncAction =
      AsyncAction('_DashboardStoreBase.getEarnings', context: context);

  @override
  Future<dynamic> getEarnings(String hostId, {bool isWorkspace = true}) {
    return _$getEarningsAsyncAction
        .run(() => super.getEarnings(hostId, isWorkspace: isWorkspace));
  }

  late final _$getReAuthenticateAsyncAction =
      AsyncAction('_DashboardStoreBase.getReAuthenticate', context: context);

  @override
  Future<dynamic> getReAuthenticate() {
    return _$getReAuthenticateAsyncAction.run(() => super.getReAuthenticate());
  }

  late final _$getBookingDatesAsyncAction =
      AsyncAction('_DashboardStoreBase.getBookingDates', context: context);

  @override
  Future<dynamic> getBookingDates() {
    return _$getBookingDatesAsyncAction.run(() => super.getBookingDates());
  }

  late final _$sendBulkEmailAsyncAction =
      AsyncAction('_DashboardStoreBase.sendBulkEmail', context: context);

  @override
  Future<dynamic> sendBulkEmail(
      {required String type,
      required List<String> ids,
      required String message}) {
    return _$sendBulkEmailAsyncAction
        .run(() => super.sendBulkEmail(type: type, ids: ids, message: message));
  }

  @override
  String toString() {
    return '''
bookingDates: ${bookingDates},
autoStatusResponse: ${autoStatusResponse},
earningsResponse: ${earningsResponse},
reAuthenticateResponse: ${reAuthenticateResponse},
updatePayoutInfoResponse: ${updatePayoutInfoResponse},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
bulkEmailResponse: ${bulkEmailResponse},
isSendingBulkEmail: ${isSendingBulkEmail}
    ''';
  }
}
