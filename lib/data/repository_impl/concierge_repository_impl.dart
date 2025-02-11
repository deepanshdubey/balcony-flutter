import 'package:homework/core/api/api_response/api_response.dart';
import 'package:homework/data/model/response/common_data.dart';
import 'package:homework/data/remote/api_client.dart';
import 'package:homework/data/repository/concierge_repo.dart';
import 'package:homework/data/repository_impl/base_repository_impl.dart';
import 'package:homework/ui/concierge/model/add_tenant_model.dart';
import 'package:homework/ui/concierge/model/concierge_property_response.dart';
import 'package:homework/ui/concierge/model/concierge_tanant_response.dart';
import 'package:homework/ui/concierge/model/maintenace_request_response.dart';
import 'package:homework/ui/concierge/model/ongoing_response.dart';
import 'package:homework/ui/concierge/model/parcel_response.dart';

class ConciergeRepositoryImpl extends BaseRepositoryImpl
    implements ConciergeRepository {
  final ApiClient apiClient;

  ConciergeRepositoryImpl(this.apiClient);

  @override
  Future<ApiResponse<CommonData>> conciergeLogin(Map<String, dynamic> request) {
    return execute(apiClient.conciergeLogin(request));
  }

  @override
  Future<ApiResponse<ConciergePropertyResponse>> conciergePropertyAll() {
    return execute(apiClient.conciergePropertyAll());
  }

  @override
  Future<ApiResponse<ConciergeTanantResponse>> conciergeTenantAll() {
    return execute(apiClient.conciergeTenantAll());
  }

  @override
  Future<ApiResponse<AddTenantModel>> conciergeTenantAdd(request) {
    return execute(apiClient.conciergeTenantAdd(request));
  }

  @override
  Future<ApiResponse<ConciergePropertyResponse>> conciergePropertyAdd(request) {
    return execute(apiClient.conciergePropertyAdd(request));
  }

  @override
  Future<ApiResponse<ParcelResponse>> conciergeParcelMe() {
    return execute(apiClient.conciergeParcelMe());
  }

  @override
  Future<ApiResponse<ParcelResponse>> parcelAdd(String type, String tenantId) {
    return execute(apiClient.parcelAdd(type, tenantId));
  }

  @override
  Future<ApiResponse<ParcelResponse>> parcelDelete(
      String type, String tenantId) {
    return execute(apiClient.parcelDelete(type, tenantId));
  }

  @override
  Future<ApiResponse<ParcelResponse>> tenantDelete(String tenantId) {
    return execute(apiClient.tenantDelete(tenantId));
  }

  @override
  Future<ApiResponse<OngoingResponse>> ongoingAll() {
    return execute(apiClient.ongoingAll());
  }

  @override
  Future<ApiResponse<CommonData>> ongoingToggle(String tenantId) {
    return execute(apiClient.ongoingToggleStatus(tenantId));
  }

  @override
  Future<ApiResponse<CommonData>> ongoingAdd(request) {
    return execute(apiClient.ongoingAdd(request));
  }


  @override
  Future<ApiResponse<MaintenaceRequestResponse>> maintenanceRequestAll() {
    return execute(apiClient.maintenanceRequestAll());
  }

  @override
  Future<ApiResponse<CommonData>> maintenanceToggle(String tenantId) {
    return execute(apiClient.maintenanceRequestToggle(tenantId));
  }

  @override
  Future<ApiResponse<CommonData>> maintenanceAdd(request) {
    return execute(apiClient.maintenanceRequestsAdd(request));
  }
}
