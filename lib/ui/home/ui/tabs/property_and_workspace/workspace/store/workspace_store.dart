import 'dart:io';

import 'package:balcony/core/locator/locator.dart';
import 'package:balcony/data/model/response/common_data.dart';
import 'package:balcony/data/model/response/workspace_data.dart';
import 'package:balcony/data/repository/workspace_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'workspace_store.g.dart';

class WorkspaceStore = _WorkspaceStoreBase with _$WorkspaceStore;

abstract class _WorkspaceStoreBase with Store {
  @observable
  int totalPages = 0;

  @observable
  List<WorkspaceData>? workspaceResponse;

  @observable
  List<WorkspaceData>? searchWorkspaceResponse;

  @observable
  WorkspaceData? workspaceDetailsResponse;

  @observable
  CommonData? createWorkSpaceDetailsResponse;

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
}

final workspaceStore = WorkspaceStore();
