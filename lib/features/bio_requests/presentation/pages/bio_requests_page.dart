import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/bio_requests_provider.dart';
import '../../../biodata/presentation/pages/biodata_detail_page.dart';

class BioRequestsPage extends ConsumerWidget {
  const BioRequestsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bioRequestsAsync = ref.watch(bioRequestsProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('আমার বায়োডাটা অনুরোধসমূহ'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(bioRequestsProvider);
        },
        child: bioRequestsAsync.when(
          data: (requests) => _buildRequestsList(context, requests, ref),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => _buildErrorState(context, ref),
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.error_outline, size: 48, color: Colors.red.shade400),
            ),
            const SizedBox(height: 16),
            const Text(
              'তালিকা লোড করতে ব্যর্থ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => ref.invalidate(bioRequestsProvider),
              icon: const Icon(Icons.refresh),
              label: const Text('পুনরায় চেষ্টা করুন'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestsList(BuildContext context, List requests, WidgetRef ref) {
    if (requests.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.mail_outline, size: 64, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              const Text(
                'কোনো অনুরোধ নেই',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        margin: const EdgeInsets.all(16),
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
                  Icon(Icons.assignment, color: AppTheme.primaryColor, size: 20),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'আমার কাছে শেয়ার করা বায়োডাটা অনুরোধসমূহ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                'এই তালিকায় আপনার কাছে শেয়ার করা সকল বায়োডাটা অনুরোধ দেখাবে তো আপনাদের প্রতিবাদন করবেই শোরগোল।',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: _buildRequestsTable(context, requests),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestsTable(BuildContext context, List requests) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          // Header
          Container(
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Row(
              children: [
                _buildHeaderCell('SL', 40),
                _buildHeaderCell('বায়োডাটা নং', 100),
                _buildHeaderCell('আবেদন', 200),
                _buildHeaderCell('স্ট্যাটাস', 100),
                _buildHeaderCell('Bio Details', 100),
                _buildHeaderCell('ফিডব্যাক', 100),
                _buildHeaderCell('আসমান', 200),
              ],
            ),
          ),
          // Rows
          ...requests.asMap().entries.map((entry) {
            final index = entry.key;
            final request = entry.value;
            return Column(
              children: [
                if (index > 0) const Divider(height: 1),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  child: Row(
                    children: [
                      _buildCell('$index', 40),
                      _buildCell('${request.userId}', 100),
                      _buildCell(request.presentAddress, 200),
                      _buildStatusCell(request.statusBangla, request.statusColor, 100),
                      _buildBioDetailsButton(context, request.bioDetails, 100),
                      _buildFeedbackButton(context, request.feedback, 100),
                      _buildActionButtons(context, request),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text, double width) {
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
      ),
    );
  }

  Widget _buildCell(String text, double width) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        style: const TextStyle(fontSize: 11, color: Colors.black87),
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildStatusCell(String status, Color color, double width) {
    return SizedBox(
      width: width,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          status,
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: color),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildBioDetailsButton(BuildContext context, String bioDetails, double width) {
    return SizedBox(
      width: width,
      child: Center(
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.blue.shade400,
            borderRadius: BorderRadius.circular(6),
          ),
          child: IconButton(
            icon: const Icon(Icons.article_outlined, color: Colors.white, size: 16),
            padding: EdgeInsets.zero,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Bio Details'),
                  content: SingleChildScrollView(
                    child: Text(bioDetails.isEmpty ? 'কোনো বিস্তারিত তথ্য নেই' : bioDetails),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('বন্ধ করুন'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFeedbackButton(BuildContext context, String? feedback, double width) {
    return SizedBox(
      width: width,
      child: Center(
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(6),
          ),
          child: IconButton(
            icon: const Icon(Icons.message, color: Colors.white, size: 16),
            padding: EdgeInsets.zero,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('ফিডব্যাক'),
                  content: Text(feedback ?? 'কোনো ফিডব্যাক নেই'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('বন্ধ করুন'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, dynamic request) {
    return SizedBox(
      width: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // View Button
          Container(
            width: 36,
            height: 36,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.blue.shade400,
              borderRadius: BorderRadius.circular(6),
            ),
            child: IconButton(
              icon: const Icon(Icons.remove_red_eye, color: Colors.white, size: 16),
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BiodataDetailPage(
                      biodataId: request.user,
                      biodataNumber: '${request.userId}',
                    ),
                  ),
                );
              },
            ),
          ),
          // Approve Button
          Container(
            width: 36,
            height: 36,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.green.shade400,
              borderRadius: BorderRadius.circular(6),
            ),
            child: IconButton(
              icon: const Icon(Icons.check, color: Colors.white, size: 16),
              padding: EdgeInsets.zero,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('অনুমোদন - শীঘ্রই আসছে')),
                );
              },
            ),
          ),
          // Reject Button
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.red.shade400,
              borderRadius: BorderRadius.circular(6),
            ),
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 16),
              padding: EdgeInsets.zero,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('প্রত্যাখ্যান - শীঘ্রই আসছে')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
