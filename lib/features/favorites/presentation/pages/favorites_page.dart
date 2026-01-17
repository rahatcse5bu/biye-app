import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/favorites_provider.dart';
import '../../../biodata/presentation/pages/biodata_detail_page.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('পছন্দের তালিকা'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(favoritesProvider);
          ref.invalidate(likedByProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Section 1: My Favorites (আমার পছন্দসমূহ)
              _buildMyFavoritesSection(context, ref),
              
              const SizedBox(height: 24),
              
              // Section 2: Who Liked Me (আমার বায়োডাটা বাদ পছন্দের তালিকায় রয়েছে?)
              _buildLikedBySection(context, ref),
              
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // Section 1: My Favorites
  Widget _buildMyFavoritesSection(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoritesProvider);

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
              color: AppTheme.primaryColor.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.favorite, color: Colors.red.shade400, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'আমার পছন্দসমূহ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          favoritesAsync.when(
            data: (favorites) => _buildFavoritesList(context, favorites, ref),
            loading: () => const Padding(
              padding: EdgeInsets.all(32.0),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stack) => _buildErrorState(context, ref, 'favorites'),
          ),
        ],
      ),
    );
  }

  // Section 2: Liked By Me
  Widget _buildLikedBySection(BuildContext context, WidgetRef ref) {
    final likedByAsync = ref.watch(likedByProvider);

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
              color: Colors.orange.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.thumb_up, color: Colors.orange.shade400, size: 20),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'আমার বায়োডাটা বাদ পছন্দের তালিকায় রয়েছে?',
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
          likedByAsync.when(
            data: (likedBy) => _buildLikedByList(context, likedBy, ref),
            loading: () => const Padding(
              padding: EdgeInsets.all(32.0),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stack) => _buildErrorState(context, ref, 'likedBy'),
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
              if (type == 'favorites') {
                ref.invalidate(favoritesProvider);
              } else {
                ref.invalidate(likedByProvider);
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

  Widget _buildFavoritesList(BuildContext context, dynamic favorites, WidgetRef ref) {
    if (favorites.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.favorite_outline, size: 32, color: Colors.blue.shade400),
            ),
            const SizedBox(height: 12),
            const Text(
              'কোনো পছন্দের তালিকা নেই',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'আপনার পছন্দের বায়োডাটা এখানে দেখা যাবে',
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
            'মোট পছন্দ: ${favorites.length}',
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
            itemCount: favorites.length,
            separatorBuilder: (_, __) => const Divider(height: 1, color: Colors.grey),
            itemBuilder: (context, index) => _buildTableRow(
              context,
              index + 1,
              favorites[index],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLikedByList(BuildContext context, dynamic likedBy, WidgetRef ref) {
    if (likedBy.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.thumb_up, size: 32, color: Colors.orange.shade400),
            ),
            const SizedBox(height: 12),
            const Text(
              'কেউ আপনাকে পছন্দ করেনি',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'যারা আপনাকে পছন্দ করবে তারা এখানে দেখা যাবে',
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
            'মোট লাইক: ${likedBy.length}',
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
            itemCount: likedBy.length,
            separatorBuilder: (_, __) => const Divider(height: 1, color: Colors.grey),
            itemBuilder: (context, index) => _buildTableRow(
              context,
              index + 1,
              likedBy[index],
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

  Widget _buildHeaderCell(String text, double flex) {
    return Expanded(
      flex: (flex * 100).toInt(),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppTheme.primaryColor,
        ),
        overflow: TextOverflow.ellipsis,
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

  Widget _buildTableRow(BuildContext context, int sl, dynamic favorite) {
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
              _buildCellFixed('${favorite.bioId}', 100),
              _buildCellFixed(favorite.formattedDOB, 110),
              _buildCellFixed(favorite.permanentAddress, 200),
              _buildCellFixed('4', 100),  // Contact points - placeholder
              _buildCellFixed('0.00%', 100),  // Approval % - placeholder
              _buildCellFixed('0.00%', 100),  // Recommendation % - placeholder
              _buildCellFixed('4', 100),  // Favorites count - placeholder
              _buildActionButton(context, favorite),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCell(String text, double flex) {
    return Expanded(
      flex: (flex * 100).toInt(),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black87,
          height: 1.4,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
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

  Widget _buildActionButton(BuildContext context, dynamic favorite) {
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
                    biodataId: favorite.bioUser,
                    biodataNumber: '${favorite.bioId}',
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
