// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddressStore on _AddressStoreBase, Store {
  late final _$countriesAtom =
      Atom(name: '_AddressStoreBase.countries', context: context);

  @override
  List<Country>? get countries {
    _$countriesAtom.reportRead();
    return super.countries;
  }

  @override
  set countries(List<Country>? value) {
    _$countriesAtom.reportWrite(value, super.countries, () {
      super.countries = value;
    });
  }

  late final _$statesAtom =
      Atom(name: '_AddressStoreBase.states', context: context);

  @override
  List<State>? get states {
    _$statesAtom.reportRead();
    return super.states;
  }

  @override
  set states(List<State>? value) {
    _$statesAtom.reportWrite(value, super.states, () {
      super.states = value;
    });
  }

  late final _$citiesAtom =
      Atom(name: '_AddressStoreBase.cities', context: context);

  @override
  List<City>? get cities {
    _$citiesAtom.reportRead();
    return super.cities;
  }

  @override
  set cities(List<City>? value) {
    _$citiesAtom.reportWrite(value, super.cities, () {
      super.cities = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_AddressStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$selectedCountryCodeAtom =
      Atom(name: '_AddressStoreBase.selectedCountryCode', context: context);

  @override
  String? get selectedCountryCode {
    _$selectedCountryCodeAtom.reportRead();
    return super.selectedCountryCode;
  }

  @override
  set selectedCountryCode(String? value) {
    _$selectedCountryCodeAtom.reportWrite(value, super.selectedCountryCode, () {
      super.selectedCountryCode = value;
    });
  }

  late final _$selectedStateCodeAtom =
      Atom(name: '_AddressStoreBase.selectedStateCode', context: context);

  @override
  String? get selectedStateCode {
    _$selectedStateCodeAtom.reportRead();
    return super.selectedStateCode;
  }

  @override
  set selectedStateCode(String? value) {
    _$selectedStateCodeAtom.reportWrite(value, super.selectedStateCode, () {
      super.selectedStateCode = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_AddressStoreBase.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$fetchCountriesAsyncAction =
      AsyncAction('_AddressStoreBase.fetchCountries', context: context);

  @override
  Future<void> fetchCountries() {
    return _$fetchCountriesAsyncAction.run(() => super.fetchCountries());
  }

  late final _$fetchStatesAsyncAction =
      AsyncAction('_AddressStoreBase.fetchStates', context: context);

  @override
  Future<void> fetchStates(String countryCode) {
    return _$fetchStatesAsyncAction.run(() => super.fetchStates(countryCode));
  }

  late final _$fetchCitiesAsyncAction =
      AsyncAction('_AddressStoreBase.fetchCities', context: context);

  @override
  Future<void> fetchCities(String stateCode) {
    return _$fetchCitiesAsyncAction.run(() => super.fetchCities(stateCode));
  }

  @override
  String toString() {
    return '''
countries: ${countries},
states: ${states},
cities: ${cities},
isLoading: ${isLoading},
selectedCountryCode: ${selectedCountryCode},
selectedStateCode: ${selectedStateCode},
errorMessage: ${errorMessage}
    ''';
  }
}
