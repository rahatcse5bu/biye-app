import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class IslamicQuote extends StatelessWidget {
  const IslamicQuote({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.format_quote,
            size: 32,
            color: AppTheme.primaryColor.withOpacity(0.6),
          ),
          const SizedBox(height: 12),
          const Text(
            'যে ব্যক্তি বিয়ে করলো সে তার অর্ধেক দ্বীন পূর্ণ করে ফেললো। বাকি অর্ধেকের জন্য সে আল্লাহকে ভয় করুক।',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppTheme.textPrimaryColor,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            '(বায়হাকী, শু\'আবুল ঈমান - ৫৪৮৬)',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
