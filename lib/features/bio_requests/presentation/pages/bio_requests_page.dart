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
              child: _buildRequestsTable(context, requests, ref),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestsTable(BuildContext context, List requests, WidgetRef ref) {
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
                      _buildBioDetailsButton(context, request.bioDetails, request, ref, 100),
                      _buildFeedbackButton(context, request.feedback, 100),
                      _buildActionButtons(context, request, ref),
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

  Widget _buildBioDetailsButton(BuildContext context, String bioDetails, dynamic request, WidgetRef ref, double width) {
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
              _showBioDetailsDialog(context, bioDetails, request, ref);
            },
          ),
        ),
      ),
    );
  }

  void _showBioDetailsDialog(BuildContext context, String bioDetails, dynamic request, WidgetRef ref) {
    if (bioDetails.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          title: const Text('প্রশ্ন ও উত্তর'),
          content: const Text('কোনো প্রশ্ন ও উত্তর নেই'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('বন্ধ করুন'),
            ),
          ],
        ),
      );
      return;
    }

    // Parse the bio details format: ===question_0==question===answer_0==answer
    final qaList = _parseBioDetails(bioDetails);

    showDialog(
      context: context,
      builder: (context) => _BioDetailsDialogContent(
        qaList: qaList,
        request: request,
        ref: ref,
        isPending: request.status.toLowerCase() == 'pending',
      ),
    );
  }

  List<Map<String, String>> _parseBioDetails(String bioDetails) {
    final List<Map<String, String>> qaList = [];
    
    // Split by ===question_ to get each Q&A pair
    final parts = bioDetails.split('===question_');
    
    for (var i = 1; i < parts.length; i++) {
      final part = parts[i];
      
      // Extract question number and content
      final questionMatch = RegExp(r'^\d+==(.+?)===answer_\d+==(.+?)(?===question_|$)').firstMatch(part);
      
      if (questionMatch != null) {
        qaList.add({
          'question': questionMatch.group(1)?.trim() ?? '',
          'answer': questionMatch.group(2)?.trim() ?? '',
        });
      }
    }
    
    return qaList;
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
                  insetPadding: const EdgeInsets.symmetric(horizontal: 16),
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

  Widget _buildActionButtons(BuildContext context, dynamic request, WidgetRef ref) {
    final isPending = request.status.toLowerCase() == 'pending';
    
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
              color: isPending ? Colors.green.shade400 : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(6),
            ),
            child: IconButton(
              icon: Icon(Icons.check, color: isPending ? Colors.white : Colors.grey, size: 16),
              padding: EdgeInsets.zero,
              onPressed: isPending ? () => _showApproveRejectDialog(context, request, ref, true) : null,
            ),
          ),
          // Reject Button
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isPending ? Colors.red.shade400 : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(6),
            ),
            child: IconButton(
              icon: Icon(Icons.close, color: isPending ? Colors.white : Colors.grey, size: 16),
              padding: EdgeInsets.zero,
              onPressed: isPending ? () => _showApproveRejectDialog(context, request, ref, false) : null,
            ),
          ),
        ],
      ),
    );
  }

  void _showApproveRejectDialog(BuildContext context, dynamic request, WidgetRef ref, bool isApprove) {
    showDialog(
      context: context,
      builder: (context) => _ApproveRejectDialogContent(
        request: request,
        ref: ref,
        isApprove: isApprove,
      ),
    );
  }
}

// Bio Details Dialog with Q&A and Approve/Reject
class _BioDetailsDialogContent extends StatefulWidget {
  final List<Map<String, String>> qaList;
  final dynamic request;
  final WidgetRef ref;
  final bool isPending;

  const _BioDetailsDialogContent({
    required this.qaList,
    required this.request,
    required this.ref,
    required this.isPending,
  });

  @override
  State<_BioDetailsDialogContent> createState() => _BioDetailsDialogContentState();
}

