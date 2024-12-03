import 'package:balcony/core/locator/locator.dart';
import 'package:balcony/data/model/response/promo_list_model.dart';
import 'package:balcony/data/model/response/promo_model.dart';
import 'package:balcony/data/repository/promo_repository.dart';
import 'package:mobx/mobx.dart';

part 'promo_store.g.dart';

class PromoStore = _PromoStoreBase with _$PromoStore;

abstract class _PromoStoreBase with Store {
  @observable
  PromoModel? promoResponse;

  @observable
  PromoModel? createPromoResponse;

  @observable
  PromoListModel? promoListResponse;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future getPromo({
    String? code,
  }) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await promoRepository.getPromoCode(code: code);
      if (response.isSuccess) {
        promoResponse = response.data;
      } else {
        errorMessage = response.error!.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future createPromo({required Map<String, dynamic> request}) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await promoRepository.createPromo(request);
      if (response.isSuccess) {
        createPromoResponse = response.data;
      } else {
        errorMessage = response.error!.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future getPromoList({String? hostId}) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = hostId == null
          ? await promoRepository.promoList()
          : await promoRepository.getHostPromoList(hostId!);
      if (response.isSuccess) {
        promoListResponse = response.data;
      } else {
        errorMessage = response.error!.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }
}

final promoStore = PromoStore();
