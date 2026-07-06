import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controllers/weather_controller.dart';
import '../utils/animation_mapper.dart';
import '../widgets/ai_suggestion_card.dart';
import '../widgets/hourly_forecast.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final WeatherController _controller = Get.put(WeatherController());
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final weather = _controller.weather.value;
        final condition = weather?.condition ?? 'clear';
        final isNight = weather?.isNight ?? false;
        final gradientColors = AnimationMapper.getGradient(condition, isNight);
        final animationPath = AnimationMapper.getAnimation(condition, isNight);

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradientColors,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildSearchBar(),
                  if (_controller.isLoading.value)
                    const Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  else if (_controller.errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Text(
                        _controller.errorMessage.value,
                        style: const TextStyle(color: Colors.redAccent, fontSize: 16),
                      ),
                    )
                  else if (weather != null) ...[
                    const SizedBox(height: 20),
                    Text(
                      weather.cityName,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${weather.temperature.toStringAsFixed(1)}°C',
                      style: const TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      weather.description.capitalizeFirst ?? weather.description,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Lottie.asset(
                      animationPath,
                      width: 200,
                      height: 200,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.cloud, size: 100, color: Colors.white54),
                    ),
                    const SizedBox(height: 20),
                    AiSuggestionCard(
                      suggestion: _controller.aiSuggestion.value,
                      isLoading: _controller.isAiLoading.value,
                    ),
                    const SizedBox(height: 30),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Hourly Forecast',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    HourlyForecast(forecast: _controller.hourlyForecast),
                    const SizedBox(height: 40),
                  ] else
                    const Padding(
                      padding: EdgeInsets.only(top: 100.0),
                      child: Text(
                        'Search for a city to get weather details.',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search city...',
          hintStyle: const TextStyle(color: Colors.white54),
          prefixIcon: const Icon(Icons.search, color: Colors.white70),
          suffixIcon: IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.white),
            onPressed: () {
              if (_searchController.text.isNotEmpty) {
                _controller.fetchWeather(_searchController.text.trim());
              }
            },
          ),
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            _controller.fetchWeather(value.trim());
          }
        },
      ),
    );
  }
}
