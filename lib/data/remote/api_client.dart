import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:homework/data/constants.dart';
import 'package:homework/data/model/response/common_data.dart';
import 'package:homework/data/model/response/coversation_response.dart';
import 'package:homework/data/model/response/create_msg_response.dart';
import 'package:homework/data/model/response/pagination_data.dart';
import 'package:homework/data/model/response/promo_list_model.dart';
import 'package:homework/data/model/response/promo_model.dart';
import 'package:homework/data/model/response/property_data.dart';
import 'package:homework/data/model/response/subscription_list_model.dart';
import 'package:homework/data/model/response/user_data.dart';
import 'package:homework/ui/concierge/model/add_tenant_model.dart';
import 'package:homework/ui/concierge/model/concierge_property_response.dart';
import 'package:homework/ui/concierge/model/concierge_tanant_response.dart';
import 'package:homework/ui/concierge/model/maintenace_request_response.dart';
import 'package:homework/ui/concierge/model/ongoing_response.dart';
import 'package:homework/ui/concierge/model/parcel_response.dart';
import 'package:http_parser/http_parser.dart';
import 'package:retrofit/retrofit.dart';

import '../model/response/workspace_data.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST("auth/register")
  Future<CommonData> register(@Body() Map<String, dynamic> request);

  @POST("auth/social-auth")
  Future<CommonData> socialAuth(@Body() Map<String, dynamic> request);

  @GET("auth/resend-otp")
  Future<CommonData> resentOtp(@Query("reset") bool isReset);

  @GET("auth/otp-status")
  Future<CommonData> getOtpStatus();

  @POST("auth/verify")
  Future<CommonData> verifyOtp(
      @Field("otp") String otp, @Field("reset") bool isReset);

  @POST("auth/login")
  Future<CommonData> login(@Body() Map<String, dynamic> request);

  @POST("user/delete-account")
  Future<CommonData> deleteAccount(@Body() Map<String, dynamic> request);

  @POST("auth/send-reset-otp")
  Future<CommonData> sendResetOtp(@Body() Map<String, dynamic> request);

  @PUT("auth/update-password")
  Future<CommonData> updatePassword(@Field("password") String newPassword);

  @POST("auth/forgot-password")
  Future<CommonData> forgotPassword(@Body() Map<String, dynamic> request);

  @GET("auth/logout")
  Future<void> logout();

  @GET("/auth/reauthenticate")
  Future<CommonData> reAuthenticate();

  @GET("profile")
  Future<UserData> getProfile();

  @PUT("user/update")
  Future<CommonData> updateProfile(@Body() Map<String, dynamic> request);

  @PUT("user/update")
  @MultiPart()
  Future<CommonData> updateProfileWithImage(
    @Part(name: "firstName") String firstName,
    @Part(name: "lastName") String lastName,
    @Part(name: "email") String email,
    @Part(name: "phone") String phone,
    @Part(name: "image", contentType: "image/*") File image,
  );

  @GET("workspace/all")
  Future<PaginationData<WorkspaceData>> getWorkSpaces(
    @Query("query") String query,
    @Query("page") int? page,
    @Query("limit") int? limit,
    @Query("sort") String? sort,
    @Query("includeHost") bool? includeHost,
  );

  @GET("workspace/all/host/{id}")
  Future<CommonData> getHostWorkspaces(
    @Path("id") String id,
  );

  @GET("property/all/host/{id}")
  Future<CommonData> getHostProperties(
    @Path("id") String id,
  );

  @DELETE("/workspace/delete/{id}")
  Future<CommonData> deleteWorkspace(
    @Path("id") String id,
  );

  @DELETE("/property/delete/{id}")
  Future<CommonData> deleteProperty(
    @Path("id") String id,
  );

  @PUT("/workspace/update-status/{id}")
  Future<CommonData> updateWorkspaceStatus(
    @Path("id") String id,
    @Field("status") String status,
  );

  @PUT("property/update-status/{id}")
  Future<CommonData> updatePropertyStatus(
    @Path("id") String id,
    @Field("status") String status,
  );

  @POST("workspace/create")
  @MultiPart()
  Future<CommonData> createWorkspace(
    @Part(name: "images", contentType: 'image/*') List<MultipartFile> images,
    @Part(name: "info") Info info,
    @Part(name: "pricing") Pricing pricing,
    @Part(name: "times") Times times,
    @Part(name: "other") Other other,
    @Part(name: "amenities") String amenities,
  );

  @PUT("workspace/update/{id}")
  @MultiPart()
  Future<CommonData> editWorkspace(
    @Path("id") String workspaceId,
    @Part(name: "images") List<String> images,
    @Part(name: "info") Info info,
    @Part(name: "pricing") Pricing pricing,
    @Part(name: "times") Times times,
    @Part(name: "other") Other other,
    @Part(name: "amenities") String amenities,
  );

  @GET("property/all")
  Future<PaginationData<PropertyData>> getProperties(
    @Query("query") String? status,
    @Query("sort") String? sort,
    @Query("select") String? select,
    @Query("page") int? page,
    @Query("limit") int? limit,
    @Query("includeHost") bool? includeHost,
  );

  @GET("/workspace/find/{id}")
  Future<PaginationData<WorkspaceData>> getWorkspaceDetails(
    @Path("id") String id,
  );

  @GET("/property/find/{id}")
  Future<PaginationData<PropertyData>> getPropertyDetails(
    @Path("id") String id,
  );

  @POST("property/create")
  @MultiPart()
  Future<CommonData> createProperty(
    @Part(name: "images", contentType: 'image/*') List<MultipartFile> images,
    @Part(name: "floorPlanImages", contentType: 'image/*')
    List<MultipartFile>? floorPlanImages,
    @Part(name: "info") Info info,
    @Part(name: "currency") String currency,
    @Part(name: "unitList") String unitList,
    @Part(name: "other") Map<String, dynamic> other,
    @Part(name: "amenities") String amenities,
    @Part(name: "leasingPolicyDoc") File image,
  );

  @GET("/workspace/search")
  Future<PaginationData<WorkspaceData>> searchWorkspace(
    @Query("place") String? place,
    @Query("checkin") String? checkin,
    @Query("checkout") String? checkout,
    @Query("people") int? people,
    @Query("page") int? page,
    @Query("limit") int? limit,
    @Query("sort") String? sort,
    @Query("select") String? select,
    @Query("includeHost") bool? includeHost,
  );

  @GET("/property/search")
  Future<PaginationData<PropertyData>> searchProperty(
    @Query("place") String? place,
    @Query("beds") int? beds,
    @Query("baths") int? baths,
    @Query("minrange") double? minrange,
    @Query("maxrange") double? maxrange,
    @Query("page") int? page,
    @Query("limit") int? limit,
    @Query("sort") String? sort,
    @Query("select") String? select,
    @Query("includeHost") bool? includeHost,
    @Query("includeUnitList") bool? includeUnitList,
  );

  ///  -- tenant application

  @POST("/tenant/apply")
  Future<CommonData> applyTenant(@Body() Map<String, dynamic> request);

  @PUT("/tenant/update/{id}")
  Future<CommonData> updateTenant(
      @Path("id") String id, @Body() Map<String, dynamic> request);

  @PUT("/tenant/approve/{id}")
  Future<CommonData> approveTenant(
      @Path("id") String id, @Body() Map<String, dynamic> request);

  @GET("/tenant/reject/{id}")
  Future<CommonData> rejectTenant(@Path("id") String id);

  @GET("/tenant/all/host/{id}")
  Future<CommonData> getTenantsByHostId(
    @Path("id") String hostId,
    @Query("status") String? status, // Optional query parameter
  );

  @POST("/tenant/payment")
  Future<CommonData> tenantPayment(@Body() Map<String, dynamic> request);

  /// -- promo --

  @POST("/promo/create")
  Future<PromoModel> createPromo(@Body() Map<String, dynamic> request);

  @GET("/promo/find/{code}")
  Future<PromoModel> getPromoCode(
    @Path("code") String code,
  );

  @GET("/promo/all")
  Future<PromoListModel> getPromoCodeList();

  @GET("promo/all/host/{id}")
  Future<PromoListModel> getHostPromoList(
    @Path("id") String id,
  );

  /// -- support tickets

  @GET("ticket/all")
  Future<CommonData> getSupportTicket();

  @POST("ticket/create")
  Future<CommonData> createSupportTicket(@Body() Map<String, dynamic> request);

  @POST("ticket/reply")
  Future<CommonData> replySupportTicket(@Body() Map<String, dynamic> request);

  @GET("ticket/close/{id}")
  Future<CommonData> closeSupportTicket(
    @Path("id") String id,
  );

  /// - card
  @GET("card/all")
  Future<CommonData> getAllCards();

  @POST("card/create")
  Future<CommonData> createCard(@Body() Map<String, dynamic> request);

  @PUT("card/update/{id}")
  Future<CommonData> updateCard(
    @Path("id") String id,
    @Body() Map<String, dynamic> request,
  );

  @PUT("card/default-card")
  Future<CommonData> setDefaultCard(@Field("cardId") String id);

  @DELETE("card/delete/{id}")
  Future<CommonData> deleteCard(@Path("id") String id);

  /// -- Subscription plan
  @GET("/subscription/all")
  Future<SubscriptionListModel> getSubscription(
      @Query("currency") String? currency);

  @POST("/subscription/purchase")
  Future<CommonData> subscriptionPurchase(@Body() Map<String, dynamic> request);

  /// == Booking
  @POST("booking/create")
  Future<CommonData> createBooking(@Body() Map<String, dynamic> request);

  @GET("booking/accept/{id}")
  Future<CommonData> acceptBooking(@Path("id") String id);

  @GET("booking/reject/{id}")
  Future<CommonData> rejectBooking(@Path("id") String id);

  @GET("booking/me")
  Future<CommonData> getMyBookings(@Query("status") String status);

  @GET("booking/all/host/{id}")
  Future<CommonData> getHostBookings(
    @Path("id") String hostId,
    @Query("status") String? status,
  );

  @GET("booking/booked-dates")
  Future<CommonData> getBookedDates(@Query("hostId") String hostId);

  @GET("booking/all")
  Future<CommonData> getAllBookings();

  @GET("booking/find/{id}")
  Future<CommonData> getBookingById(@Path("id") String bookingId);

  @POST("booking/refund")
  Future<CommonData> refundBooking(@Body() Map<String, dynamic> request);

  @GET("booking/host/cancel/{id}")
  Future<CommonData> cancelBookingByHost(@Path("id") String bookingId);

  @GET("booking/user/cancel/{id}")
  Future<CommonData> cancelBookingByUser(@Path("id") String bookingId);

  @POST("booking/rate")
  Future<CommonData> rateBooking(@Body() Map<String, dynamic> request);

  @GET("/tenant/me")
  Future<CommonData> getTenant(@Query("status") String status);

  /// chat
  @GET("/conversation/all")
  Future<CommonData> getAllConversations();

  @POST("/conversation/start")
  Future<CoversationResponse> startConversation(
      @Body() Map<String, dynamic> request);

  @POST("/message/create")
  @MultiPart()
  Future<CreateMsgResponse> createMessageWithMedia(
    @Part(name: "conversationId") String conversationId,
    @Part(name: "media", contentType: "image/*") File media,
  );

  @POST("/message/create")
  @MultiPart()
  Future<CreateMsgResponse> createMessage(
    @Part(name: "conversationId") String conversationId,
    @Part(name: "text") String text,
  );

  @GET("/message/all/{id}")
  Future<CommonData> getAllMessage(@Path("id") String conversationId);

  ///auto
  @GET("auto/status/{type}/{}")
  Future<CommonData> getAutoStatus(
    @Path("type") String type,
    @Path("tenantId") String? tenantId,
  );

  @GET("auto/accept-booking")
  Future<CommonData> toggleAcceptBooking();

  @GET("auto/rent-payment")
  Future<CommonData> toggleRentPayment();

  ///update payout info
  @GET("user/onboarding-account/{workspace}")
  Future<CommonData> updatePayoutInfo(
    @Path("workspace") String workspace,
    @Query("country") String country,
  );

  @GET("user/balance/{hostId}")
  Future<CommonData> getEarnings(
      @Path("hostId") String hostId, @Query("type") String type);

  @POST("upload/")
  @MultiPart()
  Future<CommonData> uploadImages(
    @Part(name: "files") List<MultipartFile> images,
  );

  @POST("/upload/generate-signed-url")
  Future<CommonData> generateSignedUrl(
      @Field("purpose") String purpose, @Field("extension") String extension);

  @POST("property/create_v2")
  Future<CommonData> createPropertyV2(@Body() Map<String, dynamic> request);

  @POST("message/create_v2")
  Future<CreateMsgResponse> createMessageV2(
      @Body() Map<String, dynamic> request);

  //concierge

  @POST("concierge/login")
  Future<CommonData> conciergeLogin(@Body() Map<String, dynamic> request);

  @POST("/concierge/property/add")
  Future<ConciergePropertyResponse> conciergePropertyAdd(
      @Body() Map<String, dynamic> request);

  @GET("concierge/property/all")
  Future<ConciergePropertyResponse> conciergePropertyAll();

  @GET("concierge/parcel/me")
  Future<ParcelResponse> conciergeParcelMe();

  @GET("/concierge/parcel/add/{type}/{tenantId}")
  Future<ParcelResponse> parcelAdd(
    @Path("type") String type,
    @Path("tenantId") String tenantId,
  );

  @GET("/concierge/parcel/delete/{type}/{tenantId}")
  Future<ParcelResponse> parcelDelete(
    @Path("type") String type,
    @Path("tenantId") String tenantId,
  );

  @DELETE("concierge/tenant/delete/{id}")
  Future<ParcelResponse> tenantDelete(
    @Path("id") String tenantId,
  );

  @GET("/concierge/parcel/remind")
  Future<CommonData> parcelRemind();

  @GET("concierge/tenant/all")
  Future<ConciergeTanantResponse> conciergeTenantAll();

  @POST("concierge/tenant/add")
  Future<AddTenantModel> conciergeTenantAdd(
      @Body() Map<String, dynamic> request);

  @GET("concierge/outgoing-parcel/all")
  Future<OngoingResponse> ongoingAll();

  @POST("/concierge/outgoing-parcel/add")
  Future<CommonData> ongoingAdd(@Body() Map<String, dynamic> request);

  @GET("concierge/outgoing-parcel/toggle-status/{id}")
  Future<CommonData> ongoingToggleStatus(
    @Path("id") String tenantId,
  );

  @GET("concierge/maintenance-request/all")
  Future<MaintenaceRequestResponse> maintenanceRequestAll();

  @POST("concierge/maintenance-request/add")
  Future<CommonData> maintenanceRequestsAdd(
      @Body() Map<String, dynamic> request);

  @GET("/concierge/maintenance-request/toggle-status/{id}")
  Future<CommonData> maintenanceRequestToggle(
    @Path("id") String tenantId,
  );

  @POST("/property/bulk-email")
  Future<CommonData> propertyBulkEmail(@Body() Map<String, dynamic> request);

  @POST("/upload")
  @MultiPart()
  Future<CommonData> uploadMedia(@Part() File file);
}
