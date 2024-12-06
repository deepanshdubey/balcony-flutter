import 'dart:io';

import 'package:balcony/core/api/api_response/api_response.dart';
import 'package:balcony/data/model/response/common_data.dart';
import 'package:balcony/data/model/response/coversation_response.dart';
import 'package:balcony/data/model/response/create_msg_response.dart';
import 'package:balcony/data/remote/api_client.dart';
import 'package:balcony/data/repository/chat_repository.dart';
import 'package:balcony/data/repository_impl/base_repository_impl.dart';

class ChatRepositoryImpl extends BaseRepositoryImpl implements ChatRepository {
  final ApiClient apiClient;

  ChatRepositoryImpl(this.apiClient);

  @override
  Future<ApiResponse<CommonData>> getAllConversations() {
    return execute(apiClient.getAllConversations());
  } 
  
  @override
    Future<ApiResponse<CoversationResponse>> startConversation(Map<String, dynamic> request) {
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
        ? apiClient.createMessageWithMedia(conversationId, media)
        : apiClient.createMessage(conversationId, text ?? ""));
  }
}
