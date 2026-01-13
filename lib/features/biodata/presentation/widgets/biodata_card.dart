import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/extensions.dart';
import '../../domain/entities/biodata_entity.dart';

class BiodataCard extends StatelessWidget {
  final BiodataEntity biodata;
  final VoidCallback onTap;
  final VoidCallback? onLike;
  final bool isLiked;
  
  const BiodataCard({
    super.key,
    required this.biodata,
    required this.onTap,
    this.onLike,
    this.isLiked = false,
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
  
  String _formatHeight(double heightInCm) {
    final feet = (heightInCm / 30.48).floor();
    final inches = ((heightInCm % 30.48) / 2.54).round();
    return '$feet\' $inches\"';
  }
  
  String _getBiodataNumber() {
    final prefix = biodata.gender == 'মহিলা' ? 'PNCF-' : 'PNCM-';
    return '$prefix${biodata.userIdNumber ?? biodata.userId}';
  }
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header with gradient and avatar
            Container(
              height: 140,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: biodata.gender == 'মহিলা'
                      ? [const Color(0xFFFF6B9D), const Color(0xFFC2185B)]
                      : [const Color(0xFF1976D2), const Color(0xFF0D47A1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Stack(
                children: [
                  // Gender Icon
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          biodata.gender == 'মহিলা'
                              ? Icons.female
                              : Icons.male,
                          size: 50,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'বায়োডাটা নং',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          _getBiodataNumber(),
                          style: context.textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // View Count
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.visibility, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '${biodata.viewsCount ?? 0}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Like Button
                  if (onLike != null)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        onPressed: onLike,
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : Colors.white,
                        ),
                      ),
                    ),
                  // Featured Badge
                  if (biodata.isFeatured == true)
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'ফিচারড',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Details
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  _buildInfoRow(
                    'জন্মসন',
                    '${DateFormat('dd/MM/yyyy').format(biodata.dateOfBirth)} [${_calculateAge(biodata.dateOfBirth)} বছর]',
                  ),
                  const Divider(height: 16),
                  _buildInfoRow(
                    'উচ্চতা',
                    _formatHeight(biodata.height),
                  ),
                  const Divider(height: 16),
                  _buildInfoRow(
                    'গাত্রবর্ন',
                    biodata.screenColor,
                  ),
                  const Divider(height: 16),
                  _buildInfoRow(
                    'এলাকা',
                    biodata.upzilla ?? 'N/A',
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('সম্পূর্ন বায়োডাটা'),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
