import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_api/model/weather_model.dart';
import 'package:weather_api/utils/util_functions.dart';

class DisplayWeather extends StatelessWidget {
  final WeatherModel weatherModel;
  const DisplayWeather({
    super.key,
    required this.weatherModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Lottie.asset(
                Utils().getWeatherAnimation(
                  condition: weatherModel.condition,
                ),
                width: 400,
                height: 400,
              ),
            ),
            Text(
              weatherModel.cityName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              "${weatherModel.temperature.toStringAsFixed(1)}°C",
              style: const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildWeatherDetail("Pressure", "${weatherModel.pressure} hPa"),
                _buildWeatherDetail("Humidity", "${weatherModel.humidity}%"),
                _buildWeatherDetail(
                    "Wind Speed", "${weatherModel.windSpeed} m/s"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetail(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
