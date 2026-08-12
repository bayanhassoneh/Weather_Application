class HourlyWeatherModel {
  final DateTime time;
  final double temperature;
  final String icon;

  HourlyWeatherModel({
    required this.time,
    required this.temperature,
    required this.icon,
  });
  factory HourlyWeatherModel.fromJson(Map<String, dynamic> json) {
    return HourlyWeatherModel(
      time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      temperature: json['main']['temp'].toDouble(),
      icon: json['weather'][0]['icon'],
    );
  }
}
