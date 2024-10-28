import 'package:balcony/core/api/api_response/api_response.dart';
import 'package:balcony/core/locator/locator.dart';
import 'package:balcony/data/model/response/common_data.dart';
import 'package:balcony/data/model/response/user_data.dart';
import 'package:balcony/ui/auth/ui/bottomsheet/alert/verification_alert.dart';

abstract class UserRepository {
  Future<ApiResponse<CommonData>> register(Map<String, dynamic> request);

  Future<ApiResponse<CommonData>> resentOtp(VerificationAlertType type);

  Future<ApiResponse<CommonData>> verifyOtp(VerificationAlertType type, String otp);

  Future<ApiResponse<CommonData>> login(Map<String, dynamic> request);

  Future<ApiResponse<CommonData>> forgotPassword(Map<String, dynamic> request);

  Future<ApiResponse<UserData>> updateProfile(Map<String, dynamic> request);

  Future<ApiResponse<void>> logout();

  Future<ApiResponse<CommonData>> resetPassword(String newPassword);
}

final userRepository = locator<UserRepository>();
