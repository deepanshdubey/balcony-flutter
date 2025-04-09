import 'package:flutter/cupertino.dart';
import 'package:homework/core/locator/locator.dart';
import 'package:homework/core/session/app_session.dart';
import 'package:homework/data/model/response/common_data.dart';
import 'package:homework/data/repository/concierge_repo.dart';
import 'package:homework/data/repository/property_repository.dart';
import 'package:homework/ui/concierge/model/add_tenant_model.dart';
import 'package:homework/ui/concierge/model/concierge_property_response.dart';
import 'package:homework/ui/concierge/model/concierge_tanant_response.dart';
import 'package:homework/ui/concierge/model/maintenace_request_response.dart';
import 'package:homework/ui/concierge/model/ongoing_response.dart';
import 'package:homework/ui/concierge/model/parcel_response.dart';
import 'package:mobx/mobx.dart';

part 'concierge_store.g.dart';

class ConciergeStore = _ConciergeStoreBase with _$ConciergeStore;

abstract class _ConciergeStoreBase with Store {
  @observable
  CommonData? loginResponse;

  @observable
  ConciergePropertyResponse? conciergePropertyResponse;

  @observable
  ConciergeTanantResponse? conciergeTenantAllResponse;

  @observable
  ConciergePropertyResponse? conciergePropertyAddResponse;

  @observable
  AddTenantModel? conciergeTenantAddResponse;

  @observable
  ParcelResponse? conciergeParcelMeResponse;

  @observable
  ParcelResponse? parcelAddResponse;

  @observable
  ParcelResponse? parcelDeleteResponse;

  @observable
  ParcelResponse? tenantDeleteResponse;

  @observable
  OngoingResponse? ongoingAllResponse;
  @observable
  CommonData? ongoingToggleResponse;
  @observable
  CommonData? ongoingAddResponse;

  @observable
  MaintenaceRequestResponse? maintenanceRequestAllResponse;
  @observable
  CommonData? maintenanceToggleResponse;
  @observable
  CommonData? maintenanceAddResponse;

  @observable
  CommonData? bulkEmailResponse;
  @observable
  bool isSendingBulkEmail = false;

  @observable
  CommonData? pendingParcelRemindResponse;
  @observable
  bool isRemindingForPendingParcel = false;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future conciergeLogin(Map<String, dynamic> request) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await conciergeRepository.conciergeLogin(request);
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
  Future conciergePropertyAll() async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await conciergeRepository.conciergePropertyAll();
      if (response.isSuccess) {
        conciergePropertyResponse = response.data!;
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
  Future conciergeTenantAll() async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await conciergeRepository.conciergeTenantAll();
      if (response.isSuccess) {
        conciergeTenantAllResponse = response.data!;
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
  Future conciergePropertyAdd(request) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await conciergeRepository.conciergePropertyAdd(request);
      if (response.isSuccess) {
        conciergePropertyAddResponse = response.data!;
      } else {
        debugPrint(response.data?.message);
        errorMessage = response.error?.message;
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
  Future conciergeTenantAdd(request) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await conciergeRepository.conciergeTenantAdd(request);
      if (response.isSuccess) {
        conciergeTenantAddResponse = response.data!;
      } else {
        errorMessage = response.error?.message;
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
  Future conciergeParcelMe() async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await conciergeRepository.conciergeParcelMe();
      if (response.isSuccess) {
        conciergeParcelMeResponse = response.data!;
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
  Future parcelAdd(String type, String tenantId) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await conciergeRepository.parcelAdd(type, tenantId);
      if (response.isSuccess) {
        parcelAddResponse = response.data!;
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
  Future parcelDelete(String type, String tenantId) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await conciergeRepository.parcelDelete(type, tenantId);
      if (response.isSuccess) {
        parcelDeleteResponse = response.data!;
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
  Future tenantDelete(String tenantId) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await conciergeRepository.tenantDelete(tenantId);
      if (response.isSuccess) {
        tenantDeleteResponse = response.data!;
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
  Future ongoingAll() async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await conciergeRepository.ongoingAll();
      if (response.isSuccess) {
        ongoingAllResponse = response.data!;
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
  Future ongoingToggle(String tenantId) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await conciergeRepository.ongoingToggle(tenantId);
      if (response.isSuccess) {
        ongoingToggleResponse = response.data!;
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
  Future ongoingAdd(request) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await conciergeRepository.ongoingAdd(request);
      if (response.isSuccess) {
        ongoingAddResponse = response.data!;
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
  Future maintenanceRequestAll() async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await conciergeRepository.maintenanceRequestAll();
      if (response.isSuccess) {
        maintenanceRequestAllResponse = response.data!;
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
  Future maintenanceToggle(String tenantId) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await conciergeRepository.maintenanceToggle(tenantId);
      if (response.isSuccess) {
        maintenanceToggleResponse = response.data!;
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
  Future maintenanceAdd(request) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await conciergeRepository.maintenanceAdd(request);
      if (response.isSuccess) {
        maintenanceAddResponse = response.data!;
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
  Future sendBulkEmail({required List<String> ids, required String message}) async {
    try {
      errorMessage = null;
      isSendingBulkEmail = true;
      bulkEmailResponse = null;
      final response = await propertyRepository.sendBulkEmails({
        "type": "leasing-property",
        "properties": ids,
        "message": message,
      });
      if (response.isSuccess) {
        bulkEmailResponse = response.data!;
      } else {
        errorMessage = response.error!.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isSendingBulkEmail = false;
    }
  }


  @action
  Future remindForPendingParcel() async {
    try {
      errorMessage = null;
      isRemindingForPendingParcel = true;
      pendingParcelRemindResponse = null;
      final response = await conciergeRepository.remindForPendingParcel();
      if (response.isSuccess) {
        pendingParcelRemindResponse = response.data!;
      } else {
        errorMessage = response.error!.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isRemindingForPendingParcel = false;
    }
  }
}
