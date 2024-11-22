import 'package:balcony/core/locator/locator.dart';
import 'package:country_state_city/country_state_city.dart';
import 'package:mobx/mobx.dart';

part 'address_store.g.dart';

class AddressStore = _AddressStoreBase with _$AddressStore;

abstract class _AddressStoreBase with Store {
  _AddressStoreBase() {
    // Fetch countries when the store is initialized
    fetchCountries();
  }

  @observable
  List<Country>? countries; // List of countries

  @observable
  List<State>? states; // List of states for a selected country

  @observable
  List<City>? cities; // List of cities for a selected state

  @observable
  bool isLoading = false; // Loading indicator for async operations

  @observable
  String? selectedCountryCode; // The code of the selected country

  @observable
  String? selectedStateCode; // The code of the selected state

  @observable
  String? errorMessage; // Error message for UI display

  @action
  Future<void> fetchCountries() async {
    try {
      isLoading = true;
      errorMessage = null;
      countries = await getAllCountries(); // Fetch all countries
    } catch (e) {
      errorMessage = "Failed to load countries: ${e.toString()}";
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> fetchStates(String countryCode) async {
    try {
      isLoading = true;
      errorMessage = null;
      states = await getStatesOfCountry(countryCode);
      selectedCountryCode = countryCode;
      cities = null;
    } catch (e) {
      errorMessage = "Failed to load states: ${e.toString()}";
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> fetchCities(String stateCode) async {
    try {
      isLoading = true;
      errorMessage = null;
      if (selectedCountryCode == null) {
        throw Exception("Country must be selected before fetching cities.");
      }
      cities = await getStateCities(selectedCountryCode!, stateCode);
      selectedStateCode = stateCode;
    } catch (e) {
      errorMessage = "Failed to load cities: ${e.toString()}";
    } finally {
      isLoading = false;
    }
  }
}

final addressStore = locator<AddressStore>();
