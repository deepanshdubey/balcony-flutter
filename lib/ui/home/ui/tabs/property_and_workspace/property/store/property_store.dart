import 'dart:io';

import 'package:homework/core/locator/locator.dart';
import 'package:homework/core/session/app_session.dart';
import 'package:homework/data/model/response/common_data.dart';
import 'package:homework/data/model/response/property_data.dart';
import 'package:homework/data/model/response/tenant_details.dart';
import 'package:homework/data/repository/property_repository.dart';
import 'package:homework/data/repository/tenant_repository.dart';
import 'package:homework/data/repository/user_repository.dart';
import 'package:http/http.dart' as http;
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
  CommonData? tenantPaymentResponse;

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
    List<File> floorPlanImgs,
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
          floorPlanImgs,
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
  Future createPropertyV2(
    List<String> images,
    List<UnitList> units,
    String leasingPolicyDoc,
    dynamic info,
    String currency,
    Map<String, dynamic> other,
    List<String> amenities,
  ) async {
    try {
      errorMessage = null;
      isLoading = true;

      // Run image and file uploads in parallel
      final List<Future<String>> imageUploadFutures =
          images.map(_processSingleFilePath).toList();
      final List<Future<void>> unitUploadFutures = units.map((unit) async {
        if (unit.floorPlanImg != null &&
            unit.floorPlanImg?.isNotEmpty == true) {
          unit.floorPlanImg = await _processSingleFilePath(unit.floorPlanImg!);
        }
      }).toList();
      final leasingPolicyDocFuture = _processSingleFilePath(leasingPolicyDoc);

      // Wait for all uploads to complete
      images = await Future.wait(imageUploadFutures);
      await Future.wait(unitUploadFutures);
      leasingPolicyDoc = await leasingPolicyDocFuture;

      // Prepare request payload
      var payload = {
        "images": images,
        "units": units.map((u) => u.toJson()).toList(),
        "leasingPolicyDoc": leasingPolicyDoc,
        "info": info,
        "currency": currency,
        "other": other,
        "amenities": amenities,
      };

      // Make API call
      var response = await propertyRepository.createPropertyV2(payload);
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

// Helper to process a single file path
  Future<String> _processSingleFilePath(String filePathOrUrl) async {
    if (filePathOrUrl.startsWith('http')) {
      return filePathOrUrl;
    }

    // Call generateS3url API
    var fileExtension = filePathOrUrl.split('.').last;
    var generateS3urlResponse =
        await userRepository.generateS3Url(fileExtension, "property");

    if (generateS3urlResponse.isSuccess) {
      var signedUrl = generateS3urlResponse.data!.signedUrl!;
      var publicUrl = generateS3urlResponse.data!.publicUrl!;
      await uploadFileToS3(filePathOrUrl, signedUrl);
      // Return public URL
      return publicUrl;
    } else {
      throw Exception(
          "Failed to generate S3 URL: ${generateS3urlResponse.error?.message}");
    }
  }

// Helper to upload file to S3
  Future<void> uploadFileToS3(String filePath, String signedUrl) async {
    var file = File(filePath);
    var bytes = await file.readAsBytes();

    var response = await http.put(
      Uri.parse(signedUrl),
      headers: {
        "Content-Type": "application/octet-stream",
      },
      body: bytes,
    );

    if (response.statusCode != 200) {
      throw Exception("File upload failed: ${response.statusCode}");
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
  Future tenantPayment(
    Map<String, dynamic> request,
  ) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await tenantRepository.tenantPayment(request);
      if (response.isSuccess) {
        tenantPaymentResponse = response.data;
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
        getProspectTenantsByHostId();
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
        prospectTenantsByHostResponse?.clear();
        if (response.data?.tenants != null) {
          prospectTenantsByHostResponse = response.data?.tenants;
        }
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
  Future deleteProperty(String id) async {
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
