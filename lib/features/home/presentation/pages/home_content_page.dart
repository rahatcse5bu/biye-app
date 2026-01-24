import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../auth/presentation/pages/login_page.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../biodata/presentation/pages/biodata_list_page.dart';
import '../../../dashboard/presentation/pages/dashboard_page.dart';
import '../../../static_pages/presentation/pages/payment_packages_page.dart';
import '../../../static_pages/presentation/pages/biodata_submit_page.dart';
import '../../../static_pages/presentation/pages/refund_policy_page.dart';
import '../../../static_pages/presentation/pages/faq_page.dart';
import '../../../static_pages/presentation/pages/about_us_page.dart';
import '../../../static_pages/presentation/pages/contact_us_page.dart';
import '../widgets/home_banner.dart';
import '../widgets/islamic_quote.dart';
import '../widgets/home_search_section.dart';
import '../widgets/featured_biodata_section.dart';
import '../widgets/hadith_slider.dart';
import '../widgets/bio_stats_section.dart';

class HomeContentPage extends ConsumerWidget {
  const HomeContentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final isAuthenticated = authState.maybeWhen(
      authenticated: (_) => true,
      orElse: () => false,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.favorite, color: Colors.white, size: 24),
            const SizedBox(width: 8),
            const Text(
              'Biye',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          if (isAuthenticated)
            IconButton(
              icon: const Icon(Icons.dashboard, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DashboardPage()),
                );
              },
            )
          else
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              },
              child: const Text(
                'লগইন',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(authNotifierProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Hero Banner
              const HomeBanner(),
              
              // Islamic Quote
              const IslamicQuote(),
              
              // Search Section
              const HomeSearchSection(),
              
              // Featured Biodatas
              const FeaturedBiodataSection(),
              
              // Hadith Slider
              const HadithSlider(),
              
              // Bio Stats
              const BioStatsSection(),
              
              // View All Button
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BiodataListPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.list_alt),
                      SizedBox(width: 8),
                      Text(
                        'সকল বায়োডাটা দেখুন',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Quick Links Section
              _buildQuickLinksSection(context),
              
              // Footer spacing
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickLinksSection(BuildContext context) {
    final quickLinks = [
      {
        'icon': Icons.list_alt,
        'title': 'বায়োডাটা',
        'page': const BiodataListPage(),
      },
      {
        'icon': Icons.shopping_bag,
        'title': 'পেমেন্ট প্যাকেজ',
        'page': const PaymentPackagesPage(),
      },
      {
        'icon': Icons.edit_document,
        'title': 'বায়োডাটা সাবমিট',
        'page': const BiodataSubmitPage(),
      },
      {
        'icon': Icons.policy,
        'title': 'রিফান্ড পলিসি',
        'page': const RefundPolicyPage(),
      },
      {
        'icon': Icons.help_center,
        'title': 'সচরাচর জিজ্ঞাসা',
        'page': const FaqPage(),
      },
      {
        'icon': Icons.info,
        'title': 'আমাদের সম্পর্কে',
        'page': const AboutUsPage(),
      },
      {
        'icon': Icons.contact_support,
        'title': 'যোগাযোগ করুন',
        'page': const ContactUsPage(),
      },
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'দ্রুত লিংক',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Container(
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
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemCount: quickLinks.length,
              itemBuilder: (context, index) {
                final link = quickLinks[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => link['page'] as Widget),
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          link['icon'] as IconData,
                          color: AppTheme.primaryColor,
                          size: 22,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Flexible(
                        child: Text(
                          link['title'] as String,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
