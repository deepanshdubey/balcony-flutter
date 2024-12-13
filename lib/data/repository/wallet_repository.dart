import 'package:homework/core/api/api_response/api_response.dart';
import 'package:homework/core/locator/locator.dart';
import 'package:homework/data/model/response/common_data.dart';

abstract class WalletRepository {
  Future<ApiResponse<CommonData>> createCard(Map<String, dynamic> request);

  Future<ApiResponse<CommonData>> updateCard(String id, Map<String, dynamic> request);

  Future<ApiResponse<CommonData>> setDefaultCard(String id);

  Future<ApiResponse<CommonData>> getAllCards();

  Future<ApiResponse<CommonData>> deleteCard(String id);
}

final walletRepository = locator<WalletRepository>();
