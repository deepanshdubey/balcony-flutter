import 'package:balcony/core/api/api_response/api_response.dart';
import 'package:balcony/data/model/response/common_data.dart';
import 'package:balcony/data/model/response/user_data.dart';
import 'package:balcony/data/remote/api_client.dart';
import 'package:balcony/data/repository/user_repository.dart';
import 'package:balcony/data/repository_impl/base_repository_impl.dart';
import 'package:balcony/ui/auth/ui/bottomsheet/alert/verification_alert.dart';

class UserRepositoryImpl extends BaseRepositoryImpl implements UserRepository {
  final ApiClient apiClient;

  UserRepositoryImpl(this.apiClient);

  @override
  Future<ApiResponse<CommonData>> login(Map<String, dynamic> request) {
    return execute(apiClient.login(request));
  }

  @override
  Future<ApiResponse<CommonData>> register(Map<String, dynamic> request) {
    return execute(apiClient.register(request));
  }

  @override
  Future<ApiResponse<void>> logout() {
    return execute(apiClient.logout());
  }

  @override
  Future<ApiResponse<CommonData>> forgotPassword(Map<String, dynamic> request) {
    return execute(apiClient.sendResetOtp(request));
  }

  @override
  Future<ApiResponse<UserData>> updateProfile(Map<String, dynamic> request) {
    return execute(apiClient.updateProfile(request));
  }

  @override
  Future<ApiResponse<CommonData>> resetPassword(String newPassword) {
    return execute(apiClient.resetPassword(newPassword));
  }

  @override
  Future<ApiResponse<CommonData>> resentOtp(VerificationAlertType type) {
    return execute(apiClient.resentOtp(
        type == VerificationAlertType.forgotPassword ? true : false));
  }

  @override
  Future<ApiResponse<CommonData>> verifyOtp(
      VerificationAlertType type, String otp) {
    return execute(apiClient.verifyOtp(otp, type == VerificationAlertType.forgotPassword ? true : false));
  }
}
