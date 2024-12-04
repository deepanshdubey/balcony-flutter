import 'package:balcony/core/locator/locator.dart';
import 'package:balcony/data/model/response/common_data.dart';
import 'package:balcony/data/repository/booking_repository.dart';
import 'package:balcony/data/repository/user_repository.dart';
import 'package:mobx/mobx.dart';

part 'dashboard_store.g.dart';

class DashboardStore = _DashboardStoreBase with _$DashboardStore;

abstract class _DashboardStoreBase with Store {
  @observable
  CommonData? autoStatusResponse;

  @observable
  CommonData? earningsResponse;

  @observable
  String? updatePayoutInfoResponse;
  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future autoStatus({
    bool? isBooking,
  }) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = isBooking == null
          ? await bookingRepository.getAutoStatus()
          : isBooking == true
              ? await bookingRepository.toggleAcceptBooking()
              : await bookingRepository.toggleRentPayment();
      if (response.isSuccess) {
        autoStatusResponse = response.data;
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
  Future updatePayoutInfo({
    bool isWorkspace = true,
  }) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await userRepository
          .updatePayoutInfo(isWorkspace ? "workspaces" : "properties");
      if (response.isSuccess) {
        updatePayoutInfoResponse = response.data?.url;
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
  Future getEarnings(
    String hostId, {
    bool isWorkspace = true,
  }) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await userRepository
          .getEarnings(hostId,isWorkspace ? "workspaces" : "properties");
      if (response.isSuccess) {
        earningsResponse = response.data;
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
