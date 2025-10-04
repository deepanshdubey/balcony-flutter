// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on _AuthStoreBase, Store {
  late final _$loginResponseAtom =
      Atom(name: '_AuthStoreBase.loginResponse', context: context);

  @override
  CommonData? get loginResponse {
    _$loginResponseAtom.reportRead();
    return super.loginResponse;
  }

  @override
  set loginResponse(CommonData? value) {
    _$loginResponseAtom.reportWrite(value, super.loginResponse, () {
      super.loginResponse = value;
    });
  }

  late final _$deleteAccountResponseAtom =
      Atom(name: '_AuthStoreBase.deleteAccountResponse', context: context);

  @override
  CommonData? get deleteAccountResponse {
    _$deleteAccountResponseAtom.reportRead();
    return super.deleteAccountResponse;
  }

  @override
  set deleteAccountResponse(CommonData? value) {
    _$deleteAccountResponseAtom.reportWrite(value, super.deleteAccountResponse,
        () {
      super.deleteAccountResponse = value;
    });
  }

  late final _$registerResponseAtom =
      Atom(name: '_AuthStoreBase.registerResponse', context: context);

  @override
  CommonData? get registerResponse {
    _$registerResponseAtom.reportRead();
    return super.registerResponse;
  }

  @override
  set registerResponse(CommonData? value) {
    _$registerResponseAtom.reportWrite(value, super.registerResponse, () {
      super.registerResponse = value;
    });
  }

  late final _$verificationResponseAtom =
      Atom(name: '_AuthStoreBase.verificationResponse', context: context);

  @override
  CommonData? get verificationResponse {
    _$verificationResponseAtom.reportRead();
    return super.verificationResponse;
  }

  @override
  set verificationResponse(CommonData? value) {
    _$verificationResponseAtom.reportWrite(value, super.verificationResponse,
        () {
      super.verificationResponse = value;
    });
  }

  late final _$resendOtpResponseAtom =
      Atom(name: '_AuthStoreBase.resendOtpResponse', context: context);

  @override
  CommonData? get resendOtpResponse {
    _$resendOtpResponseAtom.reportRead();
    return super.resendOtpResponse;
  }

  @override
  set resendOtpResponse(CommonData? value) {
    _$resendOtpResponseAtom.reportWrite(value, super.resendOtpResponse, () {
      super.resendOtpResponse = value;
    });
  }

  late final _$forgotPasswordResponseAtom =
      Atom(name: '_AuthStoreBase.forgotPasswordResponse', context: context);

  @override
  CommonData? get forgotPasswordResponse {
    _$forgotPasswordResponseAtom.reportRead();
    return super.forgotPasswordResponse;
  }

  @override
  set forgotPasswordResponse(CommonData? value) {
    _$forgotPasswordResponseAtom
        .reportWrite(value, super.forgotPasswordResponse, () {
      super.forgotPasswordResponse = value;
    });
  }

  late final _$updatePasswordResponseAtom =
      Atom(name: '_AuthStoreBase.updatePasswordResponse', context: context);

  @override
  CommonData? get updatePasswordResponse {
    _$updatePasswordResponseAtom.reportRead();
    return super.updatePasswordResponse;
  }

  @override
  set updatePasswordResponse(CommonData? value) {
    _$updatePasswordResponseAtom
        .reportWrite(value, super.updatePasswordResponse, () {
      super.updatePasswordResponse = value;
    });
  }

  late final _$logoutSuccessAtom =
      Atom(name: '_AuthStoreBase.logoutSuccess', context: context);

  @override
  bool? get logoutSuccess {
    _$logoutSuccessAtom.reportRead();
    return super.logoutSuccess;
  }

  @override
  set logoutSuccess(bool? value) {
    _$logoutSuccessAtom.reportWrite(value, super.logoutSuccess, () {
      super.logoutSuccess = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_AuthStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_AuthStoreBase.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$logoutResponseAtom =
      Atom(name: '_AuthStoreBase.logoutResponse', context: context);

  @override
  bool? get logoutResponse {
    _$logoutResponseAtom.reportRead();
    return super.logoutResponse;
  }

  @override
  set logoutResponse(bool? value) {
    _$logoutResponseAtom.reportWrite(value, super.logoutResponse, () {
      super.logoutResponse = value;
    });
  }

  late final _$updateProfileResponseAtom =
      Atom(name: '_AuthStoreBase.updateProfileResponse', context: context);

  @override
  CommonData? get updateProfileResponse {
    _$updateProfileResponseAtom.reportRead();
    return super.updateProfileResponse;
  }

  @override
  set updateProfileResponse(CommonData? value) {
    _$updateProfileResponseAtom.reportWrite(value, super.updateProfileResponse,
        () {
      super.updateProfileResponse = value;
    });
  }

  late final _$subscriptionPurchaseResponseAtom = Atom(
      name: '_AuthStoreBase.subscriptionPurchaseResponse', context: context);

  @override
  CommonData? get subscriptionPurchaseResponse {
    _$subscriptionPurchaseResponseAtom.reportRead();
    return super.subscriptionPurchaseResponse;
  }

  @override
  set subscriptionPurchaseResponse(CommonData? value) {
    _$subscriptionPurchaseResponseAtom
        .reportWrite(value, super.subscriptionPurchaseResponse, () {
      super.subscriptionPurchaseResponse = value;
    });
  }

  late final _$subscriptionListResponseAtom =
      Atom(name: '_AuthStoreBase.subscriptionListResponse', context: context);

  @override
  List<Plan>? get subscriptionListResponse {
    _$subscriptionListResponseAtom.reportRead();
    return super.subscriptionListResponse;
  }

  @override
  set subscriptionListResponse(List<Plan>? value) {
    _$subscriptionListResponseAtom
        .reportWrite(value, super.subscriptionListResponse, () {
      super.subscriptionListResponse = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('_AuthStoreBase.login', context: context);

  @override
  Future<dynamic> login(Map<String, dynamic> request) {
    return _$loginAsyncAction.run(() => super.login(request));
  }

  late final _$deleteAccountAsyncAction =
      AsyncAction('_AuthStoreBase.deleteAccount', context: context);

  @override
  Future<dynamic> deleteAccount(Map<String, dynamic> request) {
    return _$deleteAccountAsyncAction.run(() => super.deleteAccount(request));
  }

  late final _$socialAuthAsyncAction =
      AsyncAction('_AuthStoreBase.socialAuth', context: context);

  @override
  Future<dynamic> socialAuth({SocialPlatform type = SocialPlatform.google}) {
    return _$socialAuthAsyncAction.run(() => super.socialAuth(type: type));
  }

  late final _$registerAsyncAction =
      AsyncAction('_AuthStoreBase.register', context: context);

  @override
  Future<dynamic> register(Map<String, dynamic> request) {
    return _$registerAsyncAction.run(() => super.register(request));
  }

  late final _$resendOtpAsyncAction =
      AsyncAction('_AuthStoreBase.resendOtp', context: context);

  @override
  Future<dynamic> resendOtp(VerificationAlertType type) {
    return _$resendOtpAsyncAction.run(() => super.resendOtp(type));
  }

  late final _$verifyOtpAsyncAction =
      AsyncAction('_AuthStoreBase.verifyOtp', context: context);

  @override
  Future<dynamic> verifyOtp(VerificationAlertType type, String otp) {
    return _$verifyOtpAsyncAction.run(() => super.verifyOtp(type, otp));
  }

  late final _$forgotPasswordAsyncAction =
      AsyncAction('_AuthStoreBase.forgotPassword', context: context);

  @override
  Future<dynamic> forgotPassword(Map<String, dynamic> request) {
    return _$forgotPasswordAsyncAction.run(() => super.forgotPassword(request));
  }

  late final _$updatePasswordAsyncAction =
      AsyncAction('_AuthStoreBase.updatePassword', context: context);

  @override
  Future<dynamic> updatePassword(String newPassword) {
    return _$updatePasswordAsyncAction
        .run(() => super.updatePassword(newPassword));
  }

  late final _$logoutAsyncAction =
      AsyncAction('_AuthStoreBase.logout', context: context);

  @override
  Future<dynamic> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$updateProfileAsyncAction =
      AsyncAction('_AuthStoreBase.updateProfile', context: context);

  @override
  Future<dynamic> updateProfile(Map<String, dynamic> request) {
    return _$updateProfileAsyncAction.run(() => super.updateProfile(request));
  }

  late final _$updateProfileWithImageAsyncAction =
      AsyncAction('_AuthStoreBase.updateProfileWithImage', context: context);

  @override
  Future<dynamic> updateProfileWithImage(String firstName, String lastName,
      String email, String phone, File image) {
    return _$updateProfileWithImageAsyncAction.run(() =>
        super.updateProfileWithImage(firstName, lastName, email, phone, image));
  }

  late final _$getSubscriptionListAsyncAction =
      AsyncAction('_AuthStoreBase.getSubscriptionList', context: context);

  @override
  Future<dynamic> getSubscriptionList(String currency) {
    return _$getSubscriptionListAsyncAction
        .run(() => super.getSubscriptionList(currency));
  }

  late final _$subscriptionPurchaseAsyncAction =
      AsyncAction('_AuthStoreBase.subscriptionPurchase', context: context);

  @override
  Future<dynamic> subscriptionPurchase(Map<String, dynamic> request) {
    return _$subscriptionPurchaseAsyncAction
        .run(() => super.subscriptionPurchase(request));
  }

  @override
  String toString() {
    return '''
loginResponse: ${loginResponse},
deleteAccountResponse: ${deleteAccountResponse},
registerResponse: ${registerResponse},
verificationResponse: ${verificationResponse},
resendOtpResponse: ${resendOtpResponse},
forgotPasswordResponse: ${forgotPasswordResponse},
updatePasswordResponse: ${updatePasswordResponse},
logoutSuccess: ${logoutSuccess},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
logoutResponse: ${logoutResponse},
updateProfileResponse: ${updateProfileResponse},
subscriptionPurchaseResponse: ${subscriptionPurchaseResponse},
subscriptionListResponse: ${subscriptionListResponse}
    ''';
  }
}
