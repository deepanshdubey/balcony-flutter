import 'package:balcony/core/api/api_response/api_response.dart';
import 'package:balcony/data/model/response/common_data.dart';
import 'package:balcony/data/remote/api_client.dart';
import 'package:balcony/data/repository/booking_repository.dart';
import 'package:balcony/data/repository_impl/base_repository_impl.dart';

class BookingRepositoryImpl extends BaseRepositoryImpl
    implements BookingRepository {
  final ApiClient apiClient;

  BookingRepositoryImpl(this.apiClient);

  @override
  Future<ApiResponse<CommonData>> createBooking(
      Map<String, dynamic> request) async {
    return await execute(apiClient.createBooking(request));
  }

  @override
  Future<ApiResponse<CommonData>> acceptBooking(String id) async {
    return await execute(apiClient.acceptBooking(id));
  }

  @override
  Future<ApiResponse<CommonData>> rejectBooking(String id) async {
    return await execute(apiClient.rejectBooking(id));
  }

  @override
  Future<ApiResponse<CommonData>> getMyBookings(String status) async {
    return await execute(apiClient.getMyBookings(status));
  }

  @override
  Future<ApiResponse<CommonData>> getHostBookings(String hostId) async {
    return await execute(apiClient.getHostBookings(hostId));
  }

  @override
  Future<ApiResponse<CommonData>> getBookedDates(String hostId) async {
    return await execute(apiClient.getBookedDates(hostId));
  }

  @override
  Future<ApiResponse<CommonData>> getAllBookings() async {
    return await execute(apiClient.getAllBookings());
  }

  @override
  Future<ApiResponse<CommonData>> getBookingById(String bookingId) async {
    return await execute(apiClient.getBookingById(bookingId));
  }

  @override
  Future<ApiResponse<CommonData>> refundBooking(
      Map<String, dynamic> request) async {
    return await execute(apiClient.refundBooking(request));
  }

  @override
  Future<ApiResponse<CommonData>> cancelBookingByHost(String bookingId) async {
    return await execute(apiClient.cancelBookingByHost(bookingId));
  }

  @override
  Future<ApiResponse<CommonData>> cancelBookingByUser(String bookingId) async {
    return await execute(apiClient.cancelBookingByUser(bookingId));
  }

  @override
  Future<ApiResponse<CommonData>> rateBooking(
      Map<String, dynamic> request) async {
    return await execute(apiClient.rateBooking(request));
  }
}
