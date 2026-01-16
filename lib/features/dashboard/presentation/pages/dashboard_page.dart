import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/dashboard_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../biodata_edit/presentation/pages/biodata_edit_page.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardStats = ref.watch(dashboardStatsProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        title: const Text('Dashboard', style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'বায়োডাটা সম্পাদনা',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BiodataEditPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () => ref.read(authNotifierProvider.notifier).logout(),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(dashboardStatsProvider),
        child: dashboardStats.when(
          data: (stats) => _buildDashboardContent(context, stats),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => _buildErrorState(context, ref, error),
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref, Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.error_outline, size: 48, color: Colors.red.shade400),
            ),
            const SizedBox(height: 16),
            Text(
              'Unable to load dashboard',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please check your connection and try again',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => ref.invalidate(dashboardStatsProvider),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardContent(BuildContext context, dynamic stats) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          // Header with gradient
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primaryColor, AppTheme.primaryColor.withOpacity(0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 2, 14, 14),
                child: _buildPointsCard(context, stats),
              ),
            ),
          ),
          
          // Stats Grid
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.25,
                  children: [
                    _buildCompactStatCard(
                      context,
                      title: 'পেন্ডিং প্রস্তাব',
                      value: '${stats.pendingProposals}',
                      unit: 'টি',
                      icon: Icons.pending_actions_rounded,
                      color: AppTheme.primaryColor,
                    ),
                    _buildCompactStatCard(
                      context,
                      title: 'মোট প্রস্তাব',
                      value: '${stats.totalProposals}',
                      unit: 'টি',
                      icon: Icons.list_alt_rounded,
                      color: AppTheme.primaryColor.withOpacity(0.85),
                    ),
                    _buildCompactStatCard(
                      context,
                      title: 'পছন্দের তালিকায়',
                      value: '${stats.favoriteCount}',
                      unit: '',
                      icon: Icons.favorite_rounded,
                      color: AppTheme.secondaryColor,
                    ),
                    _buildCompactStatCard(
                      context,
                      title: 'অপছন্দের তালিকায়',
                      value: '${stats.unFavoriteCount}',
                      unit: '',
                      icon: Icons.heart_broken_rounded,
                      color: AppTheme.primaryColor.withOpacity(0.7),
                    ),
                    _buildCompactStatCard(
                      context,
                      title: 'আপনাকে পছন্দ করেছে',
                      value: '${stats.likesCount}',
                      unit: '',
                      icon: Icons.thumb_up_rounded,
                      color: AppTheme.secondaryColor.withOpacity(0.85),
                    ),
                    _buildCompactStatCard(
                      context,
                      title: 'বায়োডাটা ভিজিট',
                      value: '${stats.viewsCount}',
                      unit: '',
                      icon: Icons.visibility_rounded,
                      color: AppTheme.primaryColor.withOpacity(0.75),
                    ),
                    _buildCompactStatCard(
                      context,
                      title: 'আমার ক্রয়সমূহ',
                      value: '${stats.contactPurchaseCount}',
                      unit: '',
                      icon: Icons.shopping_bag_rounded,
                      color: AppTheme.secondaryColor.withOpacity(0.75),
                    ),
                    _buildCompactStatCard(
                      context,
                      title: 'আপ্রুভাল রেট',
                      value: stats.approvedPercentage.toStringAsFixed(0),
                      unit: '%',
                      icon: Icons.check_circle_rounded,
                      color: AppTheme.secondaryColor.withOpacity(0.9),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildRejectionCard(context, stats),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPointsCard(BuildContext context, dynamic stats) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.stars_rounded,
                  color: AppTheme.primaryColor,
                  size: 18,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'আমার বর্তমান পয়েন্ট',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      stats.points.toStringAsFixed(2),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'আপনার একাউন্টে এখন যত্‌পরিমাণ পয়েন্ট জমা রয়েছে',
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade600,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Text(
                'পয়েন্ট রিচার্জ করুন',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required String unit,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.25),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(icon, color: Colors.white, size: 16),
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (unit.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 2, bottom: 1),
                        child: Text(
                          unit,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white.withOpacity(0.95),
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRejectionCard(BuildContext context, dynamic stats) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.errorColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppTheme.errorColor.withOpacity(0.25),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.cancel_rounded, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'আমার রিজেকশন রেট',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withOpacity(0.95),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  '${stats.rejectedPercentage.toStringAsFixed(2)}%',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'রিজেক্ট / মোট প্রস্তাব',
                  style: TextStyle(
                    fontSize: 9,
                    color: Colors.white.withOpacity(0.85),
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