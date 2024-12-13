import 'package:mobx/mobx.dart';
part 'walkthrough_store.g.dart';

class WalkthroughStore = _WalkthroughStore with _$WalkthroughStore;

abstract class _WalkthroughStore with Store {
  @observable
  int currentPage = 0;

  @action
  void setPage(int index) {
    currentPage = index;
  }
}
