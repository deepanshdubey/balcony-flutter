import 'dart:convert';
import 'dart:io';

import 'package:homework/core/api/api_response/api_response.dart';
import 'package:homework/data/model/response/common_data.dart';
import 'package:homework/data/model/response/pagination_data.dart';
import 'package:homework/data/model/response/property_data.dart';
import 'package:homework/data/model/response/workspace_data.dart';
import 'package:homework/data/remote/api_client.dart';
import 'package:homework/data/repository/property_repository.dart';
import 'package:homework/data/repository_impl/base_repository_impl.dart';

class PropertyRepositoryImpl extends BaseRepositoryImpl
    implements PropertyRepository {
  final ApiClient apiClient;

  PropertyRepositoryImpl(this.apiClient);

  @override
  Future<ApiResponse<PaginationData<PropertyData>>> getProperties({
    String? status,
    String? sort,
    String? select,
    int? page,
    int? limit,
    bool? includeHost,
    String? query,
  }) {
    var query = jsonEncode({"status": status ?? 'active'});
    return execute(
        apiClient.getProperties(query, sort, select, page, limit, includeHost));
  }

  @override
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
  }) {
    return execute(apiClient.searchProperty(
        place,
        beds,
        baths,
        minrange,
        maxrange,
        page,
        limit,
        sort,
        select,
        includeHost,
        includeUnitList) as Future<PaginationData<PropertyData>>);
  }

  @override
  Future<ApiResponse<PaginationData<PropertyData>>> getPropertyDetails(
      {String? id}) {
    return execute(apiClient.getPropertyDetails(id!));
  }

  @override
  Future<ApiResponse<CommonData>> createProperty(
    List<File> images,
    List<File>? floorPlanImages,
    Info info,
    String currency,
    Map<String, dynamic> other,
    List<String> amenities,
    File leasingPolicyDoc,
    List<Map<String, dynamic>> unitList,
  ) async {
    var list = await prepareImageFiles(images);
    var list2 = floorPlanImages != null
        ? await prepareImageFiles(floorPlanImages)
        : null;
    return execute(apiClient.createProperty(
      list,
      list2,
      info,
      currency,
      jsonEncode(unitList),
      other,
      amenities.join(','),
      leasingPolicyDoc,
    ));
  }

  @override
  Future<ApiResponse<CommonData>> deleteProperty(String id) {
    return execute(apiClient.deleteProperty(id));
  }

  @override
  Future<ApiResponse<CommonData>> getHostProperties(String id) {
    return execute(apiClient.getHostProperties(id));
  }

  @override
  Future<ApiResponse<CommonData>> updatePropertyStatus(String id, bool status) {
    return execute(
        apiClient.updatePropertyStatus(id, status ? 'active' : 'inactive'));
  }
}
