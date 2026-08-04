import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:weather_app/screens/home.dart';
import 'package:weather_app/widgets/InternetCheckerWrapper.dart';
import 'core/theme/app_theme.dart';
import 'package:weather_app/screens/splash_screen.dart';

void main() {
  runApp(
    // MultiProvider(providers: [],
    //  child:
    MyApp(),
    //  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => MyHomePage(),
      },

      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return Internetcheckerwrapper(child: child!);
      },
    );
  }
}
