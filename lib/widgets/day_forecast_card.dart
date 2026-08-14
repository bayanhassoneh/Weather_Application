import 'package:flutter/material.dart';
import 'package:weather_app/utils/weather_utils.dart';

class DayForecastCard extends StatelessWidget {
  final String day;
  final String icon;
  final double minTemp;
  final double maxTemp;
  const DayForecastCard({
    super.key,
    required this.day,
    required this.icon,
    required this.minTemp,
    required this.maxTemp,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(7),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  day,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              // SizedBox(width: 10),
              getWeatherIcon(icon, size: 25),
              // Image.network(
              //   'https://openweathermap.org/img/wn/$icon@2x.png',
              //   width: 40,
              //   height: 40,
              // ),
              // Text(icon, style: TextStyle(fontS ize: 15)),
              //  SizedBox(width: 10),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${minTemp.round()}° / ${maxTemp.round()}°',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
          const Divider(color: Colors.white, thickness: 0.3),
        ],
      ),
    );
  }
}