class _BioDetailsDialogContentState extends State<_BioDetailsDialogContent> {
  final _feedbackController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  Future<void> _handleAction(bool isApprove) async {
    setState(() => _isSubmitting = true);

    final dataSource = widget.ref.read(bioRequestsRemoteDataSourceProvider);
    final success = await dataSource.updateBioRequestStatus(
      userId: widget.request.user,
      status: isApprove ? 'approved' : 'rejected',
      feedback: _feedbackController.text.trim(),
    );

    setState(() => _isSubmitting = false);

    if (mounted) {
      Navigator.pop(context);
      if (success) {
        widget.ref.invalidate(bioRequestsProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isApprove ? 'অনুমোদন সফল হয়েছে' : 'প্রত্যাখ্যান সফল হয়েছে'),
            backgroundColor: isApprove ? Colors.green : Colors.red,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('কিছু ভুল হয়েছে, আবার চেষ্টা করুন'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: const Text('প্রশ্ন ও উত্তর'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.qaList.isEmpty)
                const Text('কোনো প্রশ্ন ও উত্তর নেই')
              else
                ...widget.qaList.asMap().entries.map((entry) {
                  final index = entry.key;
                  final qa = entry.value;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    qa['question'] ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: Colors.grey.shade300),
                                    ),
                                    child: Text(
                                      qa['answer'] ?? '',
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              if (widget.isPending) ...[
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 8),
                const Text(
                  'ফিডব্যাক (ঐচ্ছিক):',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _feedbackController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'ফিডব্যাক লিখুন...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSubmitting ? null : () => Navigator.pop(context),
          child: const Text('বন্ধ করুন'),
        ),
        if (widget.isPending) ...[
          ElevatedButton(
            onPressed: _isSubmitting ? null : () => _handleAction(false),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: _isSubmitting
                ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Text('প্রত্যাখ্যান'),
          ),
          ElevatedButton(
            onPressed: _isSubmitting ? null : () => _handleAction(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: _isSubmitting
                ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Text('অনুমোদন'),
          ),
        ],
      ],
    );
  }
}

// Approve/Reject Dialog
class _ApproveRejectDialogContent extends StatefulWidget {
  final dynamic request;
  final WidgetRef ref;
  final bool isApprove;

  const _ApproveRejectDialogContent({
    required this.request,
    required this.ref,
    required this.isApprove,
  });

  @override
  State<_ApproveRejectDialogContent> createState() => _ApproveRejectDialogContentState();
}

class _ApproveRejectDialogContentState extends State<_ApproveRejectDialogContent> {
  final _feedbackController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    setState(() => _isSubmitting = true);

    final dataSource = widget.ref.read(bioRequestsRemoteDataSourceProvider);
    final success = await dataSource.updateBioRequestStatus(
      userId: widget.request.user,
      status: widget.isApprove ? 'approved' : 'rejected',
      feedback: _feedbackController.text.trim(),
    );

    setState(() => _isSubmitting = false);

    if (mounted) {
      Navigator.pop(context);
      if (success) {
        widget.ref.invalidate(bioRequestsProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.isApprove ? 'অনুমোদন সফল হয়েছে' : 'প্রত্যাখ্যান সফল হয়েছে'),
            backgroundColor: widget.isApprove ? Colors.green : Colors.red,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('কিছু ভুল হয়েছে, আবার চেষ্টা করুন'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Row(
        children: [
          Icon(
            widget.isApprove ? Icons.check_circle : Icons.cancel,
            color: widget.isApprove ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 8),
          Text(widget.isApprove ? 'অনুমোদন করুন' : 'প্রত্যাখ্যান করুন'),
        ],
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.isApprove
                  ? 'আপনি কি এই বায়োডাটা অনুরোধ অনুমোদন করতে চান?'
                  : 'আপনি কি এই বায়োডাটা অনুরোধ প্রত্যাখ্যান করতে চান?',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            const Text(
              'ফিডব্যাক (ঐচ্ছিক):',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _feedbackController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'ফিডব্যাক লিখুন...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSubmitting ? null : () => Navigator.pop(context),
          child: const Text('বাতিল'),
        ),
        ElevatedButton(
          onPressed: _isSubmitting ? null : _handleSubmit,
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.isApprove ? Colors.green : Colors.red,
            foregroundColor: Colors.white,
          ),
          child: _isSubmitting
              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
              : Text(widget.isApprove ? 'অনুমোদন' : 'প্রত্যাখ্যান'),
        ),
      ],
    );
  }
}
