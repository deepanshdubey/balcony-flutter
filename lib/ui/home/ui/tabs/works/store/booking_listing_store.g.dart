// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_listing_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BookingListingStore on _BookingListingStoreBase, Store {
  late final _$bookingsInProgressAtom = Atom(
      name: '_BookingListingStoreBase.bookingsInProgress', context: context);

  @override
  List<BookingsData>? get bookingsInProgress {
    _$bookingsInProgressAtom.reportRead();
    return super.bookingsInProgress;
  }

  @override
  set bookingsInProgress(List<BookingsData>? value) {
    _$bookingsInProgressAtom.reportWrite(value, super.bookingsInProgress, () {
      super.bookingsInProgress = value;
    });
  }

  late final _$cancelBookingResponseAtom = Atom(
      name: '_BookingListingStoreBase.cancelBookingResponse', context: context);

  @override
  CommonData? get cancelBookingResponse {
    _$cancelBookingResponseAtom.reportRead();
    return super.cancelBookingResponse;
  }

  @override
  set cancelBookingResponse(CommonData? value) {
    _$cancelBookingResponseAtom.reportWrite(value, super.cancelBookingResponse,
        () {
      super.cancelBookingResponse = value;
    });
  }

  late final _$pastBookingsAtom =
      Atom(name: '_BookingListingStoreBase.pastBookings', context: context);

  @override
  List<BookingsData>? get pastBookings {
    _$pastBookingsAtom.reportRead();
    return super.pastBookings;
  }

  @override
  set pastBookings(List<BookingsData>? value) {
    _$pastBookingsAtom.reportWrite(value, super.pastBookings, () {
      super.pastBookings = value;
    });
  }

  late final _$awaitingTenantAtom =
      Atom(name: '_BookingListingStoreBase.awaitingTenant', context: context);

  @override
  List<Tenants>? get awaitingTenant {
    _$awaitingTenantAtom.reportRead();
    return super.awaitingTenant;
  }

  @override
  set awaitingTenant(List<Tenants>? value) {
    _$awaitingTenantAtom.reportWrite(value, super.awaitingTenant, () {
      super.awaitingTenant = value;
    });
  }

  late final _$rantingTenantAtom =
      Atom(name: '_BookingListingStoreBase.rantingTenant', context: context);

  @override
  List<Tenants>? get rantingTenant {
    _$rantingTenantAtom.reportRead();
    return super.rantingTenant;
  }

  @override
  set rantingTenant(List<Tenants>? value) {
    _$rantingTenantAtom.reportWrite(value, super.rantingTenant, () {
      super.rantingTenant = value;
    });
  }

  late final _$historyTenantAtom =
      Atom(name: '_BookingListingStoreBase.historyTenant', context: context);

  @override
  List<Tenants>? get historyTenant {
    _$historyTenantAtom.reportRead();
    return super.historyTenant;
  }

  @override
  set historyTenant(List<Tenants>? value) {
    _$historyTenantAtom.reportWrite(value, super.historyTenant, () {
      super.historyTenant = value;
    });
  }

  late final _$bookingDetailsAtom =
      Atom(name: '_BookingListingStoreBase.bookingDetails', context: context);

  @override
  BookingsData? get bookingDetails {
    _$bookingDetailsAtom.reportRead();
    return super.bookingDetails;
  }

  @override
  set bookingDetails(BookingsData? value) {
    _$bookingDetailsAtom.reportWrite(value, super.bookingDetails, () {
      super.bookingDetails = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_BookingListingStoreBase.isLoading', context: context);

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
      Atom(name: '_BookingListingStoreBase.errorMessage', context: context);

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

  late final _$getOngoingBookingsAsyncAction = AsyncAction(
      '_BookingListingStoreBase.getOngoingBookings',
      context: context);

  @override
  Future<dynamic> getOngoingBookings() {
    return _$getOngoingBookingsAsyncAction
        .run(() => super.getOngoingBookings());
  }

  late final _$getPastBookingsAsyncAction =
      AsyncAction('_BookingListingStoreBase.getPastBookings', context: context);

  @override
  Future<dynamic> getPastBookings() {
    return _$getPastBookingsAsyncAction.run(() => super.getPastBookings());
  }

  late final _$getAwaitingTenantAsyncAction = AsyncAction(
      '_BookingListingStoreBase.getAwaitingTenant',
      context: context);

  @override
  Future<dynamic> getAwaitingTenant() {
    return _$getAwaitingTenantAsyncAction.run(() => super.getAwaitingTenant());
  }

  late final _$getRantingTenantAsyncAction = AsyncAction(
      '_BookingListingStoreBase.getRantingTenant',
      context: context);

  @override
  Future<dynamic> getRantingTenant() {
    return _$getRantingTenantAsyncAction.run(() => super.getRantingTenant());
  }

  late final _$getHistoryTenantAsyncAction = AsyncAction(
      '_BookingListingStoreBase.getHistoryTenant',
      context: context);

  @override
  Future<dynamic> getHistoryTenant() {
    return _$getHistoryTenantAsyncAction.run(() => super.getHistoryTenant());
  }

  late final _$getBookingDetailsAsyncAction = AsyncAction(
      '_BookingListingStoreBase.getBookingDetails',
      context: context);

  @override
  Future<dynamic> getBookingDetails(String id) {
    return _$getBookingDetailsAsyncAction
        .run(() => super.getBookingDetails(id));
  }

  late final _$cancelBookingAsyncAction =
      AsyncAction('_BookingListingStoreBase.cancelBooking', context: context);

  @override
  Future<dynamic> cancelBooking(String id, bool isHost) {
    return _$cancelBookingAsyncAction
        .run(() => super.cancelBooking(id, isHost));
  }

  @override
  String toString() {
    return '''
bookingsInProgress: ${bookingsInProgress},
cancelBookingResponse: ${cancelBookingResponse},
pastBookings: ${pastBookings},
awaitingTenant: ${awaitingTenant},
rantingTenant: ${rantingTenant},
historyTenant: ${historyTenant},
bookingDetails: ${bookingDetails},
isLoading: ${isLoading},
errorMessage: ${errorMessage}
    ''';
  }
}
