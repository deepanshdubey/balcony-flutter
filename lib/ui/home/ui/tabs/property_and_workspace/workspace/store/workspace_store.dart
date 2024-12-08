import 'dart:io';

import 'package:balcony/core/locator/locator.dart';
import 'package:balcony/core/session/app_session.dart';
import 'package:balcony/data/model/response/bookings_data.dart';
import 'package:balcony/data/model/response/common_data.dart';
import 'package:balcony/data/model/response/workspace_data.dart';
import 'package:balcony/data/repository/booking_repository.dart';
import 'package:balcony/data/repository/user_repository.dart';
import 'package:balcony/data/repository/workspace_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'workspace_store.g.dart';

class WorkspaceStore = _WorkspaceStoreBase with _$WorkspaceStore;

abstract class _WorkspaceStoreBase with Store {
  @observable
  int totalPages = 0;

  @observable
  bool?
      isBookingAccepted; // null initially, true for accepted, false for rejected

  @action
  Future<void> handleBooking(String id, bool accept) async {
    try {
      errorMessage = null;
      isLoading = true;

      final response = accept
          ? await bookingRepository.acceptBooking(id)
          : await bookingRepository.rejectBooking(id);

      if (response.isSuccess) {
        isBookingAccepted = accept;
      } else {
        errorMessage = response.error?.message ?? "Something went wrong";
        isBookingAccepted = null; // Reset to null if operation failed
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
      isBookingAccepted = null; // Reset to null on exception
    } finally {
      isLoading = false;
    }
  }

  @observable
  List<WorkspaceData>? workspaceResponse;

  @observable
  List<BookingsData>? bookingsResponse;

  @observable
  List<WorkspaceData>? searchWorkspaceResponse;

  @observable
  WorkspaceData? workspaceDetailsResponse;

  @observable
  CommonData? createWorkSpaceDetailsResponse;

  @observable
  CommonData? workspaceStatusResponse;

  @observable
  CommonData? createBookingResponse;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future getWorkspace(
      {String? status,
      String? sort,
      String? select,
      int? page,
      int? limit,
      bool? includeHost}) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await workspaceRepository.getWorkspace(
          status: status,
          sort: sort,
          select: select,
          page: page,
          limit: limit,
          includeHost: includeHost);
      if (response.isSuccess) {
        workspaceResponse = response.data?.data?.result ?? [];
        totalPages = response.data?.data?.totalPages ?? 0;
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
  Future getWorkspaceDetail({
    String? id,
  }) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await workspaceRepository.getWorkspaceDetail(id: id);
      if (response.isSuccess) {
        workspaceDetailsResponse = response.data?.workspace;
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
  Future createWorkSpace(
    List<File> images,
    Info info,
    Pricing pricing,
    Times times,
    Other other,
    List<String> amenities,
  ) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await workspaceRepository.createWorkspace(
          images, info, pricing, times, other, amenities);
      if (response.isSuccess) {
        createWorkSpaceDetailsResponse = response.data;
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
  Future updateWorkspace(
    String id,
    List<String> images,
    Info info,
    Pricing pricing,
    Times times,
    Other other,
    List<String> amenities,
  ) async {
    try {
      errorMessage = null;
      isLoading = true;

      // Separate file paths from URLs
      List<String> localFilePaths = [];
      List<int> fileIndices = []; // To track positions of file paths

      for (int i = 0; i < images.length; i++) {
        if (!images[i].startsWith('http://') &&
            !images[i].startsWith('https://')) {
          localFilePaths.add(images[i]);
          fileIndices.add(i);
        }
      }

      // If there are files to upload
      if (localFilePaths.isNotEmpty) {
        final response = await userRepository.uploadFiles(localFilePaths
            .map(
              (e) => File(e),
            )
            .toList());

        if (response.isSuccess) {
          final List<String> uploadedUrls = response.data?.urls ?? [];
          // Replace file paths with server URLs
          for (int j = 0; j < fileIndices.length; j++) {
            images[fileIndices[j]] = uploadedUrls[j];
          }
        } else {
          errorMessage = response.error!.message;
          return;
        }
      }

      // Proceed with updated images list
      final response = await workspaceRepository.updateWorkspace(
        id,
        images,
        info,
        pricing,
        times,
        other,
        amenities,
      );

      if (response.isSuccess) {
        createWorkSpaceDetailsResponse = response.data;
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
  Future createBooking(Map<String, dynamic> request) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await bookingRepository.createBooking(request);
      if (response.isSuccess) {
        createBookingResponse = response.data;
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
  Future searchWorkspace({
    String? id,
    String? place,
    String? checkin,
    String? checkout,
    int? people,
    int? page,
    int? limit,
    String? sort,
    String? select,
    bool? includeHost,
  }) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await workspaceRepository.searchWorkspace(
        place: place,
        checkin: checkin,
        checkout: checkout,
        people: people,
        page: page,
        limit: limit,
        sort: sort,
        select: select,
        includeHost: includeHost,
      );
      if (response.isSuccess) {
        searchWorkspaceResponse = response.data?.data?.result ?? [];
        debugPrint("$searchWorkspaceResponse");
        totalPages = response.data?.data?.totalPages ?? 0;
      } else {
        errorMessage = response.error?.message ?? "Something went wrong";
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @computed
  num get totalFee {
    return (workspaceDetailsResponse?.pricing?.cleaning?.fee ?? 0) +
        (workspaceDetailsResponse?.pricing?.maintenance?.fee ?? 0) +
        (workspaceDetailsResponse?.pricing?.additional?.fee ?? 0);
  }

  @action
  Future getHostWorkspaces() async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await workspaceRepository
          .getHostWorkspaces(session.user.id.toString());
      if (response.isSuccess) {
        workspaceResponse = response.data?.workspaces;
        totalPages = workspaceResponse?.length ?? 0;
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
  Future updateWorkspaceStatus(String id, bool status) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response =
          await workspaceRepository.updateWorkspaceStatus(id, status);
      if (response.isSuccess) {
        workspaceStatusResponse = response.data;
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
  Future deleteWorkspace(String id) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await workspaceRepository.deleteWorkspace(id);
      if (response.isSuccess) {
        getHostWorkspaces();
      } else {
        isLoading = false;
        errorMessage = response.error!.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      isLoading = false;
      errorMessage = e.toString();
    } finally {}
  }

  @action
  Future getOngoingBookings() async {
    try {
      errorMessage = null;
      isLoading = true;
      const status = '["pending", "in progress"]';
      final response = await bookingRepository.getHostBookings(
          session.user.id.toString(), status);
      if (response.isSuccess) {
        bookingsResponse = response.data?.bookings;
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
      const status = '["done", "partially refunded", "canceled"]';
      final response = await bookingRepository.getHostBookings(
          session.user.id.toString(), status);
      if (response.isSuccess) {
        bookingsResponse = response.data?.bookings;
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

final workspaceStore = WorkspaceStore();
