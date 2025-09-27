import 'package:mobx/mobx.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'connectivity_store.g.dart';

class ConnectivityStore = _ConnectivityStoreBase with _$ConnectivityStore;

abstract class _ConnectivityStoreBase with Store {
  final Connectivity _connectivity = Connectivity();

  @observable
  ConnectivityResult connectivityResult = ConnectivityResult.none;

  @observable
  bool isDialogShown = false;

  _ConnectivityStoreBase() {
    // Listen for connectivity changes
    _connectivity.onConnectivityChanged.listen(( result) {
      setConnectivityResult(result.first);
    });

    // Check initial connectivity
    checkInitialConnectivity();
  }

  @action
  Future<void> setConnectivityResult(ConnectivityResult result) async {
    connectivityResult = result;

    if (connectivityResult == ConnectivityResult.none && !isDialogShown) {
      isDialogShown = true; // Prevent showing multiple dialogs
    } else if (connectivityResult != ConnectivityResult.none) {
      isDialogShown = false; // Allow dialog to close
    }
  }

  @action
  Future<void> checkInitialConnectivity() async {
    connectivityResult = (await _connectivity.checkConnectivity()) as ConnectivityResult;
  }
}
