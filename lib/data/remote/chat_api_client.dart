import 'package:dio/dio.dart';
import 'package:homework/data/constants.dart';
import 'package:homework/data/model/response/common_data.dart';
import 'package:retrofit/retrofit.dart';

part 'chat_api_client.g.dart';

@RestApi(baseUrl: "${Constants.baseUrl}conversation/")
abstract class ChatApiClient {
  factory ChatApiClient(Dio dio, {String baseUrl}) = _ChatApiClient;

  @GET("user/all")
  Future<CommonData> getUserContactList();

  @GET("host/all")
  Future<CommonData> getHostContactList();

  @POST("start/user/{userId}")
  Future<CommonData> startUserConversation(@Path("userId") String userId);

  @POST("start/host/{hostId}")
  Future<CommonData> startHostConversation(@Path("hostId") String hostId);

  @POST("start/support")
  Future<CommonData> startSupportConversation();

  @POST("start/anonymous")
  Future<CommonData> startAnonymousConversation( @Body() Map<String, dynamic> request);

  @DELETE("{conversationId}")
  Future<void> deleteConversation(
      @Path("conversationId") String conversationId);
}
