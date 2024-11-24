import 'dart:convert';
import 'dart:io';

import 'package:balcony/data/model/response/common_data.dart';
import 'package:balcony/data/model/response/pagination_data.dart';
import 'package:balcony/data/model/response/promo_model.dart';
import 'package:balcony/data/model/response/property_data.dart';
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

  // -- promo -- //

  @POST("/promo/create")
  Future<PromoModel> createPromo(@Body() Map<String, dynamic> request);

  @GET("/promo/find/{code}")
  Future<PromoModel> getPromoCode(
    @Path("code") String code,
  );

  @GET("/promo/all")
  Future<PromoModel> getPromoCodeList();

  /// -- support tickets
  @GET("ticket/all")
  Future<CommonData> getSupportTicket();

  @POST("ticket/create")
  Future<CommonData> createSupportTicket(@Body()Map<String, dynamic> request);

  @POST("ticket/reply")
  Future<CommonData> replySupportTicket(@Body()Map<String, dynamic> request);

  @GET("ticket/close/[id}")
  Future<CommonData> closeSupportTicket(
    @Path("id") String id,
  );
}
