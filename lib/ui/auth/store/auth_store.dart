import 'dart:io';

import 'package:balcony/core/locator/locator.dart';
import 'package:balcony/core/session/app_session.dart';
import 'package:balcony/data/model/response/common_data.dart';
import 'package:balcony/data/model/response/subscription_list_model.dart';
import 'package:balcony/data/repository/user_repository.dart';
import 'package:balcony/ui/auth/ui/bottomsheet/alert/verification_alert.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  @observable
  CommonData? loginResponse;

  @observable
  CommonData? registerResponse;

  @observable
  CommonData? verificationResponse;

  @observable
  CommonData? resendOtpResponse;

  @observable
  CommonData? forgotPasswordResponse;

  @observable
  CommonData? updatePasswordResponse;

  @observable
  bool? logoutSuccess;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  bool? logoutResponse;

  @observable
  CommonData? updateProfileResponse;

  @observable
  List<Plan>? subscriptionListResponse;

  @action
  Future login(Map<String, dynamic> request) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await userRepository.login(request);
      if (response.isSuccess) {
        loginResponse = response.data!;
        session.user = response.data!.user!;
        session.token = response.data!.token!;
      } else {
        errorMessage = response.error!.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future register(Map<String, dynamic> request) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await userRepository.register(request);
      if (response.isSuccess) {
        registerResponse = response.data!;
        session.user = response.data!.user!;
        session.token = response.data!.token!;
      } else {
        errorMessage = response.error!.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future resendOtp(VerificationAlertType type) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await userRepository.resentOtp(type);
      if (response.isSuccess) {
        resendOtpResponse = response.data!;
      } else {
        errorMessage = response.error!.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future verifyOtp(VerificationAlertType type, String otp) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await userRepository.verifyOtp(type, otp);
      if (response.isSuccess) {
        verificationResponse = response.data!;
      } else {
        errorMessage = response.error!.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future forgotPassword(Map<String, dynamic> request) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await userRepository.forgotPassword(request);
      if (response.isSuccess) {
        forgotPasswordResponse = response.data!;
      } else {
        errorMessage = response.error!.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future updatePassword(String newPassword) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await userRepository.updatePassword(newPassword);
      if (response.isSuccess) {
        updatePasswordResponse = response.data!;
      } else {
        errorMessage = response.error!.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future logout() async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await userRepository.logout();
      if (response.isSuccess) {
        logoutResponse = true;
      } else {
        errorMessage = response.error!.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }



  @action
  Future updateProfile(Map<String, dynamic> request) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await userRepository.updateProfile(request);
      if (response.isSuccess) {
        updateProfileResponse = response.data!;
        session.user = response.data!.user!;
      } else {
        errorMessage = response.error!.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future updateProfileWithImage(
    String firstName,
    String lastName,
    String email,
    String phone,
    File image,
  ) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await userRepository.updateProfileWithImage(
          firstName, lastName, email, phone, image);
      if (response.isSuccess) {
        updateProfileResponse = response.data!;
        session.user = response.data!.user!;
      } else {
        errorMessage = response.error!.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }



  @action
  Future getSubscriptionList(String currency) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await userRepository.subscriptionList(currency);
      if (response.isSuccess) {
        subscriptionListResponse = response.data?.plans;
      } else {
        errorMessage = response.error!.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }
}
