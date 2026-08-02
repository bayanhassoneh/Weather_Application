import 'package:flutter/material.dart';
import 'package:weather_app/models/weatherModel.dart';
import 'package:weather_app/widgets/hourly_weather_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Weathermodel weather = Weathermodel(
    cityName: 'amman',
    temperature: 25.0,
    condition: 'Sunny',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/sunny.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: Colors.black.withValues(alpha: 0.25)),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(weather.cityName, style: TextStyle(fontSize: 28)),
                    Text(
                      '${weather.temperature}°',
                      style: TextStyle(fontSize: 35),
                    ),
                    Text(weather.condition, style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: const Color.fromARGB(255, 133, 168, 186),
                        ),
                        Text(
                          'HOURLY FORECAST',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 133, 168, 186),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueAccent.withValues(alpha: 0.25),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return HourlyWeatherCard(
                            time: "12 PM",
                            icon: "☀️",
                            temperature: 30,
                          );
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          color: const Color.fromARGB(255, 133, 168, 186),
                        ),
                        Text(
                          '10 DAYS FORECAST',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 133, 168, 186),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
