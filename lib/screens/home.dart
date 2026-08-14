import 'package:flutter/material.dart';
import 'package:weather_app/providers/WeatherProvider.dart';
import 'package:weather_app/widgets/hourly_weather_card.dart';
import 'package:weather_app/widgets/day_forecast_card.dart';
import 'package:weather_app/widgets/featurs_card.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/utils/weather_utils.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<weatherProvider>().getWeatherByLocation();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<weatherProvider>();

    if (provider.weather == null) {
      return Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/sunny.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                color: const Color.fromARGB(
                  255,
                  43,
                  43,
                  57,
                ).withValues(alpha: 0.7),
              ),
            ),
            const Center(child: CircularProgressIndicator(color: Colors.white)),
          ],
        ),
      );
    }
    if (provider.weather == null) {
      return const Scaffold(
        backgroundColor: Color.fromARGB(255, 62, 62, 105),
        body: Center(
          child: Text(
            'Failed to get weather data',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      );
    }
    final weather = provider.weather!;
    final features = [
      {
        'icon': Icons.water_drop,
        'title': 'Humidity',
        'value': '${weather.humidity}%',
      },
      {
        'icon': Icons.air,
        'title': 'Wind',
        'value': '${weather.windSpeed} km/h',
      },
      {
        'icon': Icons.speed,
        'title': 'Pressure',
        'value': '${weather.pressure} hPa',
      },
      {
        'icon': Icons.visibility,
        'title': 'Visibility',
        'value': '${(weather.visibility) / 1000} km',
      },
    ];

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: getWeatherBackground(provider.weather?.condition ?? ''),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: const Color.fromARGB(
                255,
                72,
                72,
                120,
              ).withValues(alpha: 0.4),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _searchController,
                      textInputAction: TextInputAction.search,
                      onFieldSubmitted: (value) async {
                        if (value.trim().isEmpty) return;
                        try {
                          await context
                              .read<weatherProvider>()
                              .gethWeatherByCity(value.trim());
                        } on Exception catch (e) {
                          if (!mounted) return;

                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Search city...",
                        hintStyle: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                        ),

                        prefixIcon: Icon(Icons.search, color: Colors.white70),
                        filled: true,
                        fillColor: Colors.white.withValues(alpha: 0.15),

                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),

                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 196, 218, 229),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 114, 189, 210),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      weather.cityName,
                      style: TextStyle(fontSize: 28, color: Colors.white),
                    ),
                    Text(
                      '${weather.temperature.round()}°',
                      style: TextStyle(fontSize: 35),
                    ),
                    Text(weather.condition, style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),

                    Container(
                      height: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(
                          255,
                          109,
                          136,
                          185,
                        ).withValues(alpha: 0.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: const Color.fromARGB(
                                    255,
                                    196,
                                    218,
                                    229,
                                  ),
                                ),
                                Text(
                                  'HOURLY FORECAST',
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                      255,
                                      196,
                                      218,
                                      229,
                                    ),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: provider.hourlyWeather.length,
                                itemBuilder: (context, index) {
                                  final hourly = provider.hourlyWeather[index];
                                  return HourlyWeatherCard(
                                    time: formatHour(hourly.time),
                                    icon: hourly.icon,
                                    temperature: hourly.temperature.round(),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(
                          255,
                          105,
                          131,
                          179,
                        ).withValues(alpha: 0.5),
                      ),
                      child: Padding(
                        // padding: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month_outlined,
                                  color: const Color.fromARGB(
                                    255,
                                    196,
                                    218,
                                    229,
                                  ),
                                ),
                                Text(
                                  '5 DAYS FORECAST',
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                      255,
                                      196,
                                      218,
                                      229,
                                    ),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: provider.dailyWeather.length,
                                itemBuilder: (context, index) {
                                  final day = provider.dailyWeather[index];
                                  return DayForecastCard(
                                    day: getDayName(day.date),
                                    icon: day.icon,
                                    minTemp: day.minTemp,
                                    maxTemp: day.maxTemp,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.2,
                          ),
                      itemCount: features.length,
                      itemBuilder: (context, index) {
                        final feature = features[index];
                        return FeatursCard(
                          icon: feature["icon"] as IconData,
                          title: feature["title"] as String,
                          content: feature['value'] as String,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (provider.isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withValues(alpha: 0.4),
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
