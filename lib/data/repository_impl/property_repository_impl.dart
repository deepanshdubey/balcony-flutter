import 'dart:io';

import 'package:balcony/core/api/api_response/api_response.dart';
import 'package:balcony/data/model/response/common_data.dart';
import 'package:balcony/data/model/response/pagination_data.dart';
import 'package:balcony/data/model/response/property_data.dart';
import 'package:balcony/data/model/response/workspace_data.dart';
import 'package:balcony/data/remote/api_client.dart';
import 'package:balcony/data/repository/property_repository.dart';
import 'package:balcony/data/repository_impl/base_repository_impl.dart';

class PropertyRepositoryImpl extends BaseRepositoryImpl
    implements PropertyRepository {
  final ApiClient apiClient;

  PropertyRepositoryImpl(this.apiClient);

  @override
  Future<ApiResponse<PaginationData<PropertyData>>> getProperties(
      {String? status,
      String? sort,
      String? select,
      int? page,
      int? limit,
      bool? includeHost}) {
    return execute(apiClient.getProperties(
        status, sort, select, page, limit, includeHost));
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
    File? leasingPolicyDoc,
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
      unitList,
      other,
      amenities.join(','),
      leasingPolicyDoc,
    ));
  }
}
