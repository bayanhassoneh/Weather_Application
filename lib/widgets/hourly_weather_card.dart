import 'package:flutter/material.dart';

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
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(time, style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 5),
          Text(icon, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 5),
          Text(
            "$temperature°",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
