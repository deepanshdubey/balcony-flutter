import 'package:homework/core/api/api_response/api_response.dart';
import 'package:homework/core/locator/locator.dart';
import 'package:homework/data/model/response/common_data.dart';
import 'package:homework/ui/concierge/model/add_tenant_model.dart';
import 'package:homework/ui/concierge/model/concierge_property_response.dart';
import 'package:homework/ui/concierge/model/concierge_tanant_response.dart';
import 'package:homework/ui/concierge/model/maintenace_request_response.dart';
import 'package:homework/ui/concierge/model/ongoing_response.dart';
import 'package:homework/ui/concierge/model/parcel_response.dart';

abstract class ConciergeRepository {
  Future<ApiResponse<CommonData>> conciergeLogin(Map<String, dynamic> request);

  Future<ApiResponse<ConciergePropertyResponse>> conciergePropertyAll();

  Future<ApiResponse<ParcelResponse>> conciergeParcelMe();

  Future<ApiResponse<ConciergePropertyResponse>> conciergePropertyAdd(request);

  Future<ApiResponse<ConciergeTanantResponse>> conciergeTenantAll();

  Future<ApiResponse<AddTenantModel>> conciergeTenantAdd(request);

  Future<ApiResponse<ParcelResponse>> parcelAdd(String type, String tenantId);

  Future<ApiResponse<ParcelResponse>> parcelDelete(
      String type, String tenantId);

  Future<ApiResponse<ParcelResponse>> tenantDelete(String tenantId);

  Future<ApiResponse<OngoingResponse>> ongoingAll();

  Future<ApiResponse<CommonData>> ongoingToggle(String tenantId);

  Future<ApiResponse<CommonData>> ongoingAdd(request);

  Future<ApiResponse<MaintenaceRequestResponse>> maintenanceRequestAll();

  Future<ApiResponse<CommonData>> maintenanceToggle(String tenantId);

  Future<ApiResponse<CommonData>> maintenanceAdd(request);

  Future<ApiResponse<CommonData>> remindForPendingParcel();
}

final conciergeRepository = locator<ConciergeRepository>();
