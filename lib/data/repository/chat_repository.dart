import 'dart:io';
import 'package:homework/core/api/api_response/api_response.dart';
import 'package:homework/core/locator/locator.dart';
import 'package:homework/data/model/response/common_data.dart';
import 'package:homework/data/model/response/coversation_response.dart';
import 'package:homework/data/model/response/create_msg_response.dart';



abstract class ChatRepository {
  Future<ApiResponse<CommonData>> getAllConversations();
  Future<ApiResponse<CoversationResponse>> startConversation(Map<String, dynamic> request);
  Future<ApiResponse<CommonData>> getAllMsg(String conversationId);
  Future<ApiResponse<CreateMsgResponse>> createMessage(String conversationId, String? text, File? media);
  Future<ApiResponse<CreateMsgResponse>> createMessageV2(Map<String, dynamic> request);
}

final chatRepository = locator<ChatRepository>();
