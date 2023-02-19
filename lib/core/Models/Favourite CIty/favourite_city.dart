import 'package:food_court/api/models/current_weather/weather_forcast/weather_forcast.dart';
import 'package:food_court/core/Models/Locations/locations_data/locations_datum.dart';

class FavouriteCity {
  WeatherForcast? weatherForcast;
  LocationsDatum? cityInfo;

  FavouriteCity({this.weatherForcast, this.cityInfo});
}
