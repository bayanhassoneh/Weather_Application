class CurrentWeathermodel {
  final String cityName;
  final double temperature;
  final String condition;
  final String icon;

  final int humidity;
  final int pressure;
  final double windSpeed;
  final double visibility;
  CurrentWeathermodel({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.icon,
    required this.humidity, //1
    required this.pressure, //2
    required this.windSpeed, //3
    required this.visibility, //4
  });

  factory CurrentWeathermodel.fromJson(Map<String, dynamic> json) {
    return CurrentWeathermodel(
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
