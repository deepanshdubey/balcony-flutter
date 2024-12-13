import 'package:homework/core/api/api_response/api_response.dart';
import 'package:homework/core/locator/locator.dart';
import 'package:homework/data/model/response/promo_list_model.dart';
import 'package:homework/data/model/response/promo_model.dart';


abstract class PromoRepository {


  Future<ApiResponse<PromoModel>> getPromoCode({String?  code});


  Future<ApiResponse<PromoModel>> createPromo(Map<String, dynamic> request);
  Future<ApiResponse<PromoListModel>> promoList();
  Future<ApiResponse<PromoListModel>> getHostPromoList(String hostId);
}

final promoRepository = locator<PromoRepository>();
