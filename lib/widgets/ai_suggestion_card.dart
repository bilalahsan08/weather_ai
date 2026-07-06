import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AiSuggestionCard extends StatelessWidget {
  final String suggestion;
  final bool isLoading;
  
  const AiSuggestionCard({
    super.key,
    required this.suggestion,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text('💡', style: TextStyle(fontSize: 20)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'AI Suggestion',
                  style: TextStyle(
                    color: Colors.white70, 
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 6),
                isLoading
                    ? const SizedBox(
                        height: 16, 
                        width: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2, 
                          color: Colors.white54,
                        ),
                      )
                    : Text(
                        suggestion,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14, 
                          height: 1.5,
                        ),
                      ).animate().fadeIn(duration: 600.ms),
              ],
            ),
          ),
        ],
      ),
    ).animate().slideY(begin: 0.3, duration: 500.ms, curve: Curves.easeOut);
  }
}
