// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatStore on _ChatStoreBase, Store {
  late final _$allConversationResponseAtom =
      Atom(name: '_ChatStoreBase.allConversationResponse', context: context);

  @override
  CommonData? get allConversationResponse {
    _$allConversationResponseAtom.reportRead();
    return super.allConversationResponse;
  }

  @override
  set allConversationResponse(CommonData? value) {
    _$allConversationResponseAtom
        .reportWrite(value, super.allConversationResponse, () {
      super.allConversationResponse = value;
    });
  }

  late final _$startConversationResponseAtom =
      Atom(name: '_ChatStoreBase.startConversationResponse', context: context);

  @override
  CommonData? get startConversationResponse {
    _$startConversationResponseAtom.reportRead();
    return super.startConversationResponse;
  }

  @override
  set startConversationResponse(CommonData? value) {
    _$startConversationResponseAtom
        .reportWrite(value, super.startConversationResponse, () {
      super.startConversationResponse = value;
    });
  }

  late final _$allMsgResponseAtom =
      Atom(name: '_ChatStoreBase.allMsgResponse', context: context);

  @override
  CommonData? get allMsgResponse {
    _$allMsgResponseAtom.reportRead();
    return super.allMsgResponse;
  }

  @override
  set allMsgResponse(CommonData? value) {
    _$allMsgResponseAtom.reportWrite(value, super.allMsgResponse, () {
      super.allMsgResponse = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_ChatStoreBase.isLoading', context: context);

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
      Atom(name: '_ChatStoreBase.errorMessage', context: context);

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

  late final _$getAllConversationsAsyncAction =
      AsyncAction('_ChatStoreBase.getAllConversations', context: context);

  @override
  Future<dynamic> getAllConversations(String type) {
    return _$getAllConversationsAsyncAction
        .run(() => super.getAllConversations(type));
  }

  late final _$startConversationsAsyncAction =
      AsyncAction('_ChatStoreBase.startConversations', context: context);

  @override
  Future<dynamic> startConversations(Map<String, dynamic> request) {
    return _$startConversationsAsyncAction
        .run(() => super.startConversations(request));
  }

  late final _$getAllMsgAsyncAction =
      AsyncAction('_ChatStoreBase.getAllMsg', context: context);

  @override
  Future<dynamic> getAllMsg(String conversationId) {
    return _$getAllMsgAsyncAction.run(() => super.getAllMsg(conversationId));
  }

  @override
  String toString() {
    return '''
allConversationResponse: ${allConversationResponse},
startConversationResponse: ${startConversationResponse},
allMsgResponse: ${allMsgResponse},
isLoading: ${isLoading},
errorMessage: ${errorMessage}
    ''';
  }
}
