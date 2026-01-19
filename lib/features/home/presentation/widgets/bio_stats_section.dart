import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/home_provider.dart';

class BioStatsSection extends ConsumerWidget {
  const BioStatsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(biodataStatsProvider);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'এক নজরে আমাদের সাইটঃ',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          statsAsync.when(
            data: (stats) => _buildStatsGrid(stats),
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(),
              ),
            ),
            error: (_, __) => const Center(
              child: Text('তথ্য লোড করতে সমস্যা হয়েছে'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(Map<String, dynamic> stats) {
    final maleCount = stats['পুরুষ'] ?? 0;
    final femaleCount = stats['মহিলা'] ?? 0;
    final totalCount = maleCount + femaleCount;
    final completedMarriages = stats['completedMarriages'] ?? 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.4,
        children: [
          _StatCard(
            value: totalCount.toString(),
            label: 'সর্বমোট বায়োডাটা',
            icon: Icons.people,
            color: AppTheme.primaryColor,
          ),
          _StatCard(
            value: maleCount.toString(),
            label: 'পাত্রের বায়োডাটা',
            icon: Icons.man,
            color: Colors.blue,
          ),
          _StatCard(
            value: femaleCount.toString(),
            label: 'পাত্রীর বায়োডাটা',
            icon: Icons.woman,
            color: Colors.pink,
          ),
          _StatCard(
            value: completedMarriages.toString(),
            label: 'বিয়ে সম্পন্ন',
            icon: Icons.favorite,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
