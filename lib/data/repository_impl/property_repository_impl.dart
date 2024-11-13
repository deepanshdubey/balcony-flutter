
import 'package:balcony/core/api/api_response/api_response.dart';
import 'package:balcony/data/model/response/pagination_data.dart';
import 'package:balcony/data/model/response/property_data.dart';
import 'package:balcony/data/model/response/workspace_data.dart';
import 'package:balcony/data/remote/api_client.dart';
import 'package:balcony/data/repository/property_repository.dart';
import 'package:balcony/data/repository/workspace_repository.dart';
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
    return execute(apiClient.getProperties(status, sort, select, page, limit, includeHost));
  }
}
