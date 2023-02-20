// ignore_for_file: file_names

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_court/api/models/current_weather/weather_forcast/weather_forcast.dart';
import 'package:food_court/api/repository/weather_repository.dart';
import 'package:food_court/core/Alerts/notification_manager.dart';
import 'package:food_court/core/Models/Favourite%20CIty/favourite_city.dart';
import 'package:food_court/core/Models/Locations/locations_data/locations_data.dart';
import 'package:food_court/core/Models/Locations/locations_data/locations_datum.dart';
import 'package:food_court/core/Utilities/Shared%20Preferences/shared_pref.dart';
import 'package:geolocator/geolocator.dart';

final homeModelProvider = ChangeNotifierProvider((ref) {
  return HomeViewModel(ref.read(repositoryProvider));
});

class HomeViewModel with ChangeNotifier {
  HomeViewModel(this._weatherRepository);

  /// The connection to the weather repository
  final WeatherRepository _weatherRepository;

  /// The private JSON response of the list of Nigerian Cities
  String? _localLocationsDataResponse;

  /// The private model class encapsulating the local JSON response
  LocationsData? _locationsData;

  /// Loads the json data from the asset file
  Future<LocationsData> getLocationsFromLocalJson() async {
    _localLocationsDataResponse =
        await rootBundle.loadString("assets/json/ng.json");
    _locationsData = LocationsData.fromJson(_localLocationsDataResponse!);
    return _locationsData!;
  }

  LocationsDatum? _chosenCity;

  /// The Chosen city that has its weather details displayed
  LocationsDatum? get chosenCity => _chosenCity;
  set chosenCity(LocationsDatum? value) {
    _chosenCity = value;
    notifyListeners();
  }

  /// List of 15 Cities the user can select from
  List<LocationsDatum>? listOfFifteenCities = [];

  /// List of Watch List / Favourite Cities the user can select from
  List<FavouriteCity>? listOfFavouriteCities = [];

  bool? _locationServiceEnabled = false;

  /// Whether locations Services are active
  bool? get locationServiceEnabled => _locationServiceEnabled;
  set locationServiceEnabled(bool? value) {
    _locationServiceEnabled = value;
    notifyListeners();
  }

  bool _isLoading = true;

  /// Whether verification and initialization is complete
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  WeatherForcast? _chosenCityWeatherForcast;

  /// The data retrieved from the API.
  WeatherForcast? get chosenCityWeatherForcast => _chosenCityWeatherForcast;
  set chosenCityWeatherForcast(WeatherForcast? value) {
    _chosenCityWeatherForcast = value;
    notifyListeners();
  }

  Future<void> modifyFavouriteLists(
      {required String nameOfOldCity, required String nameOfNewCity}) async {
    var tempChosenCity = _locationsData!.locationsData!
        .firstWhere((element) => element.city == nameOfNewCity);
    var tempWeatherForcast =
        await fetchData(tempChosenCity.lat!, tempChosenCity.lng!);
    var newFavourite = FavouriteCity(
        cityInfo: tempChosenCity, weatherForcast: tempWeatherForcast);
    var indexOfOldFavourite = listOfFavouriteCities!
        .indexWhere((element) => element.cityInfo!.city == nameOfOldCity);
    await AppSharedPreferences().preferencesInstance!.setString(
        AppSharedPreferences.watchListCities[indexOfOldFavourite],
        nameOfNewCity);
    listOfFavouriteCities![indexOfOldFavourite] = newFavourite;
    notifyListeners();
  }

