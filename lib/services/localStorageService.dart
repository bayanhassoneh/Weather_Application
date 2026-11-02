import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Localstorageservice {
  final SharedPreferencesAsync _sharedPreferencesAsync =
      SharedPreferencesAsync();
  Future<void> saveWeatherData(Map<String, dynamic> weatherData) async {
    final jsondata = jsonEncode(weatherData);
    await _sharedPreferencesAsync.setString('cache', jsondata);
  }

  Future<Map<String, dynamic>?> readWeatherData() async {
    final jsondata = await _sharedPreferencesAsync.getString('cache');
    if (jsondata == null) {
      return null;
    }
    final weatherData = jsonDecode(jsondata);
    return weatherData;
  }
}
