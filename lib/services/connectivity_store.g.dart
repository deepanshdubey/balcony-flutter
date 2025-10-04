// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectivity_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ConnectivityStore on _ConnectivityStoreBase, Store {
  late final _$connectivityResultAtom =
      Atom(name: '_ConnectivityStoreBase.connectivityResult', context: context);

  @override
  ConnectivityResult get connectivityResult {
    _$connectivityResultAtom.reportRead();
    return super.connectivityResult;
  }

  @override
  set connectivityResult(ConnectivityResult value) {
    _$connectivityResultAtom.reportWrite(value, super.connectivityResult, () {
      super.connectivityResult = value;
    });
  }

  late final _$isDialogShownAtom =
      Atom(name: '_ConnectivityStoreBase.isDialogShown', context: context);

  @override
  bool get isDialogShown {
    _$isDialogShownAtom.reportRead();
    return super.isDialogShown;
  }

  @override
  set isDialogShown(bool value) {
    _$isDialogShownAtom.reportWrite(value, super.isDialogShown, () {
      super.isDialogShown = value;
    });
  }

  late final _$setConnectivityResultAsyncAction = AsyncAction(
      '_ConnectivityStoreBase.setConnectivityResult',
      context: context);

  @override
  Future<void> setConnectivityResult(ConnectivityResult result) {
    return _$setConnectivityResultAsyncAction
        .run(() => super.setConnectivityResult(result));
  }

  late final _$checkInitialConnectivityAsyncAction = AsyncAction(
      '_ConnectivityStoreBase.checkInitialConnectivity',
      context: context);

  @override
  Future<void> checkInitialConnectivity() {
    return _$checkInitialConnectivityAsyncAction
        .run(() => super.checkInitialConnectivity());
  }

  @override
  String toString() {
    return '''
connectivityResult: ${connectivityResult},
isDialogShown: ${isDialogShown}
    ''';
  }
}
