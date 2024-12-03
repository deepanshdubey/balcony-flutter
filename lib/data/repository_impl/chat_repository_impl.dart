
import 'package:balcony/core/api/api_response/api_response.dart';
import 'package:balcony/data/model/response/common_data.dart';
import 'package:balcony/data/model/response/pagination_data.dart';
import 'package:balcony/data/model/response/promo_list_model.dart';
import 'package:balcony/data/model/response/promo_model.dart';
import 'package:balcony/data/model/response/property_data.dart';
import 'package:balcony/data/model/response/workspace_data.dart';
import 'package:balcony/data/remote/api_client.dart';
import 'package:balcony/data/repository/chat_repository.dart';
import 'package:balcony/data/repository/promo_repository.dart';
import 'package:balcony/data/repository/property_repository.dart';
import 'package:balcony/data/repository/workspace_repository.dart';
import 'package:balcony/data/repository_impl/base_repository_impl.dart';

class ChatRepositoryImpl extends BaseRepositoryImpl
    implements ChatRepository {
  final ApiClient apiClient;

  ChatRepositoryImpl(this.apiClient);


  @override
  Future<ApiResponse<CommonData>> getAllConversations() {
    return execute(apiClient.getAllConversations());
  }

  @override
  Future<ApiResponse<CommonData>> getAllMsg(String conversationId) {
    return execute(apiClient.getAllMessage(conversationId));
  }




}