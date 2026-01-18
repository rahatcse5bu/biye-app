import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/extensions.dart';
import '../providers/biodata_provider.dart';
import '../widgets/biodata_card.dart';
import '../widgets/biodata_shimmer.dart';
import '../widgets/biodata_filter_dialog.dart';
import 'biodata_detail_page.dart';
import '../../domain/entities/biodata_entity.dart';

class BiodataListPage extends ConsumerStatefulWidget {
  const BiodataListPage({super.key});
  
  @override
  ConsumerState<BiodataListPage> createState() => _BiodataListPageState();
}

class _BiodataListPageState extends ConsumerState<BiodataListPage> {
  bool _isGridView = true;
  Map<String, dynamic> _activeFilters = {};
  
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
        backgroundColor: AppTheme.primaryColor,
        title: const Text('বায়োডাটা সমূহ', style:TextStyle(
          color:Colors.white
        )),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.filter_list,color:Colors.white),
                onPressed: () {
                  _showFilterDialog(context);
                },
              ),
              if (_activeFilters.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${_activeFilters.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: biodataState.when(
        initial: () => BiodataShimmer(isGridView: _isGridView),
        loading: () => BiodataShimmer(isGridView: _isGridView),
        loaded: (biodatas) {
          // Apply filters
          final filteredBiodatas = _applyFilters(biodatas);
          
          if (filteredBiodatas.isEmpty) {
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
                    _activeFilters.isEmpty 
                        ? 'কোনো বায়োডাটা পাওয়া যায়নি'
                        : 'ফিল্টার অনুযায়ী কোনো বায়োডাটা পাওয়া যায়নি',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _activeFilters.isEmpty
                        ? 'নতুন বায়োডাটা শীঘ্রই যুক্ত হবে'
                        : 'ফিল্টার পরিবর্তন করে আবার চেষ্টা করুন',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (_activeFilters.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _activeFilters.clear();
                        });
                      },
                      child: const Text('ফিল্টার রিসেট করুন'),
                    ),
                  ],
                ],
              ),
            );
          }
          
          return RefreshIndicator(
            onRefresh: () async {
              ref.read(biodataListNotifierProvider.notifier).loadBiodatas();
            },
            child: _isGridView
                ? _buildGridView(filteredBiodatas)
                : _buildListView(filteredBiodatas),
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
    
    );
  }
  
  Widget _buildGridView(biodatas) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: context.screenWidth > 1200
            ? 4
            : context.screenWidth > 800
                ? 3
                : context.screenWidth > 600
                    ? 2
                    : 1,
        childAspectRatio: 0.65,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
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
                      BiodataDetailPage(
                        biodataId: biodata.id,
                        biodataNumber: '${biodata.userIdNumber ?? biodata.userId}',
                      ),
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
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
      itemCount: biodatas.length,
      itemBuilder: (context, index) {
        final biodata = biodatas[index];
        return AnimatedScale(
          scale: 1.0,
          duration: Duration(milliseconds: 200 + (index * 50)),
          curve: Curves.easeOut,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: BiodataCard(
              biodata: biodata,
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        BiodataDetailPage(
                          biodataId: biodata.id,
                          biodataNumber: '${biodata.userIdNumber ?? biodata.userId}',
                        ),
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
      builder: (context) => BiodataFilterDialog(
        currentFilters: _activeFilters,
        onApplyFilters: (filters) {
          setState(() {
            _activeFilters = filters;
          });
        },
      ),
    );
  }

  List<BiodataEntity> _applyFilters(List<BiodataEntity> biodatas) {
    if (_activeFilters.isEmpty) return biodatas;

    return biodatas.where((biodata) {
      // Gender filter
      if (_activeFilters['gender'] != null) {
        if (biodata.gender != _activeFilters['gender']) return false;
      }

      // Biodata Type filter
      if (_activeFilters['bioType'] != null) {
        if (biodata.bioType != _activeFilters['bioType']) return false;
      }

      // Marital Status filter
      if (_activeFilters['maritalStatus'] != null) {
        if (biodata.maritalStatus != _activeFilters['maritalStatus']) return false;
      }

      // Age Range filter
      if (_activeFilters['minAge'] != null || _activeFilters['maxAge'] != null) {
        final age = _calculateAge(biodata.dateOfBirth);
        if (_activeFilters['minAge'] != null && age < _activeFilters['minAge']) {
          return false;
        }
        if (_activeFilters['maxAge'] != null && age > _activeFilters['maxAge']) {
          return false;
        }
      }

      // Division filter
      if (_activeFilters['division'] != null) {
        if (biodata.address?.division != _activeFilters['division'] &&
            biodata.address?.presentDivision != _activeFilters['division']) {
          return false;
        }
      }

      // Education filter (check if highest level contains the filter value)
      if (_activeFilters['education'] != null) {
        final educationLevel = biodata.educationQualification?.highestEduLevel ?? '';
        if (!educationLevel.contains(_activeFilters['education'])) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  int _calculateAge(DateTime birthDate) {
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }
}
