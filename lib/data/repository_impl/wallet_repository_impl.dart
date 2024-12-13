import 'package:homework/core/api/api_response/api_response.dart';
import 'package:homework/data/model/response/common_data.dart';
import 'package:homework/data/remote/api_client.dart';
import 'package:homework/data/repository/wallet_repository.dart';
import 'package:homework/data/repository_impl/base_repository_impl.dart';

class WalletRepositoryImpl extends BaseRepositoryImpl
    implements WalletRepository {
  final ApiClient apiClient;

  WalletRepositoryImpl(this.apiClient);

  @override
  Future<ApiResponse<CommonData>> createCard(Map<String, dynamic> request) {
    return execute(apiClient.createCard(request));
  }

  @override
  Future<ApiResponse<CommonData>> deleteCard(String id) {
    return execute(apiClient.deleteCard(id));
  }

  @override
  Future<ApiResponse<CommonData>> getAllCards() {
    return execute(apiClient.getAllCards());
  }

  @override
  Future<ApiResponse<CommonData>> setDefaultCard(String id) {
    return execute(apiClient.setDefaultCard(id));
  }

  @override
  Future<ApiResponse<CommonData>> updateCard(
      String id, Map<String, dynamic> request) {
    return execute(apiClient.updateCard(id, request));
  }
}
