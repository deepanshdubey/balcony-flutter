import 'package:homework/core/locator/locator.dart';
import 'package:homework/data/model/response/bookings_data.dart';
import 'package:homework/data/model/response/common_data.dart';
import 'package:homework/data/repository/booking_repository.dart';
import 'package:mobx/mobx.dart';

part 'booking_listing_store.g.dart';

class BookingListingStore = _BookingListingStoreBase with _$BookingListingStore;

abstract class _BookingListingStoreBase with Store {
  @observable
  List<BookingsData>? bookingsInProgress;

  @observable
  CommonData? cancelBookingResponse;

  @observable
  List<BookingsData>? pastBookings;

  @observable
  BookingsData? bookingDetails;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future getOngoingBookings() async {
    try {
      errorMessage = null;
      isLoading = true;
      const status = ["pending", "in progress"];
      final response = await bookingRepository.getMyBookings(status);
      if (response.isSuccess) {
        bookingsInProgress = response.data?.bookings;
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
  Future getPastBookings() async {
    try {
      errorMessage = null;
      isLoading = true;
      const status = ["done", "partially refunded", "canceled"];
      final response = await bookingRepository.getMyBookings(status);
      if (response.isSuccess) {
        pastBookings = response.data?.bookings;
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
  Future getBookingDetails(String id) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await bookingRepository.getBookingById(id);
      if (response.isSuccess) {
        bookingDetails = response.data?.booking;
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
  Future cancelBooking(String id, bool isHost) async {
    try {
      errorMessage = null;
      isLoading = true;

      // Determine the API endpoint based on the user type
      final response = isHost
          ? await bookingRepository.cancelBookingByHost(id)
          : await bookingRepository.cancelBookingByUser(id);

      if (response.isSuccess) {
        cancelBookingResponse = response.data;
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

final bookingListingStore = BookingListingStore();
