import 'dart:io';

import 'package:homework/core/api/api_response/api_response.dart';
import 'package:homework/data/model/response/common_data.dart';
import 'package:homework/data/model/response/subscription_list_model.dart';
import 'package:homework/data/remote/api_client.dart';
import 'package:homework/data/repository/user_repository.dart';
import 'package:homework/data/repository_impl/base_repository_impl.dart';
import 'package:homework/ui/auth/ui/bottomsheet/alert/verification_alert.dart';

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
  Future<ApiResponse<CommonData>> updateProfile(Map<String, dynamic> request) {
    return execute(apiClient.updateProfile(request));
  }

  @override
  Future<ApiResponse<CommonData>> resentOtp(VerificationAlertType type) {
    return execute(apiClient.resentOtp(
        type == VerificationAlertType.forgotPassword ? true : false));
  }

  @override
  Future<ApiResponse<CommonData>> verifyOtp(
      VerificationAlertType type, String otp) {
    return execute(apiClient.verifyOtp(
        otp, type == VerificationAlertType.forgotPassword ? true : false));
  }

  @override
  Future<ApiResponse<CommonData>> updatePassword(String newPassword) {
    return execute(apiClient.updatePassword(newPassword));
  }

  @override
  Future<ApiResponse<CommonData>> forgotPassword(Map<String, dynamic> request) {
    return execute(apiClient.forgotPassword(request));
  }

  @override
  Future<ApiResponse<CommonData>> updateProfileWithImage(
    String firstName,
    String lastName,
    String email,
    String phone,
    File image,
  ) {
    return execute(apiClient.updateProfileWithImage(
      firstName,
      lastName,
      email,
      phone,
      image,
    ));
  }

  @override
  Future<ApiResponse<CommonData>> closeSupportTicket(String id) {
    return execute(apiClient.closeSupportTicket(id));
  }

  @override
  Future<ApiResponse<CommonData>> createSupportTicket(
      Map<String, dynamic> request) {
    return execute(apiClient.createSupportTicket(request));
  }

  @override
  Future<ApiResponse<CommonData>> getSupportTicket() {
    return execute(apiClient.getSupportTicket());
  }

  @override
  Future<ApiResponse<CommonData>> replySupportTicket(
      Map<String, dynamic> request) {
    return execute(apiClient.replySupportTicket(request));
  }

  @override
  Future<ApiResponse<SubscriptionListModel>> subscriptionList(String currency) {
    return execute(apiClient.getSubscription(currency));
  }

  @override
  Future<ApiResponse<CommonData>> subscriptionPurchase(
      Map<String, dynamic> request) {
    return execute(apiClient.subscriptionPurchase(request));
  }

  @override
  Future<ApiResponse<CommonData>> updatePayoutInfo(String type) {
    return execute(apiClient.updatePayoutInfo(type));
  }

  @override
  Future<ApiResponse<CommonData>> getEarnings(String hostId, String type) {
    return execute(apiClient.getEarnings(hostId, type));
  }

  @override
  Future<ApiResponse<CommonData>> getReAuthenticate() {
    return execute(apiClient.reAuthenticate());
  }

  @override
  Future<ApiResponse<CommonData>> uploadFiles(List<File> files) async {
    var list = await prepareImageFiles(files);
    return execute(apiClient.uploadImages(list));
  }

  @override
  Future<ApiResponse<CommonData>> socialAuth(Map<String, dynamic> request) {
    return execute(apiClient.socialAuth(request));
  }

  @override
  Future<ApiResponse<CommonData>> generateS3Url(
      String extension, String purpose) {
    return execute(apiClient.generateSignedUrl(purpose, extension));
  }
}
