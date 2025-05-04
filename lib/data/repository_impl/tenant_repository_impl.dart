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

  @override
  Future<ApiResponse<CommonData>> updateTenant(
      String id, Map<String, dynamic> request) async {
    return await execute(apiClient.updateTenant(id, request));
  }

  @override
  Future<ApiResponse<CommonData>> approveTenant(String id, Map<String, dynamic> request) async {
    return await execute(apiClient.approveTenant(id, request));
  }

  @override
  Future<ApiResponse<CommonData>> rejectTenant(String id) async {
    return await execute(apiClient.rejectTenant(id));
  }
  @override
  Future<ApiResponse<CommonData>> getTenantsByHostId(String hostId,
      {List<String>? status}) async {
    return await execute(apiClient.getTenantsByHostId(hostId, jsonEncode(status)));
  }
  @override
  Future<ApiResponse<CommonData>> tenantPayment( Map<String, dynamic> request) async {
    return await execute(apiClient.tenantPayment(request));
  }

  @override
  Future<ApiResponse<CommonData>> getTenantVerificationToken(String type, String tenantId) async {
    return await execute(apiClient.getTenantVerificationToken(type, tenantId));
  }

  @override
  Future<ApiResponse<CommonData>> updateTenantVerification(String type, String tenantId, String token) async {
   return await execute(apiClient.updateTenantVerification(type, tenantId, token));
  }
}
