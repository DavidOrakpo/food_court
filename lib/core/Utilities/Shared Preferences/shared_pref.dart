
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static const watchListCountries = "WATCH_LIST_COUNTRIES";
  static const watchListOne = "WATCH_lIST_ONE";
  static const watchListTwo = "WATCH_lIST_TWO";
  static const watchListThree = "WATCH_lIST_THREE";
  static const List<String> watchListCities = [
    watchListOne,
    watchListTwo,
    watchListThree
  ];
  AppSharedPreferences._internal();

  static final AppSharedPreferences instance = AppSharedPreferences._internal();
  factory AppSharedPreferences() {
    return instance;
  }

  Future<void> init() async {
    preferencesInstance = await SharedPreferences.getInstance();
  }

  SharedPreferences? preferencesInstance;
}
