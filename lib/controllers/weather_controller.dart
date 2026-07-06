import 'package:get/get.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
import '../services/ai_service.dart';

class WeatherController extends GetxController {
  final WeatherService _weatherService = WeatherService();
  final AiService _aiService = AiService();
  
  var weather = Rxn<WeatherModel>();
  var hourlyForecast = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var isAiLoading = false.obs;
  var errorMessage = ''.obs;
  var aiSuggestion = ''.obs;

  Future<void> fetchWeather(String city) async {
    isLoading.value = true;
    errorMessage.value = '';
    aiSuggestion.value = '';
    
    try {
      weather.value = await _weatherService.getWeather(city);
      hourlyForecast.value = await _weatherService.getHourlyForecast(city);
      await _fetchAiSuggestion();
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _fetchAiSuggestion() async {
    if (weather.value == null) return;
    
    isAiLoading.value = true;
    try {
      final w = weather.value!;
      aiSuggestion.value = await _aiService.getWeatherSuggestion(
        city: w.cityName,
        temperature: w.temperature,
        condition: w.condition,
        humidity: w.humidity,
        windSpeed: w.windSpeed,
      );
    } catch (e) {
      aiSuggestion.value = 'Have a great day and stay safe!';
    } finally {
      isAiLoading.value = false;
    }
  }
}
