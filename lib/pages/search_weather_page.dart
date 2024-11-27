import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_api/model/weather_model.dart';

import 'package:weather_api/services/weather_service.dart';
import 'package:weather_api/widgets/display_weather.dart';

class SearchWeatherPage extends StatefulWidget {
  const SearchWeatherPage({super.key});

  @override
  State<SearchWeatherPage> createState() => _SearchWeatherPageState();
}

class _SearchWeatherPageState extends State<SearchWeatherPage> {
  final WeatherService _weatherService =
      WeatherService(apiKey: dotenv.env['WEATHER_API_KEY'] ?? '');
  final TextEditingController _controller = TextEditingController();
  WeatherModel? _weatherModel;
  String? _error;

  void _searchWeather() async {
    final city = _controller.text.trim();
    if (city.isEmpty) {
      setState(() {
        _error = "Please enter a city name";
      });
      return;
    }

    try {
      final weather = await _weatherService.getWeather(city);
      setState(() {
        _weatherModel = weather;
        _error = null;
      });
    } catch (e) {
      setState(() {
        _error = "Could not fetch weather data for $city";
        _weatherModel = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Weather'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'City Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100)),
                  suffixIcon: IconButton(
                    icon: Container(
                      decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(100)),
                      width: 100,
                      height: 40,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          Text(
                            "Search",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    onPressed: _searchWeather,
                  ),
                ),
                onSubmitted: (_) => _searchWeather(),
              ),
              const SizedBox(height: 10),
              _error != null
                  ? Text(
                      _error!,
                      style: const TextStyle(color: Colors.red),
                    )
                  : _weatherModel != null
                      ? DisplayWeather(
                          weatherModel: _weatherModel!,
                        )
                      : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
