import 'package:homework/core/locator/locator.dart';
import 'package:homework/data/model/response/common_data.dart';
import 'package:homework/data/repository/property_repository.dart';
import 'package:mobx/mobx.dart';

part 'tenant_application_store.g.dart';

class TenantApplicationStore = _TenantApplicationStoreBase
    with _$TenantApplicationStore;

abstract class _TenantApplicationStoreBase with Store {
  final String propertyId;

  @observable
  bool isLoadingApplicationFee = false;

  @observable
  String? errorMessage;

  @observable
  num applicationFeeResponse = 0;

  _TenantApplicationStoreBase({required this.propertyId}) {
    getPropertyApplicationFee(id: propertyId);
  }

  @action
  Future getPropertyApplicationFee({required String id}) async {
    try {
      errorMessage = null;
      isLoadingApplicationFee = true;
      final response = await propertyRepository.getPropertyApplicationFee(id);
      if (response.isSuccess) {
        applicationFeeResponse = response.data?.applicationFee ?? 0;
      } else {
        errorMessage = response.error!.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isLoadingApplicationFee = false;
    }
  }
}
