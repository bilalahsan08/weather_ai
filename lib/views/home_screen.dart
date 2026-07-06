import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../controllers/weather_controller.dart';
import '../utils/animation_mapper.dart';
import '../widgets/ai_suggestion_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final WeatherController controller = Get.put(WeatherController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final weather = controller.weather.value;
      final isNight = weather?.isNight ?? false;
      final condition = weather?.condition ?? '';
      final gradient = AnimationMapper.getGradient(condition, isNight);

      return Scaffold(
        body: AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildSearchBar(),
                Expanded(
                  child: controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : controller.errorMessage.value.isNotEmpty
                          ? _buildError(controller.errorMessage.value)
                          : weather == null
                              ? _buildEmpty()
                              : _buildWeatherContent(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  // ── SEARCH BAR ──────────────────────────────────────────────────────
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                ),
              ),
              child: TextField(
                controller: searchController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search city...',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  prefixIcon: Icon(
                    Icons.location_on_outlined,
                    color: Colors.white54,
                  ),
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    controller.fetchWeather(value.trim());
                  }
                },
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              if (searchController.text.isNotEmpty) {
                controller.fetchWeather(
                  searchController.text.trim(),
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                ),
              ),
              child: const Icon(Icons.search, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // ── EMPTY STATE ─────────────────────────────────────────────────────
  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.wb_sunny_outlined,
            color: Colors.white24,
            size: 100,
          ),
          const SizedBox(height: 20),
          const Text(
            'Search for a city',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Get weather + AI suggestions',
            style: TextStyle(
              color: Colors.white30,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // ── ERROR STATE ─────────────────────────────────────────────────────
  Widget _buildError(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.cloud_off,
            color: Colors.white38,
            size: 80,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () {
              if (searchController.text.isNotEmpty) {
                controller.fetchWeather(
                  searchController.text.trim(),
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Try Again',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── MAIN WEATHER CONTENT ────────────────────────────────────────────
  Widget _buildWeatherContent() {
    final w = controller.weather.value!;
    final animationPath = AnimationMapper.getAnimation(
      w.condition,
      w.isNight,
    );

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 10),

          // City & Country
          Text(
            '${w.cityName}, ${w.country}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ).animate()
              .fadeIn(duration: 500.ms)
              .slideY(begin: -0.2),

          const SizedBox(height: 4),

          // Date
          Text(
            DateFormat('EEEE, MMM d').format(DateTime.now()),
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 14,
            ),
          ).animate().fadeIn(duration: 500.ms, delay: 100.ms),

          // Lottie Animation
          Lottie.asset(
            animationPath,
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),

          // Temperature
          Text(
            '${w.temperature.toStringAsFixed(0)}°C',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 80,
              fontWeight: FontWeight.w200,
            ),
          ).animate().fadeIn(duration: 500.ms, delay: 200.ms),

          // Condition Description
          Text(
            w.description.toUpperCase(),
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              letterSpacing: 2,
            ),
          ).animate().fadeIn(duration: 500.ms, delay: 300.ms),

          const SizedBox(height: 8),

          // Min / Max Temp
          Text(
            'H: ${w.tempMax.toStringAsFixed(0)}°  '
            'L: ${w.tempMin.toStringAsFixed(0)}°',
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 24),

          // Details Card (Glassmorphism)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildDetailItem('💧', '${w.humidity.toInt()}%', 'Humidity'),
                _buildDetailItem('💨', '${w.windSpeed} m/s', 'Wind'),
                _buildDetailItem('🌡️', '${w.feelsLike.toStringAsFixed(0)}°C', 'Feels Like'),
                _buildDetailItem(
                  '👁️',
                  '${(w.visibility / 1000).toStringAsFixed(1)} km',
                  'Visibility',
                ),
              ],
            ),
          ).animate().fadeIn(duration: 500.ms, delay: 400.ms),

          const SizedBox(height: 16),

          // Hourly Forecast
          if (controller.hourlyForecast.isNotEmpty)
            _buildHourlyForecast(),

          const SizedBox(height: 16),

          // AI Suggestion Card
          Obx(() => AiSuggestionCard(
                suggestion: controller.aiSuggestion.value,
                isLoading: controller.isAiLoading.value,
              )),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // ── HOURLY FORECAST ─────────────────────────────────────────────────
  Widget _buildHourlyForecast() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'HOURLY FORECAST',
            style: TextStyle(
              color: Colors.white60,
              fontSize: 12,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: controller.hourlyForecast.length,
            itemBuilder: (context, index) {
              final item = controller.hourlyForecast[index];
              final time = DateTime.fromMillisecondsSinceEpoch(
                item['dt'] * 1000,
              );
              final temp = item['main']['temp'].toDouble();
              final icon = item['weather'][0]['icon'];

              return Container(
                width: 70,
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('HH:mm').format(time),
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Image.network(
                      'https://openweathermap.org/img/wn/$icon@2x.png',
                      width: 36,
                      height: 36,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${temp.toStringAsFixed(0)}°',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ).animate().fadeIn(duration: 500.ms, delay: 500.ms);
  }

  // ── DETAIL ITEM ─────────────────────────────────────────────────────
  Widget _buildDetailItem(String emoji, String value, String label) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 22)),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
