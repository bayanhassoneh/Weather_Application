class Weathermodel {
  final String cityName;
  final double temperature;
  final String condition;

  final String icon;
  final int humidity;
  final int pressure;
  final double windSpeed;
  final double visibility;
  Weathermodel({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.icon,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
    required this.visibility,
  });

  factory Weathermodel.fromJson(Map<String, dynamic> json) {
    return Weathermodel(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      condition: json['waether'][0]['main'],
      icon: json['weather'][0]['icon'],
      humidity: json['main']['humidity'],
      pressure: json['main']['pressure'],
      windSpeed: json['wind']['speed'].toDouble(),
      visibility: json['wind']['visibility'],
    );
  }
}
