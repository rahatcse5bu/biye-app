import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/dashboard_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardStats = ref.watch(dashboardStatsProvider);
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authNotifierProvider.notifier).logout();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(dashboardStatsProvider);
        },
        child: dashboardStats.when(
          data: (stats) => _buildDashboardContent(context, stats, authState),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'Error loading dashboard',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref.invalidate(dashboardStatsProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardContent(BuildContext context, dynamic stats, dynamic authState) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dashboard',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
          ),
          const SizedBox(height: 24),
          
          // Points Card
          _buildStatCard(
            context,
            title: 'আমার বর্তমান পয়েন্ট',
            value: stats.points.toStringAsFixed(2),
            description: 'আপনার একাউন্টে এখন যত্‌পরিমাণ পয়েন্ট জমা রয়েছে',
            icon: Icons.stars,
            color: AppTheme.primaryColor,
            actionLabel: 'পয়েন্ট রিচার্জ করুন',
            onActionPressed: () {
              // Navigate to recharge page
            },
          ),
          
          const SizedBox(height: 16),
          
          // Grid of stats cards
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.85,
            children: [
              _buildSmallStatCard(
                context,
                title: 'পেন্ডিং প্রস্তাব',
                value: '${stats.pendingProposals} টি',
                icon: Icons.pending_actions,
                color: Colors.orange,
              ),
              _buildSmallStatCard(
                context,
                title: 'মোট প্রস্তাব',
                value: '${stats.totalProposals} টি',
                icon: Icons.list_alt,
                color: Colors.blue,
              ),
              _buildSmallStatCard(
                context,
                title: 'পছন্দের তালিকায়',
                value: '${stats.favoriteCount}',
                icon: Icons.favorite,
                color: Colors.red,
              ),
              _buildSmallStatCard(
                context,
                title: 'অপছন্দের তালিকায়',
                value: '${stats.unFavoriteCount}',
                icon: Icons.heart_broken,
                color: Colors.grey,
              ),
              _buildSmallStatCard(
                context,
                title: 'আপনাকে পছন্দ করেছে',
                value: '${stats.likesCount}',
                icon: Icons.thumb_up,
                color: Colors.green,
              ),
              _buildSmallStatCard(
                context,
                title: 'বায়োডাটা ভিজিট',
                value: '${stats.viewsCount}',
                icon: Icons.visibility,
                color: Colors.purple,
              ),
              _buildSmallStatCard(
                context,
                title: 'আমার ক্রয়সমূহ',
                value: '${stats.contactPurchaseCount}',
                icon: Icons.shopping_cart,
                color: Colors.teal,
              ),
              _buildSmallStatCard(
                context,
                title: 'আপ্রুভাল রেট',
                value: '${stats.approvedPercentage.toStringAsFixed(2)}%',
                icon: Icons.check_circle,
                color: Colors.lightGreen,
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Rejection Rate Card
          _buildStatCard(
            context,
            title: 'আমার রিজেকশন রেট',
            value: '${stats.rejectedPercentage.toStringAsFixed(2)}%',
            description: 'আপনি মোট যতগুলো বায়োডাটা রিজেক্ট করেছেন / মোট যতগুলো বায়োডাটার প্রস্তাব পেয়েছেন',
            icon: Icons.cancel,
            color: Colors.red.shade700,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required String description,
    required IconData icon,
    required Color color,
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 32),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade700,
                  ),
            ),
            if (actionLabel != null && onActionPressed != null) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onActionPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(actionLabel),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSmallStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.withOpacity(0.3), width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 40),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
