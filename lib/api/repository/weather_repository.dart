import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_court/api/interfaces/network_call_interface.dart';
import 'package:food_court/api/interfaces/weather_interface.dart';
import 'package:food_court/api/keys/api_keys.dart';
import 'package:food_court/api/models/current_weather/weather_forcast/weather_forcast.dart';
import 'package:food_court/api/services/dio_service.dart';
import 'package:food_court/api/utils/network_response.dart';

final repositoryProvider = Provider(
  (ref) => WeatherRepository(),
);

/// A repository class that handles fetching the weather details from the service class [DioService]
///
/// It implements [WeatherInterface] to retrieve the signature needed to function
class WeatherRepository implements WeatherInterface {
  /// The instance of the DioService class singleton
  final NetworkApi _service = DioService();

  /// Retrieves weather data from the service class [_service]
  @override
  Future<NetworkResponse> getWeatherData({
    required double latitude,
    required double longitude,
  }) async {
    const url = ApiKeys.baseUrl + ApiKeys.weatherDetails;
    NetworkResponse errorResponse = NetworkResponse.error();
    try {
      final response = await _service.get(url: url, queryParameters: {
        "lat": latitude,
        "lon": longitude,
        "units": "metric",
        "appid": ApiKeys.apiKey,
      });
      if (response.success && response.data is Map) {
        return NetworkResponse.success(
            data: WeatherForcast.fromMap(response.data),
            code: response.code,
            message: response.message);
      }
      return response;
    } catch (e) {
      return errorResponse
        ..message = "An error occured"
        ..success = false;
    }
  }
}
