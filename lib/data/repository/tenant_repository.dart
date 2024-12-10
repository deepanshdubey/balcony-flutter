import 'package:homework/core/api/api_response/api_response.dart';
import 'package:homework/core/locator/locator.dart';
import 'package:homework/data/model/response/common_data.dart';

abstract class TenantRepository {
  Future<ApiResponse<CommonData>> applyTenant(Map<String, dynamic> request);
}

final tenantRepository = locator<TenantRepository>();