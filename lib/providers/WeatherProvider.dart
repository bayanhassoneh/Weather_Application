import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/models/CurrentWeatherModel.dart';

class weatherProvider extends ChangeNotifier {
  final weatherServie _servie = weatherServie();
  Weathermodel? weather;

  Future<void> fetchWeatherByCity(String city) async {
    weather = await _servie.getWeatherByCity(city);
    notifyListeners();
  }
}
