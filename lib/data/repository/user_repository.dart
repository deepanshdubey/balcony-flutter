import 'dart:io';

import 'package:balcony/core/api/api_response/api_response.dart';
import 'package:balcony/core/locator/locator.dart';
import 'package:balcony/data/model/response/common_data.dart';
import 'package:balcony/ui/auth/ui/bottomsheet/alert/verification_alert.dart';

abstract class UserRepository {
  Future<ApiResponse<CommonData>> register(Map<String, dynamic> request);

  Future<ApiResponse<CommonData>> resentOtp(VerificationAlertType type);

  Future<ApiResponse<CommonData>> verifyOtp(
      VerificationAlertType type, String otp);

  Future<ApiResponse<CommonData>> login(Map<String, dynamic> request);

  Future<ApiResponse<CommonData>> forgotPassword(Map<String, dynamic> request);

  Future<ApiResponse<CommonData>> updatePassword(String newPassword);

  Future<ApiResponse<CommonData>> updateProfile(Map<String, dynamic> request);

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
}

final userRepository = locator<UserRepository>();
