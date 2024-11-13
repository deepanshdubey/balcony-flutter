import 'package:balcony/core/api/api_response/api_response.dart';
import 'package:balcony/data/model/response/pagination_data.dart';
import 'package:balcony/data/model/response/workspace_data.dart';

abstract class WorkspaceRepository {
  Future<ApiResponse<PaginationData<WorkspaceData>>> getWorkspace({
    String? status,
    String? sort,
    String? select,
    int? page,
    int? limit,
    bool? includeHost,
  });
}
