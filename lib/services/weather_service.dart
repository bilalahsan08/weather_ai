import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';
import '../utils/constants.dart';

class WeatherService {
  static const String _apiKey = Constants.openWeatherKey;
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<WeatherModel> getWeather(String city) async {
    final url = Uri.parse(
      '$_baseUrl/weather?q=$city&appid=$_apiKey&units=metric',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception('City not found. Please check the city name.');
    } else {
      throw Exception('Failed to load weather. Try again.');
    }
  }

  Future<List<Map<String, dynamic>>> getHourlyForecast(String city) async {
    final url = Uri.parse(
      '$_baseUrl/forecast?q=$city&appid=$_apiKey&units=metric&cnt=8',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data['list']);
    } else {
      throw Exception('Failed to load forecast.');
    }
  }
}
