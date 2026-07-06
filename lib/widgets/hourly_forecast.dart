import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HourlyForecast extends StatelessWidget {
  final List<Map<String, dynamic>> forecast;

  const HourlyForecast({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: forecast.length,
        itemBuilder: (context, index) {
          final item = forecast[index];
          final time = DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000);
          final temp = item['main']['temp'].toDouble();
          final icon = item['weather'][0]['icon'];

          return Container(
            width: 80,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat('h a').format(time),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Image.network(
                  'https://openweathermap.org/img/wn/$icon.png',
                  width: 40,
                  height: 40,
                ),
                const SizedBox(height: 8),
                Text(
                  '${temp.toStringAsFixed(1)}°',
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
