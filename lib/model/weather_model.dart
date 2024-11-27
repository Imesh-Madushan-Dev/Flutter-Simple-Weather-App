class WeatherModel {
  final String cityName;
  final double temperature;
  final String condition;
  final String description;
  final double pressure;
  final double humidity;
  final double windSpeed;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.description,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
  });

  //* Factory method to create a - WeatherModel object from a JSON object

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),     //? to get data from an object
      condition: json['weather'][0]['main'],         //? to get data from an array
      description: json['weather'][0]['description'],
      pressure: json['main']['pressure'].toDouble(),
      humidity: json['main']['humidity'].toDouble(),
      windSpeed: json['wind']['speed'].toDouble(),
    );
  }


}
