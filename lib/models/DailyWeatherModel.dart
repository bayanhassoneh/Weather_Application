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
 //ليش ما في fromJSON factory ؟
 //لان الدايلي مش قيمه وحده قط اخزنها هي ايام و تواريخ و توقعات متعدده ف انا هندلتها 

 //الاورلي عباره عن توقعات يوم واحد فقط يعني لكل ساعه توقع و ايكون وهيك فبعمل فاكتوري يخزن تلقائي