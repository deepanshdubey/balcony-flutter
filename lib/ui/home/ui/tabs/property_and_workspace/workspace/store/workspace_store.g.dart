// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WorkspaceStore on _WorkspaceStoreBase, Store {
  Computed<num>? _$totalFeeComputed;

  @override
  num get totalFee =>
      (_$totalFeeComputed ??= Computed<num>(() => super.totalFee,
              name: '_WorkspaceStoreBase.totalFee'))
          .value;

  late final _$totalPagesAtom =
      Atom(name: '_WorkspaceStoreBase.totalPages', context: context);

  @override
  int get totalPages {
    _$totalPagesAtom.reportRead();
    return super.totalPages;
  }

  @override
  set totalPages(int value) {
    _$totalPagesAtom.reportWrite(value, super.totalPages, () {
      super.totalPages = value;
    });
  }

  late final _$isBookingAcceptedAtom =
      Atom(name: '_WorkspaceStoreBase.isBookingAccepted', context: context);

  @override
  bool? get isBookingAccepted {
    _$isBookingAcceptedAtom.reportRead();
    return super.isBookingAccepted;
  }

  @override
  set isBookingAccepted(bool? value) {
    _$isBookingAcceptedAtom.reportWrite(value, super.isBookingAccepted, () {
      super.isBookingAccepted = value;
    });
  }

  late final _$workspaceResponseAtom =
      Atom(name: '_WorkspaceStoreBase.workspaceResponse', context: context);

  @override
  List<WorkspaceData>? get workspaceResponse {
    _$workspaceResponseAtom.reportRead();
    return super.workspaceResponse;
  }

  @override
  set workspaceResponse(List<WorkspaceData>? value) {
    _$workspaceResponseAtom.reportWrite(value, super.workspaceResponse, () {
      super.workspaceResponse = value;
    });
  }

  late final _$bookingsResponseAtom =
      Atom(name: '_WorkspaceStoreBase.bookingsResponse', context: context);

  @override
  List<BookingsData>? get bookingsResponse {
    _$bookingsResponseAtom.reportRead();
    return super.bookingsResponse;
  }

  @override
  set bookingsResponse(List<BookingsData>? value) {
    _$bookingsResponseAtom.reportWrite(value, super.bookingsResponse, () {
      super.bookingsResponse = value;
    });
  }

  late final _$searchWorkspaceResponseAtom = Atom(
      name: '_WorkspaceStoreBase.searchWorkspaceResponse', context: context);

  @override
  List<WorkspaceData>? get searchWorkspaceResponse {
    _$searchWorkspaceResponseAtom.reportRead();
    return super.searchWorkspaceResponse;
  }

  @override
  set searchWorkspaceResponse(List<WorkspaceData>? value) {
    _$searchWorkspaceResponseAtom
        .reportWrite(value, super.searchWorkspaceResponse, () {
      super.searchWorkspaceResponse = value;
    });
  }

  late final _$workspaceDetailsResponseAtom = Atom(
      name: '_WorkspaceStoreBase.workspaceDetailsResponse', context: context);

  @override
  WorkspaceData? get workspaceDetailsResponse {
    _$workspaceDetailsResponseAtom.reportRead();
    return super.workspaceDetailsResponse;
  }

  @override
  set workspaceDetailsResponse(WorkspaceData? value) {
    _$workspaceDetailsResponseAtom
        .reportWrite(value, super.workspaceDetailsResponse, () {
      super.workspaceDetailsResponse = value;
    });
  }

  late final _$createWorkSpaceDetailsResponseAtom = Atom(
      name: '_WorkspaceStoreBase.createWorkSpaceDetailsResponse',
      context: context);

  @override
  CommonData? get createWorkSpaceDetailsResponse {
    _$createWorkSpaceDetailsResponseAtom.reportRead();
    return super.createWorkSpaceDetailsResponse;
  }

  @override
  set createWorkSpaceDetailsResponse(CommonData? value) {
    _$createWorkSpaceDetailsResponseAtom
        .reportWrite(value, super.createWorkSpaceDetailsResponse, () {
      super.createWorkSpaceDetailsResponse = value;
    });
  }

  late final _$workspaceStatusResponseAtom = Atom(
      name: '_WorkspaceStoreBase.workspaceStatusResponse', context: context);

  @override
  CommonData? get workspaceStatusResponse {
    _$workspaceStatusResponseAtom.reportRead();
    return super.workspaceStatusResponse;
  }

  @override
  set workspaceStatusResponse(CommonData? value) {
    _$workspaceStatusResponseAtom
        .reportWrite(value, super.workspaceStatusResponse, () {
      super.workspaceStatusResponse = value;
    });
  }

  late final _$createBookingResponseAtom =
      Atom(name: '_WorkspaceStoreBase.createBookingResponse', context: context);

  @override
  CommonData? get createBookingResponse {
    _$createBookingResponseAtom.reportRead();
    return super.createBookingResponse;
  }

  @override
  set createBookingResponse(CommonData? value) {
    _$createBookingResponseAtom.reportWrite(value, super.createBookingResponse,
        () {
      super.createBookingResponse = value;
    });
  }

  late final _$startConversationResponseAtom = Atom(
      name: '_WorkspaceStoreBase.startConversationResponse', context: context);

  @override
  ConversationData? get startConversationResponse {
    _$startConversationResponseAtom.reportRead();
    return super.startConversationResponse;
  }

  @override
  set startConversationResponse(ConversationData? value) {
    _$startConversationResponseAtom
        .reportWrite(value, super.startConversationResponse, () {
      super.startConversationResponse = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_WorkspaceStoreBase.isLoading', context: context);

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

  late final _$isStartingConversationAtom = Atom(
      name: '_WorkspaceStoreBase.isStartingConversation', context: context);

  @override
  bool get isStartingConversation {
    _$isStartingConversationAtom.reportRead();
    return super.isStartingConversation;
  }

  @override
  set isStartingConversation(bool value) {
    _$isStartingConversationAtom
        .reportWrite(value, super.isStartingConversation, () {
      super.isStartingConversation = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_WorkspaceStoreBase.errorMessage', context: context);

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

  late final _$handleBookingAsyncAction =
      AsyncAction('_WorkspaceStoreBase.handleBooking', context: context);

  @override
  Future<void> handleBooking(String id, bool accept) {
    return _$handleBookingAsyncAction
        .run(() => super.handleBooking(id, accept));
  }

  late final _$getWorkspaceAsyncAction =
      AsyncAction('_WorkspaceStoreBase.getWorkspace', context: context);

  @override
  Future<dynamic> getWorkspace(
      {String? status,
      String? sort,
      String? select,
      int? page,
      int? limit,
      bool? includeHost}) {
    return _$getWorkspaceAsyncAction.run(() => super.getWorkspace(
        status: status,
        sort: sort,
        select: select,
        page: page,
        limit: limit,
        includeHost: includeHost));
  }

  late final _$getWorkspaceDetailAsyncAction =
      AsyncAction('_WorkspaceStoreBase.getWorkspaceDetail', context: context);

  @override
  Future<dynamic> getWorkspaceDetail({String? id}) {
    return _$getWorkspaceDetailAsyncAction
        .run(() => super.getWorkspaceDetail(id: id));
  }

  late final _$createWorkSpaceAsyncAction =
      AsyncAction('_WorkspaceStoreBase.createWorkSpace', context: context);

  @override
  Future<dynamic> createWorkSpace(List<File> images, Info info, Pricing pricing,
      Times times, Other other, List<String> amenities) {
    return _$createWorkSpaceAsyncAction.run(() =>
        super.createWorkSpace(images, info, pricing, times, other, amenities));
  }

  late final _$updateWorkspaceAsyncAction =
      AsyncAction('_WorkspaceStoreBase.updateWorkspace', context: context);

  @override
  Future<dynamic> updateWorkspace(String id, List<String> images, Info info,
      Pricing pricing, Times times, Other other, List<String> amenities) {
    return _$updateWorkspaceAsyncAction.run(() => super
        .updateWorkspace(id, images, info, pricing, times, other, amenities));
  }

  late final _$createBookingAsyncAction =
      AsyncAction('_WorkspaceStoreBase.createBooking', context: context);

  @override
  Future<dynamic> createBooking(Map<String, dynamic> request) {
    return _$createBookingAsyncAction.run(() => super.createBooking(request));
  }

  late final _$searchWorkspaceAsyncAction =
      AsyncAction('_WorkspaceStoreBase.searchWorkspace', context: context);

  @override
  Future<dynamic> searchWorkspace(
      {String? id,
      String? place,
      String? checkin,
      String? checkout,
      int? people,
      int? page,
      int? limit,
      String? sort,
      String? select,
      bool? includeHost}) {
    return _$searchWorkspaceAsyncAction.run(() => super.searchWorkspace(
        id: id,
        place: place,
        checkin: checkin,
        checkout: checkout,
        people: people,
        page: page,
        limit: limit,
        sort: sort,
        select: select,
        includeHost: includeHost));
  }

  late final _$getHostWorkspacesAsyncAction =
      AsyncAction('_WorkspaceStoreBase.getHostWorkspaces', context: context);

  @override
  Future<dynamic> getHostWorkspaces() {
    return _$getHostWorkspacesAsyncAction.run(() => super.getHostWorkspaces());
  }

  late final _$updateWorkspaceStatusAsyncAction = AsyncAction(
      '_WorkspaceStoreBase.updateWorkspaceStatus',
      context: context);

  @override
  Future<dynamic> updateWorkspaceStatus(String id, bool status) {
    return _$updateWorkspaceStatusAsyncAction
        .run(() => super.updateWorkspaceStatus(id, status));
  }

  late final _$deleteWorkspaceAsyncAction =
      AsyncAction('_WorkspaceStoreBase.deleteWorkspace', context: context);

  @override
  Future<dynamic> deleteWorkspace(String id) {
    return _$deleteWorkspaceAsyncAction.run(() => super.deleteWorkspace(id));
  }

  late final _$getOngoingBookingsAsyncAction =
      AsyncAction('_WorkspaceStoreBase.getOngoingBookings', context: context);

  @override
  Future<dynamic> getOngoingBookings() {
    return _$getOngoingBookingsAsyncAction
        .run(() => super.getOngoingBookings());
  }

  late final _$getPastBookingsAsyncAction =
      AsyncAction('_WorkspaceStoreBase.getPastBookings', context: context);

  @override
  Future<dynamic> getPastBookings() {
    return _$getPastBookingsAsyncAction.run(() => super.getPastBookings());
  }

  late final _$startConversationAsyncAction =
      AsyncAction('_WorkspaceStoreBase.startConversation', context: context);

  @override
  Future<dynamic> startConversation(
      {required bool isLogin, required String hostId}) {
    return _$startConversationAsyncAction
        .run(() => super.startConversation(isLogin: isLogin, hostId: hostId));
  }

  @override
  String toString() {
    return '''
totalPages: ${totalPages},
isBookingAccepted: ${isBookingAccepted},
workspaceResponse: ${workspaceResponse},
bookingsResponse: ${bookingsResponse},
searchWorkspaceResponse: ${searchWorkspaceResponse},
workspaceDetailsResponse: ${workspaceDetailsResponse},
createWorkSpaceDetailsResponse: ${createWorkSpaceDetailsResponse},
workspaceStatusResponse: ${workspaceStatusResponse},
createBookingResponse: ${createBookingResponse},
startConversationResponse: ${startConversationResponse},
isLoading: ${isLoading},
isStartingConversation: ${isStartingConversation},
errorMessage: ${errorMessage},
totalFee: ${totalFee}
    ''';
  }
}
