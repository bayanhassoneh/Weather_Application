import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/models/DailyWeatherModel.dart';
import 'package:weather_app/models/HourlyWeatherModel.dart';
import 'package:weather_app/services/localStorageService.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/models/CurrentWeatherModel.dart';
import 'package:weather_app/services/location_service.dart';

class weatherProvider extends ChangeNotifier {
  final weatherServie _servie = weatherServie();
  final locationService _location = locationService();
  final Localstorageservice localStorage = Localstorageservice();
  CurrentWeathermodel? weather;
  bool isLoading = false;
  List<HourlyWeatherModel> hourlyWeather = [];
  List<DailyWeatherModel> dailyWeather = [];
  String? errorMessage;

  Future<void> gethWeatherByCity(String city) async {
    try {
      isLoading = true;
      notifyListeners();

      final data = await _servie.getWeatherDataByCity(city);

      final lat = (data['coord']['lat'] as num).toDouble();
      final lon = (data['coord']['lon'] as num).toDouble();
      final forecastData = await _servie.getForcastByLOcation(lat, lon);
      if (forecastData.isEmpty) {
        throw Exception('Forecast data is empty');
      }
      final currentWeather = CurrentWeathermodel.fromJson(data); //******
      final hourlyData = forecastData
          .map((item) => HourlyWeatherModel.fromJson(item))
          .toList(); //*********
      // //<<test
      // for (final hourly in hourlyData) {
      //   print(hourly.time);
      // }
      // //>>
      final dailyData = _servie.getDailyForecast(forecastData); //*********** */
      if (hourlyData.isEmpty || dailyData.isEmpty) {
        throw Exception('Forecast data is incomplete');
      }
      weather = currentWeather;
      hourlyWeather = hourlyData;
      dailyWeather = dailyData;
      try {
        final weatherData = {
          'current': data,
          'forecast': forecastData,
          'lastUpdate': DateTime.now().toIso8601String(),
        };
        await localStorage.saveWeatherData(weatherData);
      } on Exception catch (e) {
        print(e);
      }
    } catch (e) {
      final hasCache = await getLocalData();
      if (!hasCache) {
        errorMessage = 'Unable to load weather data.';
      }
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
      final currentData = await _servie.getWeatherByLocation(
        position.latitude,
        position.longitude,
      ); //****************** */
      final currentWeather = CurrentWeathermodel.fromJson(currentData);
      final forecastData = await _servie.getForcastByLOcation(
        position.latitude,
        position.longitude,
      );
      final hourlyData = forecastData
          .map((item) => HourlyWeatherModel.fromJson(item))
          .toList(); //************** */
      final dailyData = _servie.getDailyForecast(
        forecastData,
      ); //************* */
      weather = currentWeather;
      hourlyWeather = hourlyData;
      dailyWeather = dailyData;

      try {
        final weatherData = {
          'current': currentData,
          'forecast': forecastData,
          'lastUpdate': DateTime.now().toIso8601String(),
        };
        await localStorage.saveWeatherData(weatherData);
      } on Exception catch (e) {
        print(e);
      }
    } catch (e) {
      final hasCache = await getLocalData();
      if (!hasCache) {
        errorMessage = 'unable to load weather data';
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> getLocalData() async {
    try {
      final cachedData = await localStorage.readWeatherData();
      if (cachedData != null) {
        weather = CurrentWeathermodel.fromJson(cachedData['current']);
        final forecast = cachedData['forecast'];
        hourlyWeather = forecast
            .map((item) => HourlyWeatherModel.fromJson(item))
            .toList();
        dailyWeather = _servie.getDailyForecast(forecast);
      } else {
        print('an error acured.');
      }
      return true;
    } catch (e) {
      print('Cache retrieval failed: $e');
      return false;
    }
  }
}
