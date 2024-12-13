import 'dart:io';
import 'dart:math';

import 'package:homework/core/locator/locator.dart';
import 'package:homework/data/model/response/common_data.dart';
import 'package:homework/data/model/response/coversation_response.dart';
import 'package:homework/data/model/response/create_msg_response.dart';
import 'package:homework/data/model/response/property_data.dart';
import 'package:homework/data/model/response/workspace_data.dart';
import 'package:homework/data/repository/chat_repository.dart';
import 'package:homework/data/repository/property_repository.dart';
import 'package:homework/data/repository/tenant_repository.dart';
import 'package:mobx/mobx.dart';

part 'chat_store.g.dart';

class ChatStore = _ChatStoreBase with _$ChatStore;

abstract class _ChatStoreBase with Store {
  @observable
  CommonData? allConversationResponse;


  @observable
  CoversationResponse? startConversationResponse;

  @observable
  CommonData? allMsgResponse;


  @observable
  CreateMsgResponse? createMsgResponse;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future getAllConversations() async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await chatRepository.getAllConversations();
      if (response.isSuccess) {
        allConversationResponse = response.data;
      } else {
        errorMessage = response.error!.message;
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
  Future startConversations(Map<String , dynamic> request) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await chatRepository.startConversation(request);
      if (response.isSuccess) {
        startConversationResponse = response.data;
      } else {
        errorMessage = response.error!.message;
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
  Future getAllMsg(String conversationId) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await chatRepository.getAllMsg(conversationId);
      if (response.isSuccess) {
        allMsgResponse = response.data;
      } else {
        errorMessage = response.error!.message;
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
  Future createMsg({File? media, required String conversationId, String? msg}) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await chatRepository.createMessage( conversationId,  msg, media);
      if (response.isSuccess) {
        createMsgResponse = response.data;
      } else {
        errorMessage = response.error!.message;
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
