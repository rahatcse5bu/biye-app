import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/models/reaction_model.dart';
import '../providers/reactions_provider.dart';
import '../../../biodata/presentation/pages/biodata_detail_page.dart';

class MyReactionsPage extends ConsumerStatefulWidget {
  const MyReactionsPage({super.key});

  @override
  ConsumerState<MyReactionsPage> createState() => _MyReactionsPageState();
}

class _MyReactionsPageState extends ConsumerState<MyReactionsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ReactionType? _selectedReactionType;

  final List<Map<String, dynamic>> reactionTabs = [
    {'label': 'সব', 'value': null, 'icon': Icons.all_inclusive},
    {'label': 'লাইক', 'value': ReactionType.like, 'icon': Icons.thumb_up},
    {'label': 'ডিসলাইক', 'value': ReactionType.dislike, 'icon': Icons.thumb_down},
    {'label': 'ভালোবাসা', 'value': ReactionType.love, 'icon': Icons.favorite},
    {'label': 'দুঃখিত', 'value': ReactionType.sad, 'icon': Icons.sentiment_dissatisfied},
    {'label': 'রাগ', 'value': ReactionType.angry, 'icon': Icons.sentiment_very_dissatisfied},
    {'label': 'বিস্ময়', 'value': ReactionType.wow, 'icon': Icons.sentiment_very_satisfied},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: reactionTabs.length, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _selectedReactionType = reactionTabs[_tabController.index]['value'];
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Color _getReactionColor(ReactionType type) {
    switch (type) {
      case ReactionType.like:
        return AppTheme.primaryColor;
      case ReactionType.dislike:
        return Colors.grey;
      case ReactionType.love:
        return AppTheme.secondaryColor;
      case ReactionType.sad:
        return Colors.blue;
      case ReactionType.angry:
        return Colors.red;
      case ReactionType.wow:
        return Colors.amber;
    }
  }

  IconData _getReactionIcon(ReactionType type) {
    switch (type) {
      case ReactionType.like:
        return Icons.thumb_up;
      case ReactionType.dislike:
        return Icons.thumb_down;
      case ReactionType.love:
        return Icons.favorite;
      case ReactionType.sad:
        return Icons.sentiment_dissatisfied;
      case ReactionType.angry:
        return Icons.sentiment_very_dissatisfied;
      case ReactionType.wow:
        return Icons.sentiment_very_satisfied;
    }
  }

  String _getReactionLabel(ReactionType type) {
    switch (type) {
      case ReactionType.like:
        return 'লাইক';
      case ReactionType.dislike:
        return 'ডিসলাইক';
      case ReactionType.love:
        return 'ভালোবাসা';
      case ReactionType.sad:
        return 'দুঃখিত';
      case ReactionType.angry:
        return 'রাগ';
      case ReactionType.wow:
        return 'বিস্ময়';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('আমার রিঅ্যাকশনসমূহ'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: reactionTabs.map((tab) {
            return Tab(
              child: Row(
                children: [
                  Icon(tab['icon'], size: 16.sp),
                  SizedBox(width: 4.w),
                  Text(tab['label'], style: TextStyle(fontSize: 12.sp)),
                ],
              ),
            );
          }).toList(),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(myReactionsProvider(_selectedReactionType));
          ref.invalidate(reactionsReceivedProvider(_selectedReactionType));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Section 1: My Reactions
              _buildMyReactionsSection(context, ref),
              
              SizedBox(height: 24.h),
              
              // Section 2: Reactions Received
              _buildReactionsReceivedSection(context, ref),
              
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMyReactionsSection(BuildContext context, WidgetRef ref) {
    final myReactionsAsync = ref.watch(myReactionsProvider(_selectedReactionType));

    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
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
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.add_reaction, color: AppTheme.primaryColor, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  'আমি যে বায়োডাটাতে রিঅ্যাক্ট করেছি',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          myReactionsAsync.when(
            data: (reactions) => _buildReactionsList(context, reactions, ref, false),
            loading: () => Padding(
              padding: EdgeInsets.all(32.w),
              child: const Center(child: CircularProgressIndicator()),
            ),
            error: (error, stack) => _buildErrorState(context, error.toString()),
          ),
        ],
      ),
    );
  }

  Widget _buildReactionsReceivedSection(BuildContext context, WidgetRef ref) {
    final reactionsReceivedAsync = ref.watch(reactionsReceivedProvider(_selectedReactionType));

    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
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
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppTheme.secondaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.emoji_emotions, color: AppTheme.secondaryColor, size: 20.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'আমার বায়োডাটায় যারা রিঅ্যাক্ট করেছে',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  'এটি প্রিমিয়াম ফিচার! এই তথ্য দেখতে হলে ৫০ পয়েন্ট খরচ হবে',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          reactionsReceivedAsync.when(
            data: (reactions) => _buildReactionsList(context, reactions, ref, true),
            loading: () => Padding(
              padding: EdgeInsets.all(32.w),
              child: const Center(child: CircularProgressIndicator()),
            ),
            error: (error, stack) => _buildErrorState(context, error.toString()),
          ),
        ],
      ),
    );
  }

  Widget _buildReactionsList(BuildContext context, List<ReactionModel> reactions, WidgetRef ref, bool isReceived) {
    if (reactions.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(32.w),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.sentiment_neutral, size: 48.sp, color: Colors.grey[400]),
              SizedBox(height: 8.h),
              Text(
                'কোন রিঅ্যাকশন পাওয়া যায়নি',
                style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reactions.length,
      separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey[200]),
      itemBuilder: (context, index) {
        final reaction = reactions[index];
        return _buildReactionItem(context, reaction, ref);
      },
    );
  }

  String _getReactionEmoji(ReactionType type) {
    switch (type) {
      case ReactionType.like:
        return '👍';
      case ReactionType.dislike:
        return '👎';
      case ReactionType.love:
        return '❤️';
      case ReactionType.sad:
        return '😢';
      case ReactionType.angry:
        return '😠';
      case ReactionType.wow:
        return '😮';
    }
  }

  Widget _buildReactionItem(BuildContext context, ReactionModel reaction, WidgetRef ref) {
    final bioId = reaction.bioId ?? 0;
    final address = reaction.permanentAddress ?? '';
    final screenColor = reaction.screenColor ?? '';
    
    return InkWell(
      onTap: () {
        if (reaction.bioUser != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BiodataDetailPage(
                biodataId: reaction.bioUser!,
                biodataNumber: bioId.toString(),
              ),
            ),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            // Reaction Emoji
            Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                color: _getReactionColor(reaction.reactionType).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  _getReactionEmoji(reaction.reactionType),
                  style: TextStyle(fontSize: 22.sp),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            // Biodata Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'বায়োডাটা নং: $bioId',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  if (address.isNotEmpty) ...[
                    SizedBox(height: 2.h),
                    Text(
                      address,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        _getReactionEmoji(reaction.reactionType),
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        _getReactionLabel(reaction.reactionType),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: _getReactionColor(reaction.reactionType),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (screenColor.isNotEmpty) ...[
                        SizedBox(width: 8.w),
                        Text('•', style: TextStyle(color: Colors.grey[400])),
                        SizedBox(width: 8.w),
                        Text(
                          screenColor,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            // Arrow Icon
            Icon(Icons.chevron_right, color: Colors.grey[400], size: 20.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String error) {
    return Padding(
      padding: EdgeInsets.all(32.w),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.error_outline, size: 48.sp, color: Colors.red[300]),
            SizedBox(height: 8.h),
            Text(
              'কিছু ভুল হয়েছে',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              error,
              style: TextStyle(color: Colors.grey[500], fontSize: 12.sp),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes} মিনিট আগে';
      }
      return '${difference.inHours} ঘন্টা আগে';
    } else if (difference.inDays == 1) {
      return 'গতকাল';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} দিন আগে';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
