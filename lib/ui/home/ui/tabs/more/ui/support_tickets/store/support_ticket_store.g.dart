// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_ticket_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SupportTicketStore on _SupportTicketStoreBase, Store {
  late final _$supportTicketsResponseAtom = Atom(
      name: '_SupportTicketStoreBase.supportTicketsResponse', context: context);

  @override
  List<SupportTicketData>? get supportTicketsResponse {
    _$supportTicketsResponseAtom.reportRead();
    return super.supportTicketsResponse;
  }

  @override
  set supportTicketsResponse(List<SupportTicketData>? value) {
    _$supportTicketsResponseAtom
        .reportWrite(value, super.supportTicketsResponse, () {
      super.supportTicketsResponse = value;
    });
  }

  late final _$ongoingWorkspacesAtom =
      Atom(name: '_SupportTicketStoreBase.ongoingWorkspaces', context: context);

  @override
  List<WorkspaceData>? get ongoingWorkspaces {
    _$ongoingWorkspacesAtom.reportRead();
    return super.ongoingWorkspaces;
  }

  @override
  set ongoingWorkspaces(List<WorkspaceData>? value) {
    _$ongoingWorkspacesAtom.reportWrite(value, super.ongoingWorkspaces, () {
      super.ongoingWorkspaces = value;
    });
  }

  late final _$createSupportTicketResponseAtom = Atom(
      name: '_SupportTicketStoreBase.createSupportTicketResponse',
      context: context);

  @override
  CommonData? get createSupportTicketResponse {
    _$createSupportTicketResponseAtom.reportRead();
    return super.createSupportTicketResponse;
  }

  @override
  set createSupportTicketResponse(CommonData? value) {
    _$createSupportTicketResponseAtom
        .reportWrite(value, super.createSupportTicketResponse, () {
      super.createSupportTicketResponse = value;
    });
  }

  late final _$replySupportTicketResponseAtom = Atom(
      name: '_SupportTicketStoreBase.replySupportTicketResponse',
      context: context);

  @override
  CommonData? get replySupportTicketResponse {
    _$replySupportTicketResponseAtom.reportRead();
    return super.replySupportTicketResponse;
  }

  @override
  set replySupportTicketResponse(CommonData? value) {
    _$replySupportTicketResponseAtom
        .reportWrite(value, super.replySupportTicketResponse, () {
      super.replySupportTicketResponse = value;
    });
  }

  late final _$closeSupportTicketResponseAtom = Atom(
      name: '_SupportTicketStoreBase.closeSupportTicketResponse',
      context: context);

  @override
  CommonData? get closeSupportTicketResponse {
    _$closeSupportTicketResponseAtom.reportRead();
    return super.closeSupportTicketResponse;
  }

  @override
  set closeSupportTicketResponse(CommonData? value) {
    _$closeSupportTicketResponseAtom
        .reportWrite(value, super.closeSupportTicketResponse, () {
      super.closeSupportTicketResponse = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_SupportTicketStoreBase.isLoading', context: context);

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
      Atom(name: '_SupportTicketStoreBase.errorMessage', context: context);

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

  late final _$getSupportTicketsAsyncAction = AsyncAction(
      '_SupportTicketStoreBase.getSupportTickets',
      context: context);

  @override
  Future<dynamic> getSupportTickets() {
    return _$getSupportTicketsAsyncAction.run(() => super.getSupportTickets());
  }

  late final _$getOnGoingWorkspacesAsyncAction = AsyncAction(
      '_SupportTicketStoreBase.getOnGoingWorkspaces',
      context: context);

  @override
  Future<dynamic> getOnGoingWorkspaces() {
    return _$getOnGoingWorkspacesAsyncAction
        .run(() => super.getOnGoingWorkspaces());
  }

  late final _$createSupportTicketAsyncAction = AsyncAction(
      '_SupportTicketStoreBase.createSupportTicket',
      context: context);

  @override
  Future<dynamic> createSupportTicket(Map<String, dynamic> request) {
    return _$createSupportTicketAsyncAction
        .run(() => super.createSupportTicket(request));
  }

  late final _$replySupportTicketAsyncAction = AsyncAction(
      '_SupportTicketStoreBase.replySupportTicket',
      context: context);

  @override
  Future<dynamic> replySupportTicket(Map<String, dynamic> request) {
    return _$replySupportTicketAsyncAction
        .run(() => super.replySupportTicket(request));
  }

  late final _$closeSupportTicketAsyncAction = AsyncAction(
      '_SupportTicketStoreBase.closeSupportTicket',
      context: context);

  @override
  Future<dynamic> closeSupportTicket(String id) {
    return _$closeSupportTicketAsyncAction
        .run(() => super.closeSupportTicket(id));
  }

  @override
  String toString() {
    return '''
supportTicketsResponse: ${supportTicketsResponse},
ongoingWorkspaces: ${ongoingWorkspaces},
createSupportTicketResponse: ${createSupportTicketResponse},
replySupportTicketResponse: ${replySupportTicketResponse},
closeSupportTicketResponse: ${closeSupportTicketResponse},
isLoading: ${isLoading},
errorMessage: ${errorMessage}
    ''';
  }
}
