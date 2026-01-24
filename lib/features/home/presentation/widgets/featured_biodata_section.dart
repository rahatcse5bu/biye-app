import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../biodata/presentation/widgets/biodata_card.dart';
import '../../../biodata/presentation/pages/biodata_detail_page.dart';
import '../../../biodata/presentation/pages/biodata_list_page.dart';
import '../providers/home_provider.dart';

class FeaturedBiodataSection extends ConsumerWidget {
  const FeaturedBiodataSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featuredAsync = ref.watch(featuredBiodataProvider);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ফিচারড বায়োডাটা সমূহ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BiodataListPage(),
                      ),
                    );
                  },
                  child: Text(
                    'সব দেখুন →',
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          featuredAsync.when(
            data: (biodatas) {
              if (biodatas.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('কোনো ফিচারড বায়োডাটা নেই'),
                );
              }
              return SizedBox(
                height: 285,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: biodatas.length > 6 ? 6 : biodatas.length,
                  itemBuilder: (context, index) {
                    final biodata = biodatas[index];
                    return Container(
                      width: 180,
                      margin: const EdgeInsets.only(right: 16),
                      child: BiodataCard(
                        biodata: biodata,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BiodataDetailPage(
                                biodataId: biodata.id,
                                biodataNumber: '${biodata.userIdNumber ?? biodata.userId}',
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            },
            loading: () => SizedBox(
              height: 285,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    width: 180,
                    margin: const EdgeInsets.only(right: 16),
                    child: const BiodataCardShimmer(),
                  );
                },
              ),
            ),
            error: (_, __) => const Padding(
              padding: EdgeInsets.all(20),
              child: Text('বায়োডাটা লোড করতে সমস্যা হয়েছে'),
            ),
          ),
        ],
      ),
    );
  }
}

class BiodataCardShimmer extends StatelessWidget {
  const BiodataCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 110,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    height: 14,
                    color: Colors.grey.shade200,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 14,
                    color: Colors.grey.shade200,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 14,
                    color: Colors.grey.shade200,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 14,
                    color: Colors.grey.shade200,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
