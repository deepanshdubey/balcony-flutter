import 'dart:io';

import 'package:homework/core/api/api_response/api_response.dart';
import 'package:homework/core/locator/locator.dart';
import 'package:homework/data/model/response/common_data.dart';
import 'package:homework/data/model/response/pagination_data.dart';
import 'package:homework/data/model/response/property_data.dart';
import 'package:homework/data/model/response/workspace_data.dart';

abstract class PropertyRepository {
  Future<ApiResponse<PaginationData<PropertyData>>> getProperties({
    String? status,
    String? sort,
    String? select,
    int? page,
    int? limit,
    bool? includeHost,
  });

  Future<ApiResponse<PaginationData<PropertyData>>> searchProperties({
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
  });

  Future<ApiResponse<PaginationData<PropertyData>>> getPropertyDetails(
      {String? id});

  Future<ApiResponse<CommonData>> createProperty(
    List<File> images,
    List<File>? floorPlanImages,
    Info info,
    String currency,
    Map<String, dynamic> other,
    List<String> amenities,
    File leasingPolicyDoc,
    List<Map<String, dynamic>> unitList,
  );

  Future<ApiResponse<CommonData>> getHostProperties(String id);

  Future<ApiResponse<CommonData>> deleteProperty(String id);

  Future<ApiResponse<CommonData>> updatePropertyStatus(String id, bool status);

  Future<ApiResponse<CommonData>> createPropertyV2(
      Map<String, dynamic> request);

  Future<ApiResponse<CommonData>> sendBulkEmails(Map<String, dynamic> request);

  Future<ApiResponse<CommonData>> getPropertyApplicationFee(String id);
}

final propertyRepository = locator<PropertyRepository>();
