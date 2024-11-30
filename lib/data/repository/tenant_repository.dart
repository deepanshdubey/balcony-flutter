import 'package:balcony/core/api/api_response/api_response.dart';
import 'package:balcony/core/locator/locator.dart';
import 'package:balcony/data/model/response/common_data.dart';

abstract class TenantRepository {
  Future<ApiResponse<CommonData>> applyTenant(Map<String, dynamic> request);
}

final tenantRepository = locator<TenantRepository>();