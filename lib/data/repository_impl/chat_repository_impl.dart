import 'dart:io';

import 'package:homework/core/api/api_response/api_response.dart';
import 'package:homework/data/model/response/common_data.dart';
import 'package:homework/data/model/response/create_msg_response.dart';
import 'package:homework/data/remote/api_client.dart';
import 'package:homework/data/repository/chat_repository.dart';
import 'package:homework/data/repository_impl/base_repository_impl.dart';

class ChatRepositoryImpl extends BaseRepositoryImpl implements ChatRepository {
  final ApiClient apiClient;

  ChatRepositoryImpl(this.apiClient);

  @override
  Future<ApiResponse<CommonData>> getAllConversations(String type) {
    return execute(apiClient.getAllConversations(type));
  }

  @override
  Future<ApiResponse<CommonData>> startConversation(
      Map<String, dynamic> request) {
    return execute(apiClient.startConversation(request));
  }

  @override
  Future<ApiResponse<CommonData>> getAllMsg(String conversationId) {
    return execute(apiClient.getAllMessage(conversationId));
  }

  @override
  Future<ApiResponse<CreateMsgResponse>> createMessage(
      String conversationId, String? text, File? media) {
    return execute(media != null
        ? createMessageWithMedia(
            conversationId: conversationId,
            image: media,
          )
        : apiClient.createMessage(conversationId, text ?? ""));
  }

  @override
  Future<ApiResponse<CreateMsgResponse>> createMessageV2(
      Map<String, dynamic> request) {
    return execute(apiClient.createMessageV2(request));
  }
}
