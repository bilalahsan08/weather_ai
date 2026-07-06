import 'package:google_generative_ai/google_generative_ai.dart';
import '../utils/constants.dart';

class AiService {
  static const String _apiKey = Constants.geminiKey;
  
  final GenerativeModel _model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: _apiKey,
  );

  Future<String> getWeatherSuggestion({
    required String city,
    required double temperature,
    required String condition,
    required double humidity,
    required double windSpeed,
  }) async {
    final prompt = '''
You are a helpful weather assistant. Based on the following
weather data for $city, give a friendly, practical 2-3 sentence
suggestion for the day. Keep it concise and actionable.
Temperature: ${temperature.toStringAsFixed(1)}°C
Condition: $condition
Humidity: ${humidity.toInt()}%
Wind Speed: $windSpeed m/s
Give practical advice about clothing, activities, or health.
''';

    try {
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      return response.text ?? 'Have a great day and stay safe!';
    } catch (e) {
      return 'Stay prepared for the weather and have a wonderful day!';
    }
  }
}
