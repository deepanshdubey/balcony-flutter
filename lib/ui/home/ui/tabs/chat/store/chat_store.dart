import 'dart:io';
import 'dart:math';

import 'package:balcony/core/locator/locator.dart';
import 'package:balcony/data/model/response/common_data.dart';
import 'package:balcony/data/model/response/property_data.dart';
import 'package:balcony/data/model/response/workspace_data.dart';
import 'package:balcony/data/repository/chat_repository.dart';
import 'package:balcony/data/repository/property_repository.dart';
import 'package:balcony/data/repository/tenant_repository.dart';
import 'package:mobx/mobx.dart';

part 'chat_store.g.dart';

class ChatStore = _ChatStoreBase with _$ChatStore;

abstract class _ChatStoreBase with Store {
  @observable
  CommonData? allConversationResponse;

  @observable
  CommonData? allMsgResponse;

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
}
