import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:weather_api/model/weather_model.dart';
import 'package:weather_api/pages/search_weather_page.dart';
import 'package:weather_api/providers/theme_provider.dart';
import 'package:weather_api/services/weather_service.dart';
import 'package:weather_api/widgets/display_weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherService _weatherService =
      WeatherService(apiKey: dotenv.env["WEATHER_API_KEY"] ?? "");

  WeatherModel? _weatherModel;

  //* method to fetch the weather

  void fetchWeather() async {
    try {
      final weather = await _weatherService.getWeatherByLocation();
      setState(() {
        _weatherModel = weather;
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Finder"),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false)
                  .toggleTheme(Theme.of(context).brightness != Brightness.dark);
            },
            icon: Theme.of(context).brightness == Brightness.dark
                ? Icon(Icons.light_mode)
                : Icon(Icons.dark_mode),
          ),
        ],
      ),
      body: _weatherModel != null
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  DisplayWeather(
                    weatherModel: _weatherModel!,
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchWeatherPage(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(54, 63, 81, 181),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Search Weather",
                            style: TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
