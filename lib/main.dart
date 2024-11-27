import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:weather_api/pages/home_page.dart';
import 'package:weather_api/providers/theme_provider.dart';

void main() async {
  //!  ACCESS THE API KEY FROM .ENV FILE
  await dotenv.load(fileName: ".env");

  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: Provider.of<ThemeProvider>(context).getThemeData,
      home: const HomePage(),
    );
  }
}

/*
https://api.openweathermap.org/data/2.5/weather?lat=57&lon=-2.15&appid=d0b561ca6c1db5ac821f1dda1c1e6484&units=metric

https://api.openweathermap.org/data/2.5/weather?q=London&appid=d0b561ca6c1db5ac821f1dda1c1e6484&units=metric
*/ 