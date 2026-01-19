import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'বাংলাদেশী ইসলামিক',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'ম্যাট্রিমনি ',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimaryColor,
                  ),
                ),
                TextSpan(
                  text: 'Biye ',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
                TextSpan(
                  text: 'App',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'আপনার নিজ উপজেলায় দ্বীনদার পাত্রপাত্রী খুঁজুন খুব সহজে',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
