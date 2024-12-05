import 'dart:io';
import 'package:balcony/core/api/api_response/api_response.dart';
import 'package:balcony/core/locator/locator.dart';
import 'package:balcony/data/model/response/common_data.dart';



abstract class ChatRepository {
  Future<ApiResponse<CommonData>> getAllConversations();
  Future<ApiResponse<CommonData>> getAllMsg(String conversationId);
  Future<ApiResponse<CommonData>> createMessage(String conversationId, String? text, File? media);
}

final chatRepository = locator<ChatRepository>();
