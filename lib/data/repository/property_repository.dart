import 'dart:io';

import 'package:balcony/core/api/api_response/api_response.dart';
import 'package:balcony/core/locator/locator.dart';
import 'package:balcony/data/model/response/common_data.dart';
import 'package:balcony/data/model/response/pagination_data.dart';
import 'package:balcony/data/model/response/property_data.dart';
import 'package:balcony/data/model/response/workspace_data.dart';

abstract class PropertyRepository {
  Future<ApiResponse<PaginationData<PropertyData>>> getProperties({
    String? status,
    String? sort,
    String? select,
    int? page,
    int? limit,
    bool? includeHost,
    String? query,
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
    File? leasingPolicyDoc,
    List<Map<String, dynamic>> unitList,
  );
}

final propertyRepository = locator<PropertyRepository>();
