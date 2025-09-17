import 'package:homework/core/api/api_response/api_response.dart';
import 'package:homework/core/locator/locator.dart';
import 'package:homework/data/model/response/common_data.dart';

abstract class ChatRepositoryV2 {
  Future<ApiResponse<CommonData>> getContactList({required bool isHost});

  Future<ApiResponse<CommonData>> startConversation<CommonData>({
    String? type,
    String? id,
    bool isSupport = false,
    bool isAnonymous = false,
  });

  Future<void> deleteConversation<CommonData>(String conversationId);
}

final chatRepositoryV2 = locator<ChatRepositoryV2>();
