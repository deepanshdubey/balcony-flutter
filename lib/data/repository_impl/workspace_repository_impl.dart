import 'dart:io';

import 'package:balcony/core/api/api_response/api_response.dart';
import 'package:balcony/data/model/response/common_data.dart';
import 'package:balcony/data/model/response/pagination_data.dart';
import 'package:balcony/data/model/response/workspace_data.dart';
import 'package:balcony/data/model/response/workspace_detail_data.dart';
import 'package:balcony/data/remote/api_client.dart';
import 'package:balcony/data/repository/workspace_repository.dart';
import 'package:balcony/data/repository_impl/base_repository_impl.dart';

class WorkspaceRepositoryImpl extends BaseRepositoryImpl
    implements WorkspaceRepository {
  final ApiClient apiClient;

  WorkspaceRepositoryImpl(this.apiClient);

  @override
  Future<ApiResponse<PaginationData<WorkspaceData>>> getWorkspace(
      {String? status,
        String? sort,
        String? select,
        int? page,
        int? limit,
        bool? includeHost}) {
    return execute(apiClient.getWorkSpaces(
        status, sort, select, page, limit, includeHost));
  }

  @override
  Future<ApiResponse<WorkspaceData>> getWorkspaceDetail({String? id}) {
    return execute(apiClient.getWorkspaceDetails(id!));
  }

  @override
  Future<ApiResponse<CommonData>> createWorkspace(List<File> images, Info info,
      Pricing pricing, Times times, Other other, List<String> amenities) {
    throw execute(apiClient.createWorkspace(images, info, pricing, times, other, amenities));
  }

}
