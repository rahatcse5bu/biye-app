import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../auth/presentation/pages/login_page.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../payments/presentation/pages/buy_points_page.dart';

class PaymentPackagesPage extends ConsumerWidget {
  const PaymentPackagesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final isAuthenticated = authState.maybeWhen(
      authenticated: (_) => true,
      orElse: () => false,
    );

    final packages = [
      {
        'name': 'বেসিক প্যাকেজ',
        'price': '৩০ টাকা',
        'value': 30,
        'features': [
          '৩৬ পয়েন্ট',
          'সর্বোচ্চ ১ বার বায়োডাটা শেয়ার',
          'সর্বোচ্চ ০ বার অভিভাবকের তথ্য',
        ],
      },
      {
        'name': 'স্ট্যান্ডার্ড প্যাকেজ',
        'price': '১০০ টাকা',
        'value': 100,
        'features': [
          '১২৫ পয়েন্ট',
          'সর্বোচ্চ ৩ বার বায়োডাটা শেয়ার',
          'সর্বোচ্চ ১ বার অভিভাবকের তথ্য',
        ],
      },
      {
        'name': 'প্রিমিয়াম প্যাকেজ',
        'price': '২০০ টাকা',
        'value': 200,
        'features': [
          '২৪০ পয়েন্ট',
          'সর্বোচ্চ ৭ বার বায়োডাটা শেয়ার',
          'সর্বোচ্চ ৩ বার অভিভাবকের তথ্য',
        ],
      },
      {
        'name': 'প্রো প্যাকেজ',
        'price': '৩০০ টাকা',
        'value': 300,
        'features': [
          '৩৬০ পয়েন্ট',
          'সর্বোচ্চ ১১ বার বায়োডাটা শেয়ার',
          'সর্বোচ্চ ৪ বার অভিভাবকের তথ্য',
        ],
      },
      {
        'name': 'এন্টারপ্রাইজ প্যাকেজ',
        'price': '৫০০ টাকা',
        'value': 500,
        'features': [
          '৬০০ পয়েন্ট',
          'সর্বোচ্চ ১৮ বার বায়োডাটা শেয়ার',
          'সর্বোচ্চ ৮ বার অভিভাবকের তথ্য',
        ],
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('পেমেন্ট প্যাকেজ'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
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
                  const Text(
                    'আপনার পছন্দের প্যাকেজ কিনুন',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'পাত্র/পাত্রীর সাথে প্রতিবার আপনার বায়োডাটা শেয়ার করতে আপনাকে ৩০ পয়েন্ট খরচ করতে হবে। আর পাত্র/পাত্রীর অভিভাবকের যোগাযোগ এর নাম্বার পেতে আপনাকে ৭০ পয়েন্ট খরচ করতে হবে।',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.9),
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '💳 বিকাশ, নগদ, রকেট দিয়ে পেমেন্ট করুন',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Packages Grid
            ...packages.map((package) => _buildPackageCard(
              context,
              ref,
              package,
              isAuthenticated,
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildPackageCard(
    BuildContext context,
    WidgetRef ref,
    Map<String, dynamic> package,
    bool isAuthenticated,
  ) {
    final features = package['features'] as List<String>;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  package['name'] as String,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    package['price'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...features.map((feature) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green[600],
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      feature,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            )),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (isAuthenticated) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const BuyPointsPage()),
                    );
                  } else {
                    _showLoginDialog(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'প্যাকেজ কিনুন',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('লগইন প্রয়োজন'),
        content: const Text('প্যাকেজ কিনতে আপনাকে প্রথমে লগইন করতে হবে।'),
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
