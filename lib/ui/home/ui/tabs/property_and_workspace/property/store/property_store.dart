import 'dart:io';

import 'package:homework/core/locator/locator.dart';
import 'package:homework/core/session/app_session.dart';
import 'package:homework/data/model/response/common_data.dart';
import 'package:homework/data/model/response/property_data.dart';
import 'package:homework/data/model/response/tenant_details.dart';
import 'package:homework/data/model/response/workspace_data.dart';
import 'package:homework/data/repository/property_repository.dart';
import 'package:homework/data/repository/tenant_repository.dart';
import 'package:mobx/mobx.dart';

part 'property_store.g.dart';

class PropertyStore = _PropertyStoreBase with _$PropertyStore;

abstract class _PropertyStoreBase with Store {
  @observable
  int totalPages = 0;

  @observable
  List<PropertyData>? propertyResponse;

  @observable
  List<PropertyData>? searchPropertyResponse;

  @observable
  CommonData? createPropertyResponse;

  @observable
  CommonData? applyTenantResponse;

  @observable
  CommonData? approveTenantResponse;

  @observable
  CommonData? rejectTenantResponse;

  @observable
  List<Tenants>? tenantsByHostResponse;

  @observable
  List<Tenants>? prospectTenantsByHostResponse;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  PropertyData? propertyDetailsResponse;

  @observable
  CommonData? propertyStatusResponse;

  @action
  Future getProperty(
      {String? status,
      String? sort,
      String? select,
      int? page,
      int? limit,
      bool? includeHost}) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await propertyRepository.getProperties(
        status: status,
        sort: sort,
        select: select,
        page: page,
        limit: limit,
        includeHost: includeHost,
      );
      if (response.isSuccess) {
        propertyResponse = response.data?.data?.result ?? [];
        totalPages = response.data?.data?.totalPages ?? 0;
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
  Future getPropertyDetails({
    String? id,
  }) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await propertyRepository.getPropertyDetails(id: id);
      if (response.isSuccess) {
        propertyDetailsResponse = response.data?.property;
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
  Future createProperty(
    List<File> images,
    List<File> floorPlanImages,
    info,
    String currency,
    Map<String, dynamic> other,
    List<String> amenities,
    File leasingPolicyDoc,
    List<Map<String, dynamic>> unitList,
  ) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await propertyRepository.createProperty(
          images,
          floorPlanImages,
          info,
          currency,
          other,
          amenities,
          leasingPolicyDoc,
          unitList);
      if (response.isSuccess) {
        createPropertyResponse = response.data;
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
  Future applyTenant(
    Map<String, dynamic> request,
  ) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await tenantRepository.applyTenant(request);
      if (response.isSuccess) {
        applyTenantResponse = response.data;
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
  Future updateTenant(
    String id,
    Map<String, dynamic> request,
  ) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await tenantRepository.updateTenant(id, request);
      if (response.isSuccess) {
        applyTenantResponse = response.data;
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
  Future approveTenant(
    String id,
    Map<String, dynamic> request,
  ) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await tenantRepository.approveTenant(id, request);
      if (response.isSuccess) {
        approveTenantResponse = response.data;
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
  Future rejectTenant(
    String id,
  ) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await tenantRepository.rejectTenant(id);
      if (response.isSuccess) {
        rejectTenantResponse = response.data;
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
  Future getTenantsByHostId() async {
    try {
      errorMessage = null;
      isLoading = true;
      var status = ["pending requests", "current tenants", "awaiting payments"];
      final response = await tenantRepository
          .getTenantsByHostId(session.user.id.toString(), status: status);
      if (response.isSuccess) {
        tenantsByHostResponse = response.data?.tenants;
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
  Future getProspectTenantsByHostId() async {
    try {
      errorMessage = null;
      isLoading = true;
      var status = ["pending requests"];
      final response = await tenantRepository
          .getTenantsByHostId(session.user.id.toString(), status: status);
      if (response.isSuccess) {
        prospectTenantsByHostResponse = response.data?.tenants;
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
  Future searchProperty({
    String? place,
    int? beds,
    int? baths,
    double? minrange,
    double? maxrange,
    int? page,
    int? limit,
    String? sort,
    String? select,
    bool? includeHost,
    bool? includeUnitList,
  }) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await propertyRepository.searchProperties(
        place: place,
        beds: beds,
        baths: baths,
        minrange: minrange,
        maxrange: maxrange,
        page: page,
        limit: limit,
        sort: sort,
        select: select,
        includeHost: includeHost,
      );
      if (response.isSuccess) {
        searchPropertyResponse = response.data?.data?.result ?? [];
        totalPages = response.data?.data?.totalPages ?? 0;
      } else {
        errorMessage = response.error?.message ?? "Something went wrong";
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
  Future getHostProperties() async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await propertyRepository
          .getHostProperties(session.user.id.toString());
      if (response.isSuccess) {
        propertyResponse = response.data?.properties;
        totalPages = propertyResponse?.length ?? 0;
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
  Future updatePropertyStatus(String id, bool status) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response =
          await propertyRepository.updatePropertyStatus(id, status);
      if (response.isSuccess) {
        propertyStatusResponse = response.data;
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
  Future deleteWorkspace(String id) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await propertyRepository.deleteProperty(id);
      if (response.isSuccess) {
        getHostProperties();
      } else {
        isLoading = false;
        errorMessage = response.error!.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      isLoading = false;
      errorMessage = e.toString();
    } finally {}
  }
}
