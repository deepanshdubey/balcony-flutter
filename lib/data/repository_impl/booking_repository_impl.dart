import 'dart:convert';

import 'package:homework/core/api/api_response/api_response.dart';
import 'package:homework/data/model/response/common_data.dart';
import 'package:homework/data/remote/api_client.dart';
import 'package:homework/data/repository/booking_repository.dart';
import 'package:homework/data/repository_impl/base_repository_impl.dart';

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
  Future<ApiResponse<CommonData>> getMyBookings(List<String> status) async {
    return await execute(apiClient.getMyBookings(jsonEncode(status)));
  }


  @override
  Future<ApiResponse<CommonData>> getMyTenant(List<String> status) async {
    return await execute(apiClient.getTenant(jsonEncode(status)));
  }

  @override
  Future<ApiResponse<CommonData>> getHostBookings(String hostId, String? status) async {
    return await execute(apiClient.getHostBookings(hostId,status));
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

  @override
  Future<ApiResponse<CommonData>> getAutoStatus() {
    return execute(apiClient.getAutoStatus("booking" , "Anything"));
  }

  @override
  Future<ApiResponse<CommonData>> toggleAcceptBooking() {
    return execute(apiClient.toggleAcceptBooking());
  }

  @override
  Future<ApiResponse<CommonData>> toggleRentPayment() {
    return execute(apiClient.toggleRentPayment());
  }
}
