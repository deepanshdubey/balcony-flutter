
import 'package:homework/core/api/api_response/api_response.dart';
import 'package:homework/data/model/response/pagination_data.dart';
import 'package:homework/data/model/response/promo_list_model.dart';
import 'package:homework/data/model/response/promo_model.dart';
import 'package:homework/data/model/response/property_data.dart';
import 'package:homework/data/model/response/workspace_data.dart';
import 'package:homework/data/remote/api_client.dart';
import 'package:homework/data/repository/promo_repository.dart';
import 'package:homework/data/repository/property_repository.dart';
import 'package:homework/data/repository/workspace_repository.dart';
import 'package:homework/data/repository_impl/base_repository_impl.dart';

class PromoRepositoryImpl extends BaseRepositoryImpl
    implements PromoRepository {
  final ApiClient apiClient;

  PromoRepositoryImpl(this.apiClient);

  @override
  Future<ApiResponse<PromoModel>> getPromoCode({String? code}) {
      return execute(apiClient.getPromoCode(code!));
  }

  @override
  Future<ApiResponse<PromoModel>> createPromo(Map<String, dynamic> request) {
    return execute(apiClient.createPromo(request));
  }

  @override
  Future<ApiResponse<PromoListModel>> promoList() {
    return execute(apiClient.getPromoCodeList());
  }

  @override
  Future<ApiResponse<PromoListModel>> getHostPromoList(String hostId) {
    return execute(apiClient.getHostPromoList(hostId));
  }




}
