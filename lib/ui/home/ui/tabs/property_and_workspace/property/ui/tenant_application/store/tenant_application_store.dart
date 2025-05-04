import 'dart:async';

import 'package:homework/core/locator/locator.dart';
import 'package:homework/data/model/response/common_data.dart';
import 'package:homework/data/repository/property_repository.dart';
import 'package:homework/data/repository/tenant_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:plaid_flutter/plaid_flutter.dart';

part 'tenant_application_store.g.dart';

const idVerificationCountries = ["united states", "united kingdom", "canada"];
const bankVerificationCountries = ["united states"];

class TenantApplicationStore = _TenantApplicationStoreBase
    with _$TenantApplicationStore;

abstract class _TenantApplicationStoreBase with Store {
  final String propertyId;

  @observable
  bool isLoadingApplicationFee = false;

  @observable
  bool isApplyingForTenancy = false;

  @observable
  String? errorMessage;

  @observable
  num applicationFeeResponse = 0;

  @observable
  bool shouldVerifyId = false;

  @observable
  bool shouldVerifyBank = false;

  @observable
  bool? isBankVerified;

  @observable
  bool? isIdVerified;

  @observable
  CommonData? applyTenantResponse;
  CommonData? storedApplyTenantResponse;

  String? verificationType;

  _TenantApplicationStoreBase({required this.propertyId}) {
    getPropertyApplicationFee(id: propertyId);
    PlaidLink.onEvent.listen(_onEvent);
    PlaidLink.onExit.listen(_onExit);
    PlaidLink.onSuccess.listen(_onSuccess);
  }

  void _onEvent(LinkEvent event) {
    final name = event.name;
    final metadata = event.metadata.description();
    logger.e("onEvent: $name, metadata: $metadata");
  }

  @action
  void _onSuccess(LinkSuccess event) {
    final token = event.publicToken;
    final metadata = event.metadata.description();
    logger.e("onSuccess: $token, metadata: $metadata");
    tenantRepository
        .updateTenantVerification(
            verificationType!,
            storedApplyTenantResponse!.tenant!.Id!,
            event.metadata.linkSessionId)
        .then(
      (response) {
        isApplyingForTenancy = false;
        if (response.isSuccess) {
          if (shouldVerifyId) {
            isIdVerified = response.data?.verification?.identity?.status == "completed";
          }
          if (shouldVerifyBank) {
            isBankVerified = response.data?.verification?.bankStatement?.status == "completed";
          }
        } else {
          errorMessage = response.error!.message;
        }
      },
    );
  }

  @action
  void _onExit(LinkExit event) {
    final metadata = event.metadata.description();
    final error = event.error?.description();
    isApplyingForTenancy = false;
    errorMessage = error;
  }

  @action
  Future getPropertyApplicationFee({required String id}) async {
    try {
      errorMessage = null;
      isLoadingApplicationFee = true;
      final response = await propertyRepository.getPropertyApplicationFee(id);
      if (response.isSuccess) {
        applicationFeeResponse = response.data?.applicationFee ?? 0;
      } else {
        errorMessage = response.error!.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isLoadingApplicationFee = false;
    }
  }

  @action
  Future applyForTenancy(Map<String, dynamic> request,
      {String? verificationType}) async {
    try {
      Map<String, dynamic> newRequest = {};
      errorMessage = null;
      isApplyingForTenancy = true;
      if (verificationType == null) {
        newRequest = {
          ...request,
          "isCompleted": true,
        };
      } else {
        newRequest = request;
      }
      final response = await tenantRepository.applyTenant(newRequest);
      if (response.isSuccess) {
        var tenant = response.data?.tenant;
        storedApplyTenantResponse = response.data;
        if (verificationType != null) {
          this.verificationType = verificationType;
          var response = await tenantRepository.getTenantVerificationToken(
              verificationType, tenant!.Id!);
          if (response.isSuccess) {
            LinkTokenConfiguration configuration =
                LinkTokenConfiguration(token: response.data!.token!);
            PlaidLink.create(configuration: configuration);
            PlaidLink.open();
          } else {
            errorMessage = response.error!.message;
          }
        } else {
          applyTenantResponse = response.data;
        }
      } else {
        errorMessage = response.error!.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isApplyingForTenancy = false;
    }
  }

  @action
  Future onCountrySelected(String country) async {
    shouldVerifyId = idVerificationCountries.contains(country);
    shouldVerifyBank = bankVerificationCountries.contains(country);
    if(!shouldVerifyId) {isIdVerified = null;}
    if(!shouldVerifyBank) {isBankVerified = null;}
    isIdVerified ??= false;
    isBankVerified ??= false;
  }
}
