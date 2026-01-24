import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('আমাদের সম্পর্কে'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primaryColor, AppTheme.primaryColor.withOpacity(0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'PNC Nikah',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'ইসলামিক ম্যাট্রিমনি প্ল্যাটফর্ম',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // About Content
            _buildContentCard(
              'আমাদের লক্ষ্য',
              '''নিশ্চই সকল প্রশংসা আল্লাহর। আমরা তার কাছে আমাদের অন্তরের অনিষ্ট ও আমাদের কাজের অনিষ্ট থেকে আশ্রয় প্রার্থনা করি। দুরুদ ও সালাম বর্ষিত হোক রাসুল (ﷺ) এর উপর।

বিয়ে মহান আল্লাহপ্রদত্ত বিশেষ এক নিয়ামত ও রাসুল (ﷺ) এর একটি গুরুত্বপূর্ণ সুন্নাহ্। কুরআন ও হাদিসে বিয়েকে পবিত্রতার মাধ্যম, দ্বীনের অর্ধেক ও আর্থিক সচ্ছলতার উপায় হিসেবে উল্লেখ করেছেন।''',
              Icons.flag,
            ),

            const SizedBox(height: 16),

            _buildContentCard(
              'আমাদের উদ্দেশ্য',
              '''এ ওয়েবসাইটের মাধ্যমে বিয়ের জন্য শারীয়াসম্মত ইসলামিক ম্যাট্রিমনি প্লাটফর্ম গড়ে তোলা যার মাধ্যমে দ্বীনদার পাত্রপাত্রী সন্ধান সহজ করা।

জাহেলী সমাজের সকল অপসংস্কৃতি ভেঙ্গে যিনা-ব্যভিচার বন্ধ করে বিবাহে উৎসাহিত করা, পাত্রীর পরিবারের জন্য চিরঅভিশাপ- যৌতুকের বিরুদ্ধে সবাইকে সচেতন করা এবং নগদ মোহরানায় সুন্নাহ সম্মত বিয়েকে প্রচলিত করা।''',
              Icons.track_changes,
            ),

            const SizedBox(height: 16),

            _buildContentCard(
              'আমাদের প্রতিশ্রুতি',
              '''দ্বীনদার পাত্র-পাত্রী খুঁজে পাওয়া যেন আরও সহজ হয় এজন্য আমাদের সুদূরপ্রসারী পরিকল্পনা রয়েছে যা নিয়ে আমরা প্রতিনিয়ত গবেষণা করছি।

সকল মুসলিম ভাইবোনদের কাছে এ খেদমত দক্ষতার সাথে অতি শীঘ্রই পৌঁছে দিতে চেষ্টা চালিয়ে যাচ্ছি।

আল্লাহ আমাদের নিয়্যত পবিত্র রাখুন, আমাদের সকল নেককাজ সহজ করুন এবং বারকাহ দান করুন। আমিন।''',
              Icons.handshake,
            ),

            const SizedBox(height: 24),

            // Features
            const Text(
              'আমাদের বৈশিষ্ট্য',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            _buildFeatureItem(
              Icons.verified_user,
              'যাচাইকৃত বায়োডাটা',
              'প্রতিটি বায়োডাটা অভিভাবকের অনুমতি সাপেক্ষে যাচাই করা হয়।',
            ),
            _buildFeatureItem(
              Icons.security,
              'নিরাপদ ও গোপনীয়',
              'আপনার তথ্য সম্পূর্ণ নিরাপদ ও গোপনীয় রাখা হয়।',
            ),
            _buildFeatureItem(
              Icons.people,
              'পরিবার-কেন্দ্রিক',
              'অভিভাবকদের সাথে সরাসরি যোগাযোগের সুবিধা।',
            ),
            _buildFeatureItem(
              Icons.auto_awesome,
              'সহজ ও সাশ্রয়ী',
              'সহজ প্রক্রিয়া ও সাশ্রয়ী মূল্যে সেবা।',
            ),

            const SizedBox(height: 24),

            // Version Info
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'PNC Nikah',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Version 1.0.0',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildContentCard(String title, String content, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppTheme.primaryColor, size: 24),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppTheme.primaryColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
