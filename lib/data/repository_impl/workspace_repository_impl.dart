import 'dart:io';

import 'package:balcony/core/api/api_response/api_response.dart';
import 'package:balcony/data/model/response/common_data.dart';
import 'package:balcony/data/model/response/pagination_data.dart';
import 'package:balcony/data/model/response/workspace_data.dart';
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
        status ?? 'active', sort, select, page, limit, includeHost));
  }

  @override
  Future<ApiResponse<PaginationData<WorkspaceData>>> getWorkspaceDetail(
      {String? id}) {
    return execute(apiClient.getWorkspaceDetails(id!));
  }

  @override
  Future<ApiResponse<CommonData>> createWorkspace(List<File> images, Info info,
      Pricing pricing, Times times, Other other, List<String> amenities) async {
    var list = await prepareImageFiles(images);
    return execute(apiClient.createWorkspace(
        list, info, pricing, times, other, amenities.join(',')));
  }

  @override
  Future<ApiResponse<PaginationData<WorkspaceData>>> searchWorkspace(
      {String? place,
      String? checkin,
      String? checkout,
      int? people,
      int? page,
      int? limit,
      String? sort,
      String? select,
      bool? includeHost}) {
    return execute(apiClient.searchWorkspace(place, checkin, checkout, people,
        page, limit, sort, select, includeHost));
  }

  @override
  Future<ApiResponse<CommonData>> getHostWorkspaces(String id) {
    return execute(apiClient.getHostWorkspaces(id));
  }

  @override
  Future<ApiResponse<CommonData>> updateWorkspaceStatus(
      String id, bool status) {
    return execute(
        apiClient.updateWorkspaceStatus(id, status ? 'active' : 'inactive'));
  }

  @override
  Future<ApiResponse<CommonData>> deleteWorkspace(String id) {
    return execute(apiClient.deleteWorkspace(id));
  }
}
