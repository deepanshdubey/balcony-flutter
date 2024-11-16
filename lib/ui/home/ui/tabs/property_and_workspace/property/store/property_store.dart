import 'package:balcony/core/locator/locator.dart';
import 'package:balcony/data/model/response/property_data.dart';
import 'package:balcony/data/repository/property_repository.dart';
import 'package:mobx/mobx.dart';

part 'property_store.g.dart';

class PropertyStore = _PropertyStoreBase with _$PropertyStore;

abstract class _PropertyStoreBase with Store {
  @observable
  List<PropertyData>? propertyResponse;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future getProperty(
      {String? status,
        String? sort,
        String? select,
        int? page,
        int? limit,
        bool? includeHost}) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await propertyRepository.getProperties(
          status: status,
          sort: sort,
          select: select,
          page: page,
          limit: limit,
          includeHost: includeHost);
      if (response.isSuccess) {
        propertyResponse = response.data?.data?.result ?? [];
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
