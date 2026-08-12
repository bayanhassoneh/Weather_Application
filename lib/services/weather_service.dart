import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/config/api_config.dart';
import 'package:weather_app/models/CurrentWeatherModel.dart';
import 'package:weather_app/models/HourlyWeatherModel.dart';
import 'package:weather_app/widgets/hourly_weather_card.dart';
import 'package:weather_app/models/DailyWeatherModel.dart';

class weatherServie {
  final String baseURL = 'https://api.openweathermap.org/data/2.5/weather';
  final forcastURL = 'https://api.openweathermap.org/data/2.5/forecast';

  Future<Map<String, dynamic>> getWeatherDataByCity(String city) async {
    final url = Uri.parse(
      '$baseURL?q=$city&&appid=${ApiConfig.weatherApiKey}&units=metric',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data;
      // CurrentWeathermodel.fromJson(data);
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future<CurrentWeathermodel> getWeatherByLocation(
    double lat,
    double lon,
  ) async {
    final url = Uri.parse(
      '$baseURL?lat=$lat&lon=$lon&appid=${ApiConfig.weatherApiKey}&units=metric',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return CurrentWeathermodel.fromJson(data);
    }
    if (response.statusCode == 400) {
      throw Exception('city not found');
    }
    if (response.statusCode == 401) {
      throw Exception('invalid API key');
    }
    if (response.statusCode == 500) {
      throw Exception('server error. try agaim later');
      ;
    }
    throw Exception('failed to load weather');
  }

  Future<List<dynamic>> getForcastByLOcation(double lat, double lon) async {
    final url = Uri.parse(
      '$baseURL?lat=$lat&lon=$lon&appid=${ApiConfig.weatherApiKey}&units=metric',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['list'];
    }

    throw Exception('Failed to load forecast');
  }

  List<DailyWeatherModel> getDailyForecast(List<dynamic> forcastData) {
    final Map<String, List<dynamic>> groupedDays = {};
    for (final item in forcastData) {
      final data = item['dt_txt'].toString().split(' ')[0];
      groupedDays.putIfAbsent(data, () => []);
      groupedDays[data]!.add(item);
    }
    return groupedDays.entries.map((entry) {
      final forcast = entry.value;
      final tempretures = forcast
          .map<double>((item) => (item['main']['temp'] as num).toDouble())
          .toList();

      final minTemp = tempretures.reduce((a, b) => a > b ? b : a);
      final maxTemp = tempretures.reduce((a, b) => a > b ? a : b);
      final icon = forcast.first['weather'][0]['icon'];
      return DailyWeatherModel(
        date: DateTime.parse(entry.key),
        minTemp: minTemp,
        maxTemp: maxTemp,
        icon: icon,
      );
    }).toList();
  }
}
