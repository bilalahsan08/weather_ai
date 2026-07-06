class WeatherModel {
  final String cityName;
  final String country;
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final String condition;
  final String description;
  final double humidity;
  final double windSpeed;
  final int visibility;
  final String icon;
  final int sunrise;
  final int sunset;
  final int dt;

  WeatherModel({
    required this.cityName,
    required this.country,
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.condition,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.visibility,
    required this.icon,
    required this.sunrise,
    required this.sunset,
    required this.dt,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      country: json['sys']['country'],
      temperature: json['main']['temp'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      tempMin: json['main']['temp_min'].toDouble(),
      tempMax: json['main']['temp_max'].toDouble(),
      condition: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      humidity: json['main']['humidity'].toDouble(),
      windSpeed: json['wind']['speed'].toDouble(),
      visibility: json['visibility'],
      icon: json['weather'][0]['icon'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      dt: json['dt'],
    );
  }

  bool get isNight {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return now < sunrise || now > sunset;
  }
}
