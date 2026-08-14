import 'package:flutter/material.dart';
import 'package:weather_app/utils/weather_utils.dart';

class HourlyWeatherCard extends StatelessWidget {
  final String time;
  final String icon;
  final int temperature;

  const HourlyWeatherCard({
    required this.time,
    required this.icon,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      margin: const EdgeInsets.only(right: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(time, style: const TextStyle(color: Colors.white, fontSize: 15)),
          const SizedBox(height: 5),
          // Image.network(
          //   'https://openweathermap.org/img/wn/$icon@4x.png',
          //   width: 35,
          //   height: 35,
          //   errorBuilder: (context, error, stackTrace) {
          //     return const Icon(Icons.wb_sunny, color: Colors.amber, size: 35);
          //   },
          // ),
          getWeatherIcon(icon, size: 25),
          // Text(icon, style: const TextStyle(fontSize: 15)),
          const SizedBox(height: 5),
          Text(
            "$temperature°",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
