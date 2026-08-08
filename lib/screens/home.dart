import 'package:flutter/material.dart';
import 'package:weather_app/models/CurrentWeatherModel.dart';
import 'package:weather_app/providers/WeatherProvider.dart';
import 'package:weather_app/widgets/hourly_weather_card.dart';
import 'package:weather_app/widgets/day_forecast_card.dart';
import 'package:weather_app/widgets/featurs_card.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _searchController = TextEditingController();
  final dailyForecast = [
    {"day": "today", "icon": "01d", "minTemp": "18°", "maxTemp": "27°"},
    {"day": "Mon", "icon": "01d", "minTemp": "18°", "maxTemp": "27°"},
    {"day": "Tue", "icon": "10d", "minTemp": "17°", "maxTemp": "25°"},
    {"day": "Wed", "icon": "03d", "minTemp": "20°", "maxTemp": "29°"},
    {"day": "thrs", "icon": "01d", "minTemp": "18°", "maxTemp": "27°"},
    {"day": "fri", "icon": "01d", "minTemp": "18°", "maxTemp": "27°"},
    {"day": "sat", "icon": "10d", "minTemp": "17°", "maxTemp": "25°"},
    {"day": "sun", "icon": "03d", "minTemp": "20°", "maxTemp": "29°"},
    {"day": "mon", "icon": "01d", "minTemp": "18°", "maxTemp": "27°"},
    {"day": "tue", "icon": "03d", "minTemp": "20°", "maxTemp": "29°"},
  ];
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<weatherProvider>().fetchWeatherByCity('Amman');
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<weatherProvider>();
    final features = [
      {
        'icon': Icons.water_drop,
        'title': 'Humidity',
        'value': '${provider.weather?.humidity}%',
      },
      {
        'icon': Icons.air,
        'title': 'Wind',
        'value': '${provider.weather?.windSpeed} km/h',
      },
      {
        'icon': Icons.speed,
        'title': 'Pressure',
        'value': '${provider.weather?.pressure} hPa',
      },
      {
        'icon': Icons.visibility,
        'title': 'Visibility',
        'value': '${(provider.weather?.visibility ?? 0) / 1000} km',
      },
    ];

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/sunny.png'),
                // 'assets/images/sunny.png'
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: const Color.fromARGB(
                255,
                52,
                52,
                84,
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
                      onFieldSubmitted: (value) {
                        print(value);
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
                    Text(
                      provider.weather?.cityName ?? '',
                      style: TextStyle(fontSize: 28, color: Colors.white),
                    ),
                    Text(
                      '${provider.weather?.temperature.round()}°',
                      style: TextStyle(fontSize: 35),
                    ),
                    Text(
                      provider.weather?.condition ?? '',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),

                    Container(
                      height: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(
                          255,
                          55,
                          114,
                          216,
                        ).withValues(alpha: 0.4),
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
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return HourlyWeatherCard(
                                    time: "12 PM",
                                    icon: "01d",
                                    temperature: 30,
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
                      height: 600,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(
                          255,
                          55,
                          114,
                          216,
                        ).withValues(alpha: 0.4),
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
                                  '10 DAYS FORECAST',
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
                                itemCount: dailyForecast.length,
                                itemBuilder: (context, index) {
                                  final day = dailyForecast[index];
                                  return DayForecastCard(
                                    day: day['day'] as String,
                                    icon: day['icon'] as String,
                                    minTemp: day['minTemp'] as String,
                                    maxTemp: day['maxTemp'] as String,
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
        ],
      ),
    );
  }
}
