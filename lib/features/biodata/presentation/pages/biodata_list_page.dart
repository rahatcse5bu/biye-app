import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/extensions.dart';
import '../providers/biodata_provider.dart';
import '../providers/biodata_state.dart';
import '../widgets/biodata_card.dart';
import '../widgets/biodata_shimmer.dart';
import 'biodata_detail_page.dart';

class BiodataListPage extends ConsumerStatefulWidget {
  const BiodataListPage({super.key});
  
  @override
  ConsumerState<BiodataListPage> createState() => _BiodataListPageState();
}

class _BiodataListPageState extends ConsumerState<BiodataListPage> {
  bool _isGridView = true;
  
  @override
  void initState() {
    super.initState();
    // Load biodatas on page init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(biodataListNotifierProvider.notifier).loadBiodatas();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final biodataState = ref.watch(biodataListNotifierProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('বায়োডাটা সমূহ'),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog(context);
            },
          ),
        ],
      ),
      body: biodataState.when(
        initial: () => BiodataShimmer(isGridView: _isGridView),
        loading: () => BiodataShimmer(isGridView: _isGridView),
        loaded: (biodatas) {
          if (biodatas.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people_outline,
                    size: 100,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'কোনো বায়োডাটা পাওয়া যায়নি',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'নতুন বায়োডাটা শীঘ্রই যুক্ত হবে',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            );
          }
          
          return RefreshIndicator(
            onRefresh: () async {
              ref.read(biodataListNotifierProvider.notifier).loadBiodatas();
            },
            child: _isGridView
                ? _buildGridView(biodatas)
                : _buildListView(biodatas),
          );
        },
        error: (message) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red[400],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'কিছু সমস্যা হয়েছে',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    ref.read(biodataListNotifierProvider.notifier).loadBiodatas();
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('পুনরায় চেষ্টা করুন'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to create biodata page
          context.showSnackBar('বায়োডাটা তৈরি করুন - Coming Soon!');
        },
        icon: const Icon(Icons.add),
        label: const Text('নতুন বায়োডাটা'),
      ),
    );
  }
  
  Widget _buildGridView(biodatas) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: context.screenWidth > 1200
            ? 4
            : context.screenWidth > 800
                ? 3
                : context.screenWidth > 600
                    ? 2
                    : 1,
        childAspectRatio: 0.65,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: biodatas.length,
      itemBuilder: (context, index) {
        final biodata = biodatas[index];
        return AnimatedScale(
          scale: 1.0,
          duration: Duration(milliseconds: 200 + (index * 50)),
          curve: Curves.easeOut,
          child: BiodataCard(
            biodata: biodata,
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      BiodataDetailPage(biodataId: biodata.id),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;
                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
  
  Widget _buildListView(biodatas) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: biodatas.length,
      itemBuilder: (context, index) {
        final biodata = biodatas[index];
        return AnimatedScale(
          scale: 1.0,
          duration: Duration(milliseconds: 200 + (index * 50)),
          curve: Curves.easeOut,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: BiodataCard(
              biodata: biodata,
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        BiodataDetailPage(biodataId: biodata.id),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;
                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
  
  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ফিল্টার'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('ফিল্টার অপশন শীঘ্রই আসছে...'),
            const SizedBox(height: 16),
            // Add filter options here
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('বন্ধ করুন'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Apply filters
            },
            child: const Text('প্রয়োগ করুন'),
          ),
        ],
      ),
    );
  }
}
