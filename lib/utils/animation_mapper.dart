import 'package:flutter/material.dart';

class AnimationMapper {
  static String getAnimation(String condition, bool isNight) {
    if (isNight) {
      switch (condition.toLowerCase()) {
        case 'rain':
        case 'drizzle':
          return 'assets/animations/rainy.json';
        case 'thunderstorm':
          return 'assets/animations/stormy.json';
        default:
          return 'assets/animations/night.json';
      }
    }
    switch (condition.toLowerCase()) {
      case 'clear':
        return 'assets/animations/sunny.json';
      case 'clouds':
        return 'assets/animations/cloudy.json';
      case 'rain':
      case 'drizzle':
        return 'assets/animations/rainy.json';
      case 'thunderstorm':
        return 'assets/animations/stormy.json';
      case 'snow':
        return 'assets/animations/snowy.json';
      case 'mist':
      case 'fog':
      case 'haze':
        return 'assets/animations/foggy.json';
      default:
        return 'assets/animations/cloudy.json';
    }
  }

  static List<Color> getGradient(String condition, bool isNight) {
    if (isNight) {
      return [const Color(0xFF0B1120), const Color(0xFF1A2340)];
    }
    switch (condition.toLowerCase()) {
      case 'clear':
        return [const Color(0xFF1A56DB), const Color(0xFF38E8C5)];
      case 'clouds':
        return [const Color(0xFF4A5568), const Color(0xFF718096)];
      case 'rain':
      case 'drizzle':
        return [const Color(0xFF2D3748), const Color(0xFF4A5568)];
      case 'thunderstorm':
        return [const Color(0xFF1A202C), const Color(0xFF2D3748)];
      case 'snow':
        return [const Color(0xFF4299E1), const Color(0xFFBEE3F8)];
      case 'mist':
      case 'fog':
      case 'haze':
        return [const Color(0xFF718096), const Color(0xFFA0AEC0)];
      default:
        return [const Color(0xFF1A56DB), const Color(0xFF7C5CFC)];
    }
  }
}
