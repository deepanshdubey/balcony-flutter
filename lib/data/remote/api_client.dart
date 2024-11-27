import 'dart:convert';
import 'dart:io';

import 'package:balcony/data/model/response/card_data.dart';
import 'package:balcony/data/model/response/common_data.dart';
import 'package:balcony/data/model/response/pagination_data.dart';
import 'package:balcony/data/model/response/promo_list_model.dart';
import 'package:balcony/data/model/response/promo_model.dart';
import 'package:balcony/data/model/response/property_data.dart';
import 'package:balcony/data/model/response/subscription_list_model.dart';
import 'package:balcony/data/model/response/user_data.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:retrofit/retrofit.dart';

import '../model/response/workspace_data.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://api.homework.ws/api/v2/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST("auth/register")
  Future<CommonData> register(@Body() Map<String, dynamic> request);

  @GET("auth/resend-otp")
  Future<CommonData> resentOtp(@Query("reset") bool isReset);

  @GET("auth/otp-status")
  Future<CommonData> getOtpStatus();

  @POST("auth/verify")
  Future<CommonData> verifyOtp(
      @Field("otp") String otp, @Field("reset") bool isReset);

  @POST("auth/login")
  Future<CommonData> login(@Body() Map<String, dynamic> request);

  @POST("auth/send-reset-otp")
  Future<CommonData> sendResetOtp(@Body() Map<String, dynamic> request);

  @PUT("auth/update-password")
  Future<CommonData> updatePassword(@Field("password") String newPassword);

  @POST("auth/forgot-password")
  Future<CommonData> forgotPassword(@Body() Map<String, dynamic> request);

  @GET("auth/logout")
  Future<void> logout();

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
    @Query("status") String? status,
    @Query("sort") String? sort,
    @Query("select") String? select,
    @Query("page") int? page,
    @Query("limit") int? limit,
    @Query("includeHost") bool? includeHost,
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

  @GET("property/all")
  Future<PaginationData<PropertyData>> getProperties(
    @Query("status") String? status,
    @Query("sort") String? sort,
    @Query("select") String? select,
    @Query("page") int? page,
    @Query("limit") int? limit,
    @Query("includeHost") bool? includeHost,
      @Query("query") String? query,
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
    @Part(name: "unitList") List<Map<String, dynamic>> unitList,
    @Part(name: "other") Map<String, dynamic> other,
    @Part(name: "amenities") String amenities,
    @Part(
      name: "leasingPolicyDoc",
    )
    File? image,
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

  // -- promo -- //

  @POST("/promo/create")
  Future<PromoModel> createPromo(@Body() Map<String, dynamic> request);

  @GET("/promo/find/{code}")
  Future<PromoModel> getPromoCode(
    @Path("code") String code,
  );

  @GET("/promo/all")
  Future<PromoListModel> getPromoCodeList();

  /// -- support tickets

  @GET("ticket/all")
  Future<CommonData> getSupportTicket();

  @POST("ticket/create")
  Future<CommonData> createSupportTicket(@Body() Map<String, dynamic> request);

  @POST("ticket/reply")
  Future<CommonData> replySupportTicket(@Body() Map<String, dynamic> request);

  @GET("ticket/close/[id}")
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

  @PUT("card/set-default")
  Future<CommonData> setDefaultCard(@Field("cardId") String id);

  @DELETE("card/delete/{id}")
  Future<CommonData> deleteCard(@Path("id") String id);

  /// -- Subscription plan
  @GET("/subscription/all")
  Future<SubscriptionListModel> getSubscription(
      @Query("currency") String? currency);

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
  Future<CommonData> getHostBookings(@Path("id") String hostId);

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
}
