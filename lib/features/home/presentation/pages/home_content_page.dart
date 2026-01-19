import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../auth/presentation/pages/login_page.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../biodata/presentation/pages/biodata_list_page.dart';
import '../../../dashboard/presentation/pages/dashboard_page.dart';
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
              
              // Footer spacing
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
