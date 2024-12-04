import 'dart:io';

import 'package:balcony/core/api/api_response/api_response.dart';
import 'package:balcony/core/locator/locator.dart';
import 'package:balcony/data/model/response/common_data.dart';
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

  Future<ApiResponse<PaginationData<WorkspaceData>>> getWorkspaceDetail(
      {String? id});

  Future<ApiResponse<CommonData>> getHostWorkspaces(String id);
  Future<ApiResponse<CommonData>> deleteWorkspace(String id);

  Future<ApiResponse<CommonData>> updateWorkspaceStatus(String id, bool status);

  Future<ApiResponse<PaginationData<WorkspaceData>>> searchWorkspace({
    String? place,
    String? checkin,
    String? checkout,
    int? people,
    int? page,
    int? limit,
    String? sort,
    String? select,
    bool? includeHost,
  });

  Future<ApiResponse<CommonData>> createWorkspace(
    List<File> images,
    Info info,
    Pricing pricing,
    Times times,
    Other other,
    List<String> amenities,
  );
}

final workspaceRepository = locator<WorkspaceRepository>();
