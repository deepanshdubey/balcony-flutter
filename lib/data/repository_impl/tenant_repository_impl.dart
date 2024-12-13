import 'dart:convert';

import 'package:homework/core/api/api_response/api_response.dart';
import 'package:homework/data/model/response/common_data.dart';
import 'package:homework/data/remote/api_client.dart';
import 'package:homework/data/repository/tenant_repository.dart';
import 'package:homework/data/repository_impl/base_repository_impl.dart';

class TenantRepositoryImpl extends BaseRepositoryImpl
    implements TenantRepository {
  final ApiClient apiClient;

  TenantRepositoryImpl(this.apiClient);

  @override
  Future<ApiResponse<CommonData>> applyTenant(
      Map<String, dynamic> request) async {
    return await execute(apiClient.applyTenant(request));
  }


  Future<ApiResponse<CommonData>> getTenantsByHostId(String hostId, {List<String>? status}) async {
      return await execute(apiClient.getTenantsByHostId(hostId, jsonEncode(status)));
  }

}
