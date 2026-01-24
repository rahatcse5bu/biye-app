import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/biodata_entity.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../favorites/presentation/providers/favorites_provider.dart';

class BiodataCard extends ConsumerWidget {
  final BiodataEntity biodata;
  final VoidCallback onTap;
  
  const BiodataCard({
    super.key,
    required this.biodata,
    required this.onTap,
  });
  
  String _calculateAge(DateTime birthDate) {
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age.toString();
  }
  
  String _formatHeight(double height) {
    // Height is stored in feet (e.g., 5.2 means 5 feet 2 inches)
    final feet = height.floor();
    final inches = ((height - feet) * 10).round();
    return '$feet\' $inches\"';
  }
  
  String _getBiodataNumber() {
    final prefix = biodata.gender == 'মহিলা' ? 'PNCF-' : 'PNCM-';
    return '$prefix${biodata.userIdNumber ?? biodata.userId}';
  }
  
  String _getZilla() {
    // Check biodata.zilla first
    if (biodata.zilla != null && biodata.zilla!.trim().isNotEmpty) {
      return biodata.zilla!;
    }
    // Then check address.presentZilla
    if (biodata.address?.presentZilla != null && biodata.address!.presentZilla!.trim().isNotEmpty) {
      return biodata.address!.presentZilla!;
    }
    // Then check address.zilla (permanent)
    if (biodata.address?.zilla != null && biodata.address!.zilla!.trim().isNotEmpty) {
      return biodata.address!.zilla!;
    }
    // Check upzilla as fallback (some data might store district here)
    if (biodata.upzilla != null && biodata.upzilla!.trim().isNotEmpty) {
      return biodata.upzilla!;
    }
    if (biodata.address?.presentUpzilla != null && biodata.address!.presentUpzilla!.trim().isNotEmpty) {
      return biodata.address!.presentUpzilla!;
    }
    if (biodata.address?.upzilla != null && biodata.address!.upzilla!.trim().isNotEmpty) {
      return biodata.address!.upzilla!;
    }
    // Check division as last resort
    if (biodata.address?.presentDivision != null && biodata.address!.presentDivision!.trim().isNotEmpty) {
      return biodata.address!.presentDivision!;
    }
    if (biodata.address?.division != null && biodata.address!.division!.trim().isNotEmpty) {
      return biodata.address!.division!;
    }
    return 'N/A';
  }
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final favoriteState = ref.watch(favoriteToggleProvider);
    final status = favoriteState.getStatus(biodata.userId); // 'favorited', 'unfavorited', or null
    final isAuthenticated = authState.maybeWhen(
      authenticated: (_) => true,
      orElse: () => false,
    );

    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with gradient and avatar
            Container(
              height: 95,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primaryColor, AppTheme.primaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Stack(
                children: [
                  // Gender Avatar and Info
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        // Avatar Circle
                        Container(
                          width: 50,
                          height: 50,
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.25),
                          ),
                          child: SvgPicture.asset(
                            biodata.gender == 'মহিলা'
                                ? 'assets/img/female.svg'
                                : 'assets/img/male.svg',
                          ),
                        ),
                        const SizedBox(width: 14),
                        // Biodata Info
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'বায়োডাটা নং',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _getBiodataNumber(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // View Count Badge
                  Positioned(
                    top: 8,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.visibility, size: 15, color: AppTheme.primaryColor),
                          const SizedBox(width: 5),
                          Text(
                            '${biodata.viewsCount ?? 0}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Like/Dislike Buttons (only show when logged in)
                  if (isAuthenticated)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Dislike Button
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: status == 'unfavorited'
                                  ? Colors.red.withOpacity(0.9)
                                  : Colors.white.withOpacity(0.9),
                              shape: BoxShape.circle,
                            ),
                            child: InkWell(
                              onTap: () {
                                _showUnfavoriteDialog(context, ref, status);
                              },
                              child: Icon(
                                status == 'unfavorited' ? Icons.thumb_down : Icons.thumb_down_outlined,
                                color: status == 'unfavorited' ? Colors.white : Colors.grey[700],
                                size: 14,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          // Like Button
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: status == 'favorited'
                                  ? Colors.green.withOpacity(0.9)
                                  : Colors.white.withOpacity(0.9),
                              shape: BoxShape.circle,
                            ),
                            child: InkWell(
                              onTap: () {
                                _showFavoriteDialog(context, ref, status);
                              },
                              child: Icon(
                                status == 'favorited' ? Icons.thumb_up : Icons.thumb_up_outlined,
                                color: status == 'favorited' ? Colors.white : Colors.grey[700],
                                size: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  // Featured Badge
                  if (biodata.isFeatured == true)
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber[400],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'ফিচারড',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Details Section
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
              child: Column(
                children: [
                  _buildInfoRow(
                    'জন্মসন',
                    '${DateFormat('dd/MM/yyyy').format(biodata.dateOfBirth)} [${_calculateAge(biodata.dateOfBirth)}]',
                  ),
                  const SizedBox(height: 6),
                  _buildInfoRow(
                    'উচ্চতা',
                    _formatHeight(biodata.height),
                  ),
                  const SizedBox(height: 6),
                  _buildInfoRow(
                    'গাত্রবর্ন',
                    biodata.screenColor,
                  ),
                  const SizedBox(height: 6),
                  _buildInfoRow(
                    'জেলা',
                    _getZilla(),
                  ),
                ],
              ),
            ),
            // View Button
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
                child: const Text(
                  'সম্পূর্ণ বায়োডাটা',
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
  
  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: Colors.black87,
            ),
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  void _showFavoriteDialog(BuildContext context, WidgetRef ref, String? status) {
    if (status == 'favorited') {
      // Already favorited, do nothing or show message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ইতিমধ্যে পছন্দের তালিকায় আছে'),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        title: const Text('পছন্দের তালিকায় যোগ করুন?'),
        content: const Text('এই বায়োডাটা আপনার পছন্দের তালিকায় যোগ করা হবে।'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('বাতিল'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await ref
                  .read(favoriteToggleProvider.notifier)
                  .addFavorite(biodata.userId);
              
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('পছন্দের তালিকায় যোগ করা হয়েছে'),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: const Text('যোগ করুন'),
          ),
        ],
      ),
    );
  }

  void _showUnfavoriteDialog(BuildContext context, WidgetRef ref, String? status) {
    if (status == 'unfavorited') {
      // Already unfavorited, do nothing or show message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ইতিমধ্যে অপছন্দের তালিকায় আছে'),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        title: const Text('অপছন্দের তালিকায় যোগ করুন?'),
        content: const Text('এই বায়োডাটা আপনার অপছন্দের তালিকায় যোগ করা হবে।'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('বাতিল'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await ref
                  .read(favoriteToggleProvider.notifier)
                  .addUnfavorite(biodata.userId);
              
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('অপছন্দের তালিকায় যোগ করা হয়েছে'),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('যোগ করুন'),
          ),
        ],
      ),
    );
  }
}
