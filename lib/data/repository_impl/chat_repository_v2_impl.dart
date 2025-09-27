import 'package:homework/core/api/api_response/api_exception.dart';
import 'package:homework/core/api/api_response/api_response.dart';
import 'package:homework/data/model/response/common_data.dart';
import 'package:homework/data/remote/chat_api_client.dart';
import 'package:homework/data/repository/chat_repository_v2.dart';
import 'package:homework/data/repository_impl/base_repository_impl.dart';

class ChatRepositoryV2Impl extends BaseRepositoryImpl
    implements ChatRepositoryV2 {
  final ChatApiClient api;

  ChatRepositoryV2Impl(this.api);

  @override
  Future<void> deleteConversation<CommonData>(String conversationId) {
    return execute(api.deleteConversation(conversationId));
  }

  @override
  Future<ApiResponse<CommonData>> getContactList({required bool isHost}) {
    return execute(
        isHost ? api.getHostContactList() : api.getUserContactList());
  }

  @override
  Future<ApiResponse<CommonData>> startConversation<CommonData>({
    String? type,
    String? id,
    bool isSupport = false,
    bool isAnonymous = false,
  }) {
    if (isSupport) {
      return execute<CommonData>(
          api.startSupportConversation() as Future<CommonData>);
    }

    if (isAnonymous) {
      return execute<CommonData>(api.startAnonymousConversation({
        "hostId": id,
        "firstName": "John",
        "lastName": "Doe",
        "email": "john.doe@example.com",
        "phone": "+919404509403"
      }) as Future<CommonData>);
    }

    if (type == "host" && id != null) {
      return execute<CommonData>(
          api.startHostConversation(id) as Future<CommonData>);
    } else if (type == "user" && id != null) {
      return execute<CommonData>(
          api.startUserConversation(id) as Future<CommonData>);
    } else {
      return Future.value(ApiResponse<CommonData>(
        error: ApiException(
            statusCode: 400, message: "Invalid conversation parameters"),
      ));
    }
  }
}
