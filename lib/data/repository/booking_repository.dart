import 'package:balcony/core/api/api_response/api_response.dart';
import 'package:balcony/core/locator/locator.dart';
import 'package:balcony/data/model/response/common_data.dart';

abstract class BookingRepository {
  Future<ApiResponse<CommonData>> createBooking(Map<String, dynamic> request);

  Future<ApiResponse<CommonData>> acceptBooking(String id);

  Future<ApiResponse<CommonData>> rejectBooking(String id);

  Future<ApiResponse<CommonData>> getMyBookings(List<String> status);

  Future<ApiResponse<CommonData>> getHostBookings(String hostId);

  Future<ApiResponse<CommonData>> getBookedDates(String hostId);

  Future<ApiResponse<CommonData>> getAllBookings();

  Future<ApiResponse<CommonData>> getBookingById(String bookingId);

  Future<ApiResponse<CommonData>> refundBooking(Map<String, dynamic> request);

  Future<ApiResponse<CommonData>> cancelBookingByHost(String bookingId);

  Future<ApiResponse<CommonData>> cancelBookingByUser(String bookingId);

  Future<ApiResponse<CommonData>> rateBooking(Map<String, dynamic> request);

  Future<ApiResponse<CommonData>> getAutoStatus();

  Future<ApiResponse<CommonData>> toggleAcceptBooking();

  Future<ApiResponse<CommonData>> toggleRentPayment();
}

final bookingRepository = locator<BookingRepository>();
