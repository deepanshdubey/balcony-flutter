import 'dart:io';
import 'dart:math';

import 'package:balcony/core/locator/locator.dart';
import 'package:balcony/data/model/response/common_data.dart';
import 'package:balcony/data/model/response/property_data.dart';
import 'package:balcony/data/model/response/workspace_data.dart';
import 'package:balcony/data/repository/property_repository.dart';
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
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  PropertyData? propertyDetailsResponse;

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
          includeHost: includeHost,);
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
    Info info,
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
}
