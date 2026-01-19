import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class HadithSlider extends StatefulWidget {
  const HadithSlider({super.key});

  @override
  State<HadithSlider> createState() => _HadithSliderState();
}

class _HadithSliderState extends State<HadithSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _hadiths = [
    {
      'text': 'হে যুব সম্প্রদায়! তোমাদের মধ্যে যারাই স্ত্রীর অধিকার আদায়ে সামর্থ্য রাখে, তারা যেন অবশ্যই বিয়ে বন্ধনে আবদ্ধ হয়।',
      'ref': '(সূরা রুম : আয়াত ২১)',
    },
    {
      'text': 'আর এক নিদর্শন এই যে, তিনি তোমাদের জন্যে তোমাদের মধ্য থেকে তোমাদের সঙ্গিনীদের সৃষ্টি করেছেন, যাতে তোমরা তাদের কাছে শান্তিতে থাক।',
      'ref': 'সহীহ - মুত্তাফাকুন \'আলাইহি (বুখারী ও মুসলিম)',
    },
    {
      'text': 'বিয়ে হলো আমার সুন্নাত যে ব্যক্তি আমার সুন্নাত তরিকা ছেড়ে চলবে সে আমার দলভুক্ত নয়।',
      'ref': '(বুখারি)',
    },
    {
      'text': 'হে যুবসমাজ! তোমাদের মধ্যে যারা বিয়ের সামর্থ্য রাখে, তাদের বিয়ে করা কর্তব্য, কেননা বিয়ে দৃষ্টি নিয়ন্ত্রণকারী, যৌন অঙ্গের পবিত্রতা রক্ষাকারী।',
      'ref': '(মিশকাত)',
    },
    {
      'text': 'তারা (স্ত্রীগণ) তোমাদের পোশাক এবং তোমরা (স্বামীগণ) তাদের পোশাকস্বরূপ।',
      'ref': '(সূরা বাকারা : আয়াত ১৮৭)',
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        final nextPage = (_currentPage + 1) % _hadiths.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
        _startAutoScroll();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        children: [
          Text(
            'বিয়ে সম্পর্কিত কুরআনের কিছু আয়াত ও কিছু হাদিসঃ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _hadiths.length,
              itemBuilder: (context, index) {
                return _buildHadithCard(_hadiths[index]);
              },
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _hadiths.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == index ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? AppTheme.primaryColor
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHadithCard(Map<String, String> hadith) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Text(
                hadith['text']!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textPrimaryColor,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            hadith['ref']!,
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
