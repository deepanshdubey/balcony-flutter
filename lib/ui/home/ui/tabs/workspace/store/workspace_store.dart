import 'package:balcony/core/locator/locator.dart';
import 'package:balcony/data/model/response/workspace_data.dart';
import 'package:balcony/data/repository/workspace_repository.dart';
import 'package:mobx/mobx.dart';

part 'workspace_store.g.dart';

class WorkspaceStore = _WorkspaceStoreBase with _$WorkspaceStore;

abstract class _WorkspaceStoreBase with Store {
  @observable
  List<WorkspaceData>? workspaceResponse;

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
        workspaceResponse =
            response.data?.data?.items?.firstOrNull?.result ?? [];
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
