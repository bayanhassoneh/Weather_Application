import 'package:flutter/material.dart';

String formatHour(DateTime time) {
  final hour = time.hour;
  final period = hour >= 12 ? 'PM' : 'AM';
  final hour12 = hour % 12 == 0 ? 12 : hour % 12;

  return '$hour12 $period';
}

String getDayName(DateTime date) {
  final now = DateTime.now();

  if (date.year == now.year && date.month == now.month && date.day == now.day) {
    return 'Today';
  }

  const days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  return days[date.weekday - 1];
}

ImageProvider getWeatherBackground(String condition) {
  switch (condition.toLowerCase()) {
    case 'clear':
      return const AssetImage('assets/images/sunny.jpg');

    case 'clouds':
      return const AssetImage('assets/images/cloudy.png');

    case 'rain':
      return const AssetImage('assets/images/rainy3.png');

    case 'snow':
      return const AssetImage('assets/images/snowy.png');

    case 'thunderstorm':
      return const AssetImage('assets/images/storm.png');

    default:
      return const AssetImage('assets/images/sunny.jpg');
  }
}

Widget getWeatherIcon(String iconCode, {double size = 35}) {
  switch (iconCode) {
    case '01d':
      return Icon(Icons.wb_sunny, color: Colors.amber, size: size);
    case '01n':
      return Icon(Icons.nights_stay, color: Colors.white, size: size);
    case '02d':
    case '02n':
      return Icon(Icons.cloud_queue, color: Colors.white, size: size);
    case '03d':
    case '03n':
    case '04d':
    case '04n':
      return Icon(Icons.cloud, color: Colors.white70, size: size);
    default:
      return Icon(Icons.wb_sunny, color: Colors.amber, size: size);
  }
}
