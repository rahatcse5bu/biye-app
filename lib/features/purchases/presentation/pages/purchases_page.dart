import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/purchases_provider.dart';
import '../../../biodata/presentation/pages/biodata_detail_page.dart';

class PurchasesPage extends ConsumerWidget {
  const PurchasesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('আমার ক্রয়সমূহ'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(purchasesFirstStepProvider);
          ref.invalidate(purchasesSecondStepProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Section 1: First Step Purchases
              _buildFirstStepSection(context, ref),
              
              const SizedBox(height: 24),
              
              // Section 2: Second Step Purchases
              _buildSecondStepSection(context, ref),
              
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // Section 1: First Step
  Widget _buildFirstStepSection(BuildContext context, WidgetRef ref) {
    final firstStepAsync = ref.watch(purchasesFirstStepProvider);

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
                Icon(Icons.receipt_long, color: AppTheme.primaryColor, size: 20),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'আমার পার্চাস করা বায়োডাটা অনুরোধসমূহ (১ম স্টেপ)',
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
              'এই তালিকায় বিয়াতা এই স্টেপ তথ্য দিবাই হবে তাদের দেখান হবে প্রথম স্টেপে খালি খরচ থাকবে করলেন।',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
            ),
          ),
          firstStepAsync.when(
            data: (purchases) => _buildFirstStepList(context, purchases, ref),
            loading: () => const Padding(
              padding: EdgeInsets.all(32.0),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stack) => _buildErrorState(context, ref, 'firstStep'),
          ),
        ],
      ),
    );
  }

  // Section 2: Second Step
  Widget _buildSecondStepSection(BuildContext context, WidgetRef ref) {
    final secondStepAsync = ref.watch(purchasesSecondStepProvider);

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
              color: Colors.green.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle_outline, color: Colors.green.shade600, size: 20),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'প্রয়োজন ফার্স্ট স্টেপ বায়োডাটা অনুমোদন (২য় স্টেপ)',
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
          secondStepAsync.when(
            data: (purchases) => _buildSecondStepList(context, purchases, ref),
            loading: () => const Padding(
              padding: EdgeInsets.all(32.0),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stack) => _buildErrorState(context, ref, 'secondStep'),
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
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              if (type == 'firstStep') {
                ref.invalidate(purchasesFirstStepProvider);
              } else {
                ref.invalidate(purchasesSecondStepProvider);
              }
            },
            icon: const Icon(Icons.refresh, size: 16),
            label: const Text('পুনরায় চেষ্টা করুন'),
          ),
        ],
      ),
    );
  }

  Widget _buildFirstStepList(BuildContext context, dynamic purchases, WidgetRef ref) {
    if (purchases.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Icon(Icons.shopping_bag_outlined, size: 48, color: Colors.grey.shade400),
            const SizedBox(height: 12),
            const Text(
              'কোনো ক্রয় নেই',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
          _buildFirstStepTable(context, purchases, ref),
        ],
      ),
    );
  }

  Widget _buildSecondStepList(BuildContext context, dynamic purchases, WidgetRef ref) {
    if (purchases.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Icon(Icons.check_circle_outline, size: 48, color: Colors.grey.shade400),
            const SizedBox(height: 12),
            const Text(
              'কোনো দ্বিতীয় ধাপ নেই',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
          _buildSecondStepTable(context, purchases),
        ],
      ),
    );
  }

  Widget _buildFirstStepTable(BuildContext context, List purchases, WidgetRef ref) {
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
                _buildHeaderCell('ঠিকানা', 200),
                _buildHeaderCell('Bio Details', 150),
                _buildHeaderCell('ফিডব্যাক', 150),
                _buildHeaderCell('স্ট্যাটাস', 100),
                _buildHeaderCell('আকশন', 200),
              ],
            ),
          ),
          // Rows
          ...purchases.asMap().entries.map((entry) {
            final index = entry.key;
            final purchase = entry.value;
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
                      _buildCell('${index + 1}', 40),
                      _buildCell('${purchase.bioId}', 100),
                      _buildCell('${purchase.zilla},${purchase.upzilla}', 200),
                      _buildCell('...', 150),
                      _buildFeedbackEditButton(context, purchase, ref, 150),
                      _buildStatusCell(purchase.statusBangla, purchase.statusColor, 100),
                      _buildFirstStepActionButtons(context, purchase, ref),
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

  Widget _buildSecondStepTable(BuildContext context, List purchases) {
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
                _buildHeaderCell('জন্ম তারিখ', 110),
                _buildHeaderCell('ঠিকানা', 200),
                _buildHeaderCell('নাম', 150),
                _buildHeaderCell('পরিবার নম্বর', 120),
                _buildHeaderCell('সম্পর্ক', 100),
                _buildHeaderCell('ইমেইল', 200),
                _buildHeaderCell('আসমান', 80),
              ],
            ),
          ),
          // Rows
          ...purchases.asMap().entries.map((entry) {
            final index = entry.key;
            final purchase = entry.value;
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
                      _buildCell('${index + 1}', 40),
                      _buildCell('${purchase.bioId}', 100),
                      _buildCell(purchase.formattedDOB, 110),
                      _buildCell('${purchase.zilla},${purchase.upzilla}', 200),
                      _buildCell(purchase.fullName, 150),
                      _buildCell(purchase.familyNumber, 120),
                      _buildCell(purchase.relation, 100),
                      _buildCell(purchase.bioReceivingEmail, 200),
                      _buildActionButton(context, purchase),
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

  Widget _buildActionButton(BuildContext context, dynamic purchase) {
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
                    biodataId: purchase.bioUser,
                    biodataNumber: '${purchase.bioId}',
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFirstStepActionButtons(BuildContext context, dynamic purchase, WidgetRef ref) {
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
                      biodataId: purchase.bioUser,
                      biodataNumber: '${purchase.bioId}',
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
              onPressed: () => _handleStatusUpdate(context, ref, purchase.user, 'approved'),
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
              onPressed: () => _handleStatusUpdate(context, ref, purchase.user, 'rejected'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackEditButton(BuildContext context, dynamic purchase, WidgetRef ref, double width) {
    return SizedBox(
      width: width,
      child: GestureDetector(
        onTap: () => _showFeedbackEditDialog(context, purchase, ref),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text(
                  purchase.feedback ?? 'N/A',
                  style: TextStyle(fontSize: 11, color: Colors.blue.shade700),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.edit, size: 12, color: Colors.blue.shade700),
            ],
          ),
        ),
      ),
    );
  }

  void _showFeedbackEditDialog(BuildContext context, dynamic purchase, WidgetRef ref) {
    final TextEditingController feedbackController = TextEditingController(
      text: purchase.feedback ?? '',
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ফিডব্যাক এডিট করুন'),
        content: TextField(
          controller: feedbackController,
          maxLines: 4,
          decoration: const InputDecoration(
            hintText: 'ফিডব্যাক লিখুন...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('বাতিল'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await _handleFeedbackUpdate(
                context,
                ref,
                purchase.user,
                feedbackController.text,
              );
            },
            child: const Text('সেভ করুন'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleFeedbackUpdate(
    BuildContext context,
    WidgetRef ref,
    String userId,
    String feedback,
  ) async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      final dataSource = ref.read(purchasesFirstStepDataSourceProvider);
      final success = await dataSource.updateBioChoiceFeedback(
        userId: userId,
        feedback: feedback,
      );

      // Close loading indicator
      if (context.mounted) {
        Navigator.pop(context);
      }

      if (success) {
        // Refresh the list
        ref.invalidate(purchasesFirstStepProvider);
        
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('ফিডব্যাক আপডেট হয়েছে'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('আপডেট ব্যর্থ হয়েছে'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('একটি ত্রুটি ঘটেছে'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _handleStatusUpdate(
    BuildContext context,
    WidgetRef ref,
    String userId,
    String status,
  ) async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      final dataSource = ref.read(purchasesFirstStepDataSourceProvider);
      final success = await dataSource.updateBioChoiceStatus(
        userId: userId,
        status: status,
      );

      // Close loading indicator
      if (context.mounted) {
        Navigator.pop(context);
      }

      if (success) {
        // Refresh the list
        ref.invalidate(purchasesFirstStepProvider);
        
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                status == 'approved' 
                  ? 'অনুমোদিত হয়েছে' 
                  : 'প্রত্যাখ্যান করা হয়েছে'
              ),
              backgroundColor: status == 'approved' ? Colors.green : Colors.red,
            ),
          );
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('আপডেট ব্যর্থ হয়েছে'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('একটি ত্রুটি ঘটেছে'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
