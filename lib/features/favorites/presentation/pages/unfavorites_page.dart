import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/unfavorites_provider.dart';
import '../../../biodata/presentation/pages/biodata_detail_page.dart';

class UnfavoritesPage extends ConsumerWidget {
  const UnfavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('অপছন্দের তালিকা'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(unfavoritesProvider);
          ref.invalidate(dislikedByProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Section 1: My Unfavorites (আমার অপছন্দসমূহ)
              _buildMyUnfavoritesSection(context, ref),
              
              const SizedBox(height: 24),
              
              // Section 2: Who Disliked Me (আমার বায়োডাটা বাদ অপছন্দের তালিকায় রয়েছে?)
              _buildDislikedBySection(context, ref),
              
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // Section 1: My Unfavorites
  Widget _buildMyUnfavoritesSection(BuildContext context, WidgetRef ref) {
    final unfavoritesAsync = ref.watch(unfavoritesProvider);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.heart_broken, color: Colors.grey.shade600, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'আমার অপছন্দসমূহ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          unfavoritesAsync.when(
            data: (unfavorites) => _buildUnfavoritesList(context, unfavorites, ref),
            loading: () => const Padding(
              padding: EdgeInsets.all(32.0),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stack) => _buildErrorState(context, ref, 'unfavorites'),
          ),
        ],
      ),
    );
  }

  // Section 2: Disliked By Me
  Widget _buildDislikedBySection(BuildContext context, WidgetRef ref) {
    final dislikedByAsync = ref.watch(dislikedByProvider);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.thumb_down, color: Colors.red.shade400, size: 20),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'আমার বায়োডাটা বাদ অপছন্দের তালিকায় রয়েছে?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
          dislikedByAsync.when(
            data: (dislikedBy) => _buildDislikedByList(context, dislikedBy, ref),
            loading: () => const Padding(
              padding: EdgeInsets.all(32.0),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stack) => _buildErrorState(context, ref, 'dislikedBy'),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref, String type) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.error_outline, size: 32, color: Colors.red.shade400),
          ),
          const SizedBox(height: 12),
          const Text(
            'তালিকা লোড করতে ব্যর্থ',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'আপনার সংযোগ পরীক্ষা করুন এবং পুনরায় চেষ্টা করুন',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              if (type == 'unfavorites') {
                ref.invalidate(unfavoritesProvider);
              } else {
                ref.invalidate(dislikedByProvider);
              }
            },
            icon: const Icon(Icons.refresh, size: 16),
            label: const Text('পুনরায় চেষ্টা করুন'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnfavoritesList(BuildContext context, dynamic unfavorites, WidgetRef ref) {
    if (unfavorites.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.heart_broken, size: 32, color: Colors.grey.shade400),
            ),
            const SizedBox(height: 12),
            const Text(
              'কোনো অপছন্দের তালিকা নেই',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'আপনার অপছন্দের বায়োডাটা এখানে দেখা যাবে',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'মোট অপছন্দ: ${unfavorites.length}',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          _buildTableHeader(),
          const SizedBox(height: 4),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: unfavorites.length,
            separatorBuilder: (_, __) => const Divider(height: 1, color: Colors.grey),
            itemBuilder: (context, index) => _buildTableRow(
              context,
              index + 1,
              unfavorites[index],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDislikedByList(BuildContext context, dynamic dislikedBy, WidgetRef ref) {
    if (dislikedBy.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.thumb_down, size: 32, color: Colors.red.shade400),
            ),
            const SizedBox(height: 12),
            const Text(
              'কেউ আপনাকে অপছন্দ করেনি',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'এই নিয়িত তথ্য দিয়াছে এই ওপার গুলোমস্ত সমূহের দিন গুলোতে মা শারে খরো উভয়টা।',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'মোট ডিসলাইক: ${dislikedBy.length}',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          _buildTableHeader(),
          const SizedBox(height: 4),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dislikedBy.length,
            separatorBuilder: (_, __) => const Divider(height: 1, color: Colors.grey),
            itemBuilder: (context, index) => _buildTableRow(
              context,
              index + 1,
              dislikedBy[index],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.2)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Row(
            children: [
              _buildHeaderCellFixed('SL', 40),
              _buildHeaderCellFixed('বায়োডাটা নং', 100),
              _buildHeaderCellFixed('জন্ম তারিখ', 110),
              _buildHeaderCellFixed('ঠিকানা', 200),
              _buildHeaderCellFixed('চেষ্টার পয়েন্ট', 100),
              _buildHeaderCellFixed('আয়ক্যান টে', 100),
              _buildHeaderCellFixed('রিকোমেন্ট টে', 100),
              _buildHeaderCellFixed('পছন্দের সংখ্যা', 100),
              _buildHeaderCellFixed('আসমান', 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCellFixed(String text, double width) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppTheme.primaryColor,
        ),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildTableRow(BuildContext context, int sl, dynamic unfavorite) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Row(
            children: [
              _buildCellFixed('$sl', 40),
              _buildCellFixed('${unfavorite.bioId}', 100),
              _buildCellFixed(unfavorite.formattedDOB, 110),
              _buildCellFixed(unfavorite.permanentAddress, 200),
              _buildCellFixed('4', 100),  // Contact points - placeholder
              _buildCellFixed('0.00%', 100),  // Approval % - placeholder
              _buildCellFixed('0.00%', 100),  // Recommendation % - placeholder
              _buildCellFixed('4', 100),  // Favorites count - placeholder
              _buildActionButton(context, unfavorite),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCellFixed(String text, double width) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          color: Colors.black87,
          height: 1.4,
        ),
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, dynamic unfavorite) {
    return SizedBox(
      width: 80,
      child: Center(
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.green.shade400,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            icon: const Icon(Icons.remove_red_eye, color: Colors.white, size: 18),
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BiodataDetailPage(
                    biodataId: unfavorite.bioUser,
                    biodataNumber: '${unfavorite.bioId}',
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
