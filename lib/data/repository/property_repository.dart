import 'package:balcony/core/api/api_response/api_response.dart';
import 'package:balcony/core/locator/locator.dart';
import 'package:balcony/data/model/response/pagination_data.dart';
import 'package:balcony/data/model/response/property_data.dart';


abstract class PropertyRepository {
  Future<ApiResponse<PaginationData<PropertyData>>> getProperties({
    String? status,
    String? sort,
    String? select,
    int? page,
    int? limit,
    bool? includeHost,
  });

  Future<ApiResponse<PaginationData<PropertyData>>> getPropertyDetails({String? id});
}

final propertyRepository = locator<PropertyRepository>();
