import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/models/reaction_model.dart';
import '../providers/reactions_provider.dart';

class ReactionButton extends ConsumerWidget {
  final String bioUserId;
  final double? iconSize;
  final bool showCounts;

  const ReactionButton({
    Key? key,
    required this.bioUserId,
    this.iconSize = 24.0,
    this.showCounts = true,
  }) : super(key: key);

  String _getReactionEmoji(ReactionType type) {
    switch (type) {
      case ReactionType.like:
        return '👍'; // Thumbs up
      case ReactionType.dislike:
        return '👎'; // Thumbs down
      case ReactionType.love:
        return '❤️'; // Red heart
      case ReactionType.sad:
        return '😢'; // Crying face
      case ReactionType.angry:
        return '😠'; // Angry face
      case ReactionType.wow:
        return '😮'; // Astonished face
    }
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
        return const Color(0xFFF3A712); // Facebook sad yellow
      case ReactionType.angry:
        return const Color(0xFFF4803C); // Facebook angry orange
      case ReactionType.wow:
        return const Color(0xFFF3C907); // Facebook wow yellow
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

  void _showReactionPicker(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'একটি রিঅ্যাকশন নির্বাচন করুন',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 1.2,
              ),
              itemCount: ReactionType.values.length,
              itemBuilder: (context, index) {
                final reactionType = ReactionType.values[index];
                return InkWell(
                  onTap: () {
                    ref.read(reactionNotifierProvider(bioUserId).notifier)
                        .toggleReaction(reactionType);
                    Navigator.pop(context);
                  },
                  borderRadius: BorderRadius.circular(12.r),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _getReactionEmoji(reactionType),
                          style: TextStyle(fontSize: 32.sp),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          _getReactionLabel(reactionType),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reactionState = ref.watch(reactionNotifierProvider(bioUserId));

    if (reactionState.isLoading) {
      return SizedBox(
        width: iconSize,
        height: iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
        ),
      );
    }

    final currentReaction = reactionState.currentReaction;
    final counts = reactionState.counts;

    // Get top 3 reactions by count
    final topReactions = [...counts]..sort((a, b) => b.count.compareTo(a.count));
    final displayReactions = topReactions.take(3).toList();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Main reaction button
        InkWell(
          onTap: () => _showReactionPicker(context, ref),
          borderRadius: BorderRadius.circular(20.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: currentReaction != null 
                  ? _getReactionColor(currentReaction.reactionType).withOpacity(0.1)
                  : Colors.grey[100],
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: currentReaction != null
                    ? _getReactionColor(currentReaction.reactionType)
                    : Colors.grey[300]!,
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  currentReaction != null
                      ? _getReactionEmoji(currentReaction.reactionType)
                      : '👍',
                  style: TextStyle(fontSize: iconSize),
                ),
                if (currentReaction != null) ...[
                  SizedBox(width: 6.w),
                  Text(
                    _getReactionLabel(currentReaction.reactionType),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: _getReactionColor(currentReaction.reactionType),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        // Display reaction counts
        if (showCounts && displayReactions.isNotEmpty) ...[
          SizedBox(width: 12.w),
          ...displayReactions.map((reactionCount) {
            return Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _getReactionEmoji(reactionCount.reactionType),
                    style: TextStyle(fontSize: (iconSize ?? 24.0) * 0.6),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '${reactionCount.count}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ],
    );
  }
}
