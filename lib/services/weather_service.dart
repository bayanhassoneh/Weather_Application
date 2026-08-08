import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/config/api_config.dart';
import 'package:weather_app/models/CurrentWeatherModel.dart';

class weatherServie {
  final String baseURL = 'https://api.openweathermap.org/data/2.5/weather';

  Future getWeatherByCity(String city) async {
    final url = Uri.parse(
      '$baseURL?q=$city&&appid=${ApiConfig.weatherApiKey}&units=metric',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Weathermodel.fromJson(data);
    } else {
      throw Exception('Failed to load weather');
    }
  }

  getWeatherByLocation(double lat, double lon) {}
}
