// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'walkthrough_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WalkthroughStore on _WalkthroughStore, Store {
  late final _$currentPageAtom =
      Atom(name: '_WalkthroughStore.currentPage', context: context);

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$_WalkthroughStoreActionController =
      ActionController(name: '_WalkthroughStore', context: context);

  @override
  void setPage(int index) {
    final _$actionInfo = _$_WalkthroughStoreActionController.startAction(
        name: '_WalkthroughStore.setPage');
    try {
      return super.setPage(index);
    } finally {
      _$_WalkthroughStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPage: ${currentPage}
    ''';
  }
}
