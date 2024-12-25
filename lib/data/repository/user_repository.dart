import 'dart:io';

import 'package:homework/core/api/api_response/api_response.dart';
import 'package:homework/core/locator/locator.dart';
import 'package:homework/data/model/response/common_data.dart';
import 'package:homework/data/model/response/subscription_list_model.dart';
import 'package:homework/ui/auth/ui/bottomsheet/alert/verification_alert.dart';

abstract class UserRepository {
  Future<ApiResponse<CommonData>> register(Map<String, dynamic> request);

  Future<ApiResponse<CommonData>> socialAuth(Map<String, dynamic> request);

  Future<ApiResponse<CommonData>> resentOtp(VerificationAlertType type);

  Future<ApiResponse<CommonData>> verifyOtp(
      VerificationAlertType type, String otp);

  Future<ApiResponse<CommonData>> login(Map<String, dynamic> request);

  Future<ApiResponse<CommonData>> forgotPassword(Map<String, dynamic> request);

  Future<ApiResponse<CommonData>> updatePassword(String newPassword);

  Future<ApiResponse<CommonData>> updateProfile(Map<String, dynamic> request);

  Future<ApiResponse<CommonData>> generateS3Url(String extension, String purpose);

  Future<ApiResponse<CommonData>> updateProfileWithImage(
    String firstName,
    String lastName,
    String email,
    String phone,
    File image,
  );

  Future<ApiResponse<void>> logout();

  Future<ApiResponse<CommonData>> getSupportTicket();

  Future<ApiResponse<CommonData>> createSupportTicket(
    Map<String, dynamic> request,
  );

  Future<ApiResponse<CommonData>> replySupportTicket(
    Map<String, dynamic> request,
  );

  Future<ApiResponse<CommonData>> closeSupportTicket(String id);

  Future<ApiResponse<CommonData>> updatePayoutInfo(String type);

  Future<ApiResponse<SubscriptionListModel>> subscriptionList(String currency);

  Future<ApiResponse<CommonData>> getEarnings(String hostId, String type);

  Future<ApiResponse<CommonData>> uploadFiles(List<File> files);

  Future<ApiResponse<CommonData>> getReAuthenticate();
  Future<ApiResponse<CommonData>> subscriptionPurchase( Map<String, dynamic> request,);
}

final userRepository = locator<UserRepository>();
