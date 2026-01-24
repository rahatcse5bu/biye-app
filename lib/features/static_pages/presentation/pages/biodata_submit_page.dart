import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../auth/presentation/pages/login_page.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../biodata_edit/presentation/pages/biodata_edit_page.dart';

class BiodataSubmitPage extends ConsumerWidget {
  const BiodataSubmitPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final isAuthenticated = authState.maybeWhen(
      authenticated: (_) => true,
      orElse: () => false,
    );

    final videoTutorials = [
      {
        'title': '১. PNC নিকাহ এর পার্টিকুলার ফিচারসমূহ',
        'description': 'PNC নিকাহ এর বিশেষ ফিচারসমূহ জানুন',
        'videoId': 'dQw4w9WgXcQ', // Replace with actual video ID
      },
      {
        'title': '২. PNC নিকাহতে মোবাইল দিয়ে কিভাবে পাত্রীর বায়োডাটা ট্রাইতে দিতে হয়?',
        'description': 'মোবাইল অ্যাপ দিয়ে বায়োডাটা তৈরি করার টিউটোরিয়াল',
        'videoId': 'dQw4w9WgXcQ', // Replace with actual video ID
      },
      {
        'title': '৩. PNC নিকাহতে ল্যাপটপ দিয়ে কিভাবে পাত্রীর বায়োডাটা ট্রাইতে দিতে হয়?',
        'description': 'ল্যাপটপ/কম্পিউটার দিয়ে বায়োডাটা তৈরি করার টিউটোরিয়াল',
        'videoId': 'dQw4w9WgXcQ', // Replace with actual video ID
      },
      {
        'title': '৪. বায়োডাটা ক্রয় প্রথম পদক্ষেপ',
        'description': 'বায়োডাটা কেনার প্রথম ধাপ - বায়োডাটা শেয়ার করা',
        'videoId': 'dQw4w9WgXcQ', // Replace with actual video ID
      },
      {
        'title': '৫. বায়োডাটা ক্রয় দ্বিতীয় পদক্ষেপ',
        'description': 'বায়োডাটা কেনার দ্বিতীয় ধাপ - অভিভাবকের তথ্য পাওয়া',
        'videoId': 'dQw4w9WgXcQ', // Replace with actual video ID
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('বায়োডাটা সাবমিট'),
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
              padding: const EdgeInsets.all(20),
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
                  const Icon(
                    Icons.play_circle_filled,
                    color: Colors.white,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'নির্দেশনা সমূহ',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'How to create bridegroom\'s biodata on PNC Nikah for free',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Video Tutorials Section
            const Text(
              'ভিডিও টিউটোরিয়াল',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            ...videoTutorials.map((video) => _buildVideoCard(
              context,
              video['title'] as String,
              video['description'] as String,
              video['videoId'] as String,
            )),

            const SizedBox(height: 24),

            // Quick Steps Section
            const Text(
              'সংক্ষিপ্ত ধাপসমূহ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            _buildStepCard(1, Icons.person_add, 'অ্যাকাউন্ট তৈরি করুন', 
                'প্রথমে আপনার ইমেইল বা গুগল অ্যাকাউন্ট দিয়ে রেজিস্ট্রেশন করুন।'),
            _buildStepCard(2, Icons.edit_document, 'বায়োডাটা পূরণ করুন', 
                'আপনার সমস্ত তথ্য সঠিকভাবে বায়োডাটা ফর্মে পূরণ করুন।'),
            _buildStepCard(3, Icons.family_restroom, 'অভিভাবকের তথ্য দিন', 
                'অভিভাবকের সম্মতি ও যোগাযোগের তথ্য প্রদান করুন।'),
            _buildStepCard(4, Icons.verified, 'অনুমোদনের অপেক্ষা করুন', 
                'আমাদের টিম আপনার বায়োডাটা যাচাই করে অনুমোদন দিবে।'),
            _buildStepCard(5, Icons.search, 'পাত্র/পাত্রী খুঁজুন', 
                'অনুমোদনের পর আপনি পাত্র/পাত্রী খুঁজতে পারবেন।'),

            const SizedBox(height: 24),

            // Guidelines Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.amber[700]),
                      const SizedBox(width: 8),
                      Text(
                        'গুরুত্বপূর্ণ নির্দেশনা',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber[900],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildGuidelineItem('সঠিক ও বাস্তব তথ্য প্রদান করুন।'),
                  _buildGuidelineItem('অভিভাবকের অনুমতি ছাড়া বায়োডাটা দেওয়া যাবে না।'),
                  _buildGuidelineItem('ছবি আপলোড করা বাধ্যতামূলক নয়।'),
                  _buildGuidelineItem('মিথ্যা তথ্য দিলে অ্যাকাউন্ট বন্ধ করে দেওয়া হবে।'),
                  _buildGuidelineItem('বিয়ে হয়ে গেলে অবশ্যই বায়োডাটা হাইড করুন।'),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // CTA Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  if (isAuthenticated) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const BiodataEditPage()),
                    );
                  } else {
                    _showLoginDialog(context);
                  }
                },
                icon: Icon(isAuthenticated ? Icons.edit : Icons.login),
                label: Text(isAuthenticated ? 'বায়োডাটা সাবমিট করুন' : 'লগইন করে শুরু করুন'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoCard(BuildContext context, String title, String description, String videoId) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
          // Video Title
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryColor,
              ),
            ),
          ),
          
          // Video Thumbnail
          InkWell(
            onTap: () => _launchYouTube(videoId),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 180,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(
                    'https://img.youtube.com/vi/$videoId/maxresdefault.jpg',
                  ),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) {},
                ),
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ),
          ),
          
          // Description
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.play_circle_outline, color: Colors.red, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => _launchYouTube(videoId),
                  child: const Text(
                    'দেখুন',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepCard(int stepNumber, IconData icon, String title, String description) {
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
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                '$stepNumber',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, size: 18, color: AppTheme.primaryColor),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuidelineItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.arrow_right, color: Colors.amber[700], size: 20),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                color: Colors.amber[900],
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchYouTube(String videoId) async {
    final url = Uri.parse('https://www.youtube.com/watch?v=$videoId');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('লগইন প্রয়োজন'),
        content: const Text('বায়োডাটা সাবমিট করতে আপনাকে প্রথমে লগইন করতে হবে।'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('বাতিল'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('লগইন করুন'),
          ),
        ],
      ),
    );
  }
}
