import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
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
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFF1976D2), const Color(0xFF42A5F5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Stack(
                children: [
                  // Gender Avatar
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.2),
                          ),
                          child: SvgPicture.asset(
                            biodata.gender == 'মহিলা'
                                ? 'assets/img/female.svg'
                                : 'assets/img/male.svg',
                            // colorFilter: const ColorFilter.mode(
                            //   Colors.white,
                            //   BlendMode.srcIn,
                            // ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'বায়োডাটা নং',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              _getBiodataNumber(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
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
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  _buildInfoRow(
                    'জন্মসন',
                    '${DateFormat('dd/MM/yyyy').format(biodata.dateOfBirth)} [${_calculateAge(biodata.dateOfBirth)} বছর]',
                  ),
                  const Divider(height: 12),
                  _buildInfoRow(
                    'উচ্চতা',
                    _formatHeight(biodata.height),
                  ),
                  const Divider(height: 12),
                  _buildInfoRow(
                    'গাত্রবর্ন',
                    biodata.screenColor,
                  ),
                  const Divider(height: 12),
                  _buildInfoRow(
                    'এলাকা',
                    biodata.maritalStatus,
                  ),
                ],
              ),
            ),
            // View Button
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('সম্পূর্ণ বায়োডাটা'),
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
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}
