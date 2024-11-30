import 'package:balcony/core/api/api_response/api_response.dart';
import 'package:balcony/data/model/response/common_data.dart';
import 'package:balcony/data/remote/api_client.dart';
import 'package:balcony/data/repository/tenant_repository.dart';
import 'package:balcony/data/repository_impl/base_repository_impl.dart';

class TenantRepositoryImpl extends BaseRepositoryImpl
    implements TenantRepository {
  final ApiClient apiClient;

  TenantRepositoryImpl(this.apiClient);

  @override
  Future<ApiResponse<CommonData>> applyTenant(
      Map<String, dynamic> request) async {
    return await execute(apiClient.applyTenant(request));
  }

}
