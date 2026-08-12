class DailyWeatherModel {
  final DateTime date;
  final double minTemp;
  final double maxTemp;
  final String icon;

  DailyWeatherModel({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.icon,
  });
}