  /// Requests location permission from the user
  ///
  /// Informs the user if location services are active or not.
  Future<bool> _handleLocationPermission() async {
    LocationPermission permission;

    locationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!locationServiceEnabled!) {
      NotificationManager.notifyError(
          "Location services are disabled. Please enable the services and try again");

      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        NotificationManager.notifyError("Location permissions are denied");
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      NotificationManager.notifyError(
          "Location permissions are permanently denied, we cannot request permissions.");
      return false;
    }
    return true;
  }

  /// Retrieves Weather information from the [_weatherRepository.getWeatherData]
  Future<WeatherForcast?> fetchData(double latitude, double longitude) async {
    var result = await _weatherRepository.getWeatherData(
        latitude: latitude, longitude: longitude);
    if (!result.success) {
      NotificationManager.notifyError(result.message);
      return null;
    }
    return result.data as WeatherForcast;
  }

  Future<void> getUsersCurrentPosition() async {
    isLoading = true;
    var userPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _chosenCityWeatherForcast =
        await fetchData(userPosition.latitude, userPosition.longitude);
    _isLoading = false;
    // _chosenCity = _locationsData.locationsData.firstWhere((element) => element.,)
    notifyListeners();
  }

  Future<void> setChosenCity(String cityName) async {
    _chosenCity = _locationsData!.locationsData!
        .firstWhere((element) => element.city == cityName);
    _chosenCityWeatherForcast =
        await fetchData(_chosenCity!.lat!, _chosenCity!.lng!);
    notifyListeners();
  }

  /// Performs initial setup and proceeds to make the API calls
  ///
  /// Checks if [_handleLocationPermission] is successful,
  /// proceeds to get weather details from default city by calling [setChosenCity]
  /// Proceeds to intialize list of 15 cities [listOfFifteenCities], from that list,
  /// it generates list of favourite cities [listOfFavouriteCities]
  Future<void> initialize() async {
    //todo: Add persistence to favourite cities list
    _isLoading = true;
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await getLocationsFromLocalJson().then((value) async {
      await setChosenCity("Lagos");
      listOfFifteenCities = _locationsData!.locationsData!
          .where((element) => element.city != "Lagos")
          .take(14)
          .toList();
      listOfFifteenCities!.sort(
        (a, b) => a.city!.compareTo(b.city!),
      );
      listOfFifteenCities!.insert(0, _chosenCity!);
      List<LocationsDatum> tempFavCitiesList = [];
      if (AppSharedPreferences()
          .preferencesInstance!
          .containsKey(AppSharedPreferences.watchListCountries)) {
        String? favCityOne = AppSharedPreferences()
            .preferencesInstance!
            .getString(AppSharedPreferences.watchListOne);
        String? favCityTwo = AppSharedPreferences()
            .preferencesInstance!
            .getString(AppSharedPreferences.watchListTwo);
        String? favCityThree = AppSharedPreferences()
            .preferencesInstance!
            .getString(AppSharedPreferences.watchListThree);

        tempFavCitiesList = listOfFifteenCities!
            .where((element) =>
                element.city == favCityOne ||
                element.city == favCityTwo ||
                element.city == favCityThree)
            .toList();
      } else {
        tempFavCitiesList = listOfFifteenCities!
            .where((element) => element.city != "Lagos")
            .take(3)
            .toList();

      }
      WeatherForcast? favCityOneWeatherForcast,
          favCityTwoWeatherForcast,
          favCityThreeWeatherForcast;

      List<WeatherForcast?> tempFavCitiesListFavCitiesForcast = [
        favCityOneWeatherForcast,
        favCityTwoWeatherForcast,
        favCityThreeWeatherForcast
      ];

      await Future.wait([
        fetchData(tempFavCitiesList[0].lat!, tempFavCitiesList[0].lat!)
            .then((value) => tempFavCitiesListFavCitiesForcast[0] = value),
        fetchData(tempFavCitiesList[1].lat!, tempFavCitiesList[1].lat!)
            .then((value) => tempFavCitiesListFavCitiesForcast[1] = value),
        fetchData(tempFavCitiesList[2].lat!, tempFavCitiesList[2].lat!)
            .then((value) => tempFavCitiesListFavCitiesForcast[2] = value),
      ]);

      if (!AppSharedPreferences()
          .preferencesInstance!
          .containsKey(AppSharedPreferences.watchListCountries)) {
        await AppSharedPreferences()
            .preferencesInstance!
            .setBool(AppSharedPreferences.watchListCountries, true);

        for (var i = 0; i < tempFavCitiesList.length; i++) {
          await AppSharedPreferences().preferencesInstance!.setString(
              AppSharedPreferences.watchListCities[i],
              tempFavCitiesList[i].city!);

          listOfFavouriteCities!.add(
            FavouriteCity(
                cityInfo: tempFavCitiesList[i],
                weatherForcast: tempFavCitiesListFavCitiesForcast[i]),
          );

        }
        _isLoading = false;
        notifyListeners();
        return;
      }

      for (var i = 0; i < tempFavCitiesList.length; i++) {
        listOfFavouriteCities!.add(
          FavouriteCity(
              cityInfo: tempFavCitiesList[i],
              weatherForcast: tempFavCitiesListFavCitiesForcast[i]),
        );
      }
      _isLoading = false;
      notifyListeners();
    });
  }
}
