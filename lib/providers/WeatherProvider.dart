import 'package:flutter/material.dart';
import 'package:weather_app/models/DailyWeatherModel.dart';
import 'package:weather_app/models/HourlyWeatherModel.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/models/CurrentWeatherModel.dart';
import 'package:weather_app/services/location_service.dart';

class weatherProvider extends ChangeNotifier {
  final weatherServie _servie = weatherServie();
  final locationService _location = locationService();
  CurrentWeathermodel? weather;
  bool isLoading = false;
  List<HourlyWeatherModel> hourlyWeather = [];
  List<DailyWeatherModel> dailyWeather = [];

  Future<void> gethWeatherByCity(String city) async {
    try {
      isLoading = true;
      notifyListeners();

      final data = await _servie.getWeatherDataByCity(city);
      weather = CurrentWeathermodel.fromJson(data);
      final lat = (data['coord']['lat'] as num).toDouble();
      final lon = (data['coord']['lon'] as num).toDouble();
      final forecastData = await _servie.getForcastByLOcation(lat, lon);
      hourlyWeather = forecastData
          .map((item) => HourlyWeatherModel.fromJson(item))
          .toList();
      dailyWeather = _servie.getDailyForecast(forecastData);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getWeatherByLocation() async {
    //current&hourlly
    try {
      isLoading = true;
      notifyListeners();
      final position = await _location.getCurrentLocation();
      weather = await _servie.getWeatherByLocation(
        position.latitude,
        position.longitude,
      );
      final forecastData = await _servie.getForcastByLOcation(
        position.latitude,
        position.longitude,
      );
      hourlyWeather = forecastData
          .map((item) => HourlyWeatherModel.fromJson(item))
          .toList();
      dailyWeather = _servie.getDailyForecast(forecastData);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
