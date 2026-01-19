import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../auth/presentation/pages/login_page.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../biodata/presentation/pages/biodata_list_page.dart';
import '../../../favorites/presentation/pages/favorites_page.dart';
import '../../../dashboard/presentation/pages/dashboard_page.dart';
import 'home_content_page.dart';

// Provider for current navigation index
final navigationIndexProvider = StateProvider<int>((ref) => 0);

class MainNavigationPage extends ConsumerWidget {
  const MainNavigationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationIndexProvider);
    final authState = ref.watch(authNotifierProvider);
    final isAuthenticated = authState.maybeWhen(
      authenticated: (_) => true,
      orElse: () => false,
    );

    // Define pages based on auth state
    final pages = [
      const HomeTab(),
      const BiodataListPage(),
      if (isAuthenticated) const FavoritesPage(),
      if (isAuthenticated) const DashboardPage(),
    ];

    // Adjust index if user logs out and was on an auth-only page
    final safeIndex = currentIndex >= pages.length ? 0 : currentIndex;

    return Scaffold(
      body: IndexedStack(
        index: safeIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: safeIndex,
          onTap: (index) {
            // Check if user is trying to access auth-only pages
            if (!isAuthenticated && index >= 2) {
              // Show login dialog
              _showLoginPrompt(context);
              return;
            }
            ref.read(navigationIndexProvider.notifier).state = index;
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppTheme.primaryColor,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'হোম',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              activeIcon: Icon(Icons.search),
              label: 'বায়োডাটা',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_outline,
                color: isAuthenticated ? null : Colors.grey.shade400,
              ),
              activeIcon: const Icon(Icons.favorite),
              label: 'পছন্দ',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                color: isAuthenticated ? null : Colors.grey.shade400,
              ),
              activeIcon: const Icon(Icons.person),
              label: 'প্রোফাইল',
            ),
          ],
        ),
      ),
    );
  }

  void _showLoginPrompt(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('লগইন প্রয়োজন'),
        content: const Text('এই ফিচার ব্যবহার করতে আপনাকে লগইন করতে হবে।'),
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
            ),
            child: const Text('লগইন করুন'),
          ),
        ],
      ),
    );
  }
}

// Home Tab without its own app bar (uses the navigation shell)
class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const HomeContentPage();
  }
}
