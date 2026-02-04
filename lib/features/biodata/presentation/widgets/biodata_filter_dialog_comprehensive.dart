import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/services/address_service.dart';

class ComprehensiveBiodataFilterDialog extends StatefulWidget {
  final Map<String, dynamic> currentFilters;
  final Function(Map<String, dynamic>) onApplyFilters;

  const ComprehensiveBiodataFilterDialog({
    super.key,
    required this.currentFilters,
    required this.onApplyFilters,
  });

  @override
  State<ComprehensiveBiodataFilterDialog> createState() =>
      _ComprehensiveBiodataFilterDialogState();
}

class _ComprehensiveBiodataFilterDialogState
    extends State<ComprehensiveBiodataFilterDialog> {
  late Map<String, dynamic> _filters;
  final _permanentAddressController = TextEditingController();

  // Age range
  RangeValues _ageRange = const RangeValues(18, 60);

  // Height range (in feet, converted to cm for API)
  RangeValues _heightRange = const RangeValues(5.0, 7.0);

  // Address selections - Multi-select sets
  Set<String> _selectedDivisions = {};
  Set<String> _selectedDistricts = {};
  Set<String> _selectedUpazilas = {};
  Set<String> _selectedPresentDivisions = {};
  Set<String> _selectedPresentDistricts = {};
  Set<String> _selectedPresentUpazilas = {};

  // Multi-select sets
  Set<String> _selectedEducationMedium = {};
  Set<String> _selectedDeeniEdu = {};
  Set<String> _selectedComplexion = {};
  Set<String> _selectedFiqh = {};
  Set<String> _selectedOccupation = {};
  Set<String> _selectedEconomicStatus = {};
  Set<String> _selectedCategories = {};

  // Religion filter
  String? _selectedReligion;
  String? _selectedReligiousType;

  // Address service
  final AddressService _addressService = AddressService.instance;
  bool _isAddressDataLoaded = false;

  // Location data (loaded from JSON)
  List<String> _divisions = [];
  List<String> _currentDistricts = [];
  List<String> _currentUpazilas = [];
  List<String> _presentDistricts = [];
  List<String> _presentUpazilas = [];

  @override
  void initState() {
    super.initState();
    _filters = Map.from(widget.currentFilters);
    _loadAddressData();
  }

  Future<void> _loadAddressData() async {
    await _addressService.loadData();
    setState(() {
      _divisions = _addressService.getDivisions();
      _isAddressDataLoaded = true;
    });
    _initializeFromFilters();
  }

  void _updateDistrictsForDivisions(
    Set<String> divisions, {
    bool isPresent = false,
  }) {
    if (divisions.isEmpty) {
      setState(() {
        if (isPresent) {
          _presentDistricts = [];
        } else {
          _currentDistricts = [];
        }
      });
      return;
    }

    // Combine districts from all selected divisions
    final Set<String> allDistricts = {};
    for (final division in divisions) {
      final districts = _addressService.getDistrictsByDivision(division);
      allDistricts.addAll(districts);
    }

    setState(() {
      if (isPresent) {
        _presentDistricts = allDistricts.toList()..sort();
      } else {
        _currentDistricts = allDistricts.toList()..sort();
      }
    });
  }

  void _updateUpazilasForDistricts(
    Set<String> districts, {
    bool isPresent = false,
  }) {
    if (districts.isEmpty) {
      setState(() {
        if (isPresent) {
          _presentUpazilas = [];
        } else {
          _currentUpazilas = [];
        }
      });
      return;
    }

    // Combine upazilas from all selected districts
    final Set<String> allUpazilas = {};
    for (final district in districts) {
      final upazilas = _addressService.getUpazilasByDistrict(district);
      allUpazilas.addAll(upazilas);
    }

    setState(() {
      if (isPresent) {
        _presentUpazilas = allUpazilas.toList()..sort();
      } else {
        _currentUpazilas = allUpazilas.toList()..sort();
      }
    });
  }

  void _initializeFromFilters() {
    // Initialize from existing filters
    if (_filters['minAge'] != null)
      _ageRange = RangeValues(
        (_filters['minAge'] as num).toDouble(),
        _ageRange.end,
      );
    if (_filters['maxAge'] != null)
      _ageRange = RangeValues(
        _ageRange.start,
        (_filters['maxAge'] as num).toDouble(),
      );

    // Height is in feet format (e.g., 5.1 means 5 feet 1 inch)
    if (_filters['minHeight'] != null)
      _heightRange = RangeValues(
        (_filters['minHeight'] as num).toDouble(),
        _heightRange.end,
      );
    if (_filters['maxHeight'] != null)
      _heightRange = RangeValues(
        _heightRange.start,
        (_filters['maxHeight'] as num).toDouble(),
      );

    // Initialize permanent address selections (comma-separated values) and load cascading data
    if (_filters['division'] != null &&
        _filters['division'].toString().isNotEmpty) {
      _selectedDivisions = _filters['division'].toString().split(',').toSet();
      _updateDistrictsForDivisions(_selectedDivisions, isPresent: false);
    }
    if (_filters['zilla'] != null && _filters['zilla'].toString().isNotEmpty) {
      _selectedDistricts = _filters['zilla'].toString().split(',').toSet();
      _updateUpazilasForDistricts(_selectedDistricts, isPresent: false);
    }
    if (_filters['upazila'] != null &&
        _filters['upazila'].toString().isNotEmpty) {
      _selectedUpazilas = _filters['upazila'].toString().split(',').toSet();
    }

    // Initialize present address selections (comma-separated values) and load cascading data
    if (_filters['current_division'] != null &&
        _filters['current_division'].toString().isNotEmpty) {
      _selectedPresentDivisions = _filters['current_division']
          .toString()
          .split(',')
          .toSet();
      _updateDistrictsForDivisions(_selectedPresentDivisions, isPresent: true);
    }
    if (_filters['current_zilla'] != null &&
        _filters['current_zilla'].toString().isNotEmpty) {
      _selectedPresentDistricts = _filters['current_zilla']
          .toString()
          .split(',')
          .toSet();
      _updateUpazilasForDistricts(_selectedPresentDistricts, isPresent: true);
    }
    if (_filters['current_upzilla'] != null &&
        _filters['current_upzilla'].toString().isNotEmpty) {
      _selectedPresentUpazilas = _filters['current_upzilla']
          .toString()
          .split(',')
          .toSet();
    }

    if (_filters['permanent_address'] != null) {
      _permanentAddressController.text = _filters['permanent_address'];
    }

    // Initialize sets
    _selectedEducationMedium = Set.from(_filters['education_medium'] ?? []);
    _selectedDeeniEdu = Set.from(_filters['deeni_edu'] ?? []);
    _selectedComplexion = Set.from(_filters['complexion'] ?? []);
    _selectedFiqh = Set.from(_filters['fiqh'] ?? []);
    _selectedOccupation = Set.from(_filters['occupation'] ?? []);
    _selectedEconomicStatus = Set.from(_filters['economic_status'] ?? []);
    _selectedCategories = Set.from(_filters['categories'] ?? []);

    // Initialize religion filters
    _selectedReligion = _filters['religion'] as String?;
    _selectedReligiousType = _filters['religious_type'] as String?;
  }

  @override
  void dispose() {
    _permanentAddressController.dispose();
    super.dispose();
  }

  void _clearFilters() {
    setState(() {
      _filters.clear();
      _ageRange = const RangeValues(18, 60);
      _heightRange = const RangeValues(5.0, 7.0);
      _permanentAddressController.clear();
      // Clear address multi-select sets
      _selectedDivisions.clear();
      _selectedDistricts.clear();
      _selectedUpazilas.clear();
      _selectedPresentDivisions.clear();
      _selectedPresentDistricts.clear();
      _selectedPresentUpazilas.clear();
      // Clear cascading lists
      _currentDistricts = [];
      _currentUpazilas = [];
      _presentDistricts = [];
      _presentUpazilas = [];
      _selectedEducationMedium.clear();
      _selectedDeeniEdu.clear();
      _selectedComplexion.clear();
      _selectedFiqh.clear();
      _selectedOccupation.clear();
      _selectedEconomicStatus.clear();
      _selectedCategories.clear();
      // Clear religion filters
      _selectedReligion = null;
      _selectedReligiousType = null;
    });
  }

  void _applyFilters() {
    // Build filter map
    final filters = <String, dynamic>{};

    // Basic filters
    if (_filters['bioType'] != null) filters['bio_type'] = _filters['bioType'];
    if (_filters['maritalStatus'] != null)
      filters['marital_status'] = _filters['maritalStatus'];

    // Permanent address - use comma-separated values for multi-select
    if (_selectedDivisions.isNotEmpty) {
      filters['division'] = _selectedDivisions.join(',');
    }
    if (_selectedDistricts.isNotEmpty) {
      filters['zilla'] = _selectedDistricts.join(',');
    }
    if (_selectedUpazilas.isNotEmpty) {
      filters['upazila'] = _selectedUpazilas.join(',');
    }

    // Present/Current address - use comma-separated values for multi-select
    if (_selectedPresentDivisions.isNotEmpty) {
      filters['current_division'] = _selectedPresentDivisions.join(',');
    }
    if (_selectedPresentDistricts.isNotEmpty) {
      filters['current_zilla'] = _selectedPresentDistricts.join(',');
    }
    if (_selectedPresentUpazilas.isNotEmpty) {
      filters['current_upzilla'] = _selectedPresentUpazilas.join(',');
    }

    // Age range
    filters['minAge'] = _ageRange.start.round();
    filters['maxAge'] = _ageRange.end.round();

    // Height range (in feet format, e.g., 5.1 means 5 feet 1 inch)
    filters['minHeight'] = double.parse(_heightRange.start.toStringAsFixed(1));
    filters['maxHeight'] = double.parse(_heightRange.end.toStringAsFixed(1));

    // Address
    if (_permanentAddressController.text.isNotEmpty) {
      filters['permanent_address'] = _permanentAddressController.text;
    }

    // Multi-select filters
    if (_selectedEducationMedium.isNotEmpty) {
      filters['education_medium'] = _selectedEducationMedium.join(',');
    }
    if (_selectedDeeniEdu.isNotEmpty) {
      filters['deeni_edu'] = _selectedDeeniEdu.join(',');
    }
    if (_selectedComplexion.isNotEmpty) {
      filters['complexion'] = _selectedComplexion.join(',');
    }
    if (_selectedFiqh.isNotEmpty) {
      filters['fiqh'] = _selectedFiqh.join(',');
    }
    if (_selectedOccupation.isNotEmpty) {
      filters['occupation'] = _selectedOccupation.join(',');
    }
    if (_selectedEconomicStatus.isNotEmpty) {
      filters['economic_status'] = _selectedEconomicStatus.join(',');
    }
    if (_selectedCategories.isNotEmpty) {
      filters['categories'] = _selectedCategories.join(',');
    }

    // Religion filters
    if (_selectedReligion != null && _selectedReligion!.isNotEmpty) {
      filters['religion'] = _selectedReligion;
    }
    if (_selectedReligiousType != null && _selectedReligiousType!.isNotEmpty) {
      filters['religious_type'] = _selectedReligiousType;
    }

    widget.onApplyFilters(filters);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(4.r)),
              ),
              child: Row(
                children: [
                  Icon(Icons.filter_list, color: Colors.white, size: 24.sp),
                  SizedBox(width: 12.w),
                  Text(
                    'ফিল্টার',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.white, size: 24.sp),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // Filter Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Biodata Type Filter (আমি খুজছি)
                    _buildSectionTitle('আমি খুজছি'),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        _buildChip(
                          'পাত্রের বায়োডাটা',
                          'bioType',
                          'পাত্রের বায়োডাটা',
                        ),
                        _buildChip(
                          'পাত্রীর বায়োডাটা',
                          'bioType',
                          'পাত্রীর বায়োডাটা',
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Marital Status Filter
                    _buildSectionTitle('বৈবাহিক অবস্থা'),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        _buildChip('অবিবাহিত', 'maritalStatus', 'অবিবাহিত'),
                        _buildChip('বিবাহিত', 'maritalStatus', 'বিবাহিত'),
                        _buildChip('ডিভোর্সড', 'maritalStatus', 'ডিভোর্সড'),
                        _buildChip('বিধবা', 'maritalStatus', 'বিধবা'),
                        _buildChip('বিপত্নীক', 'maritalStatus', 'বিপত্নীক'),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Religion Filter
                    _buildSectionTitle('ধর্ম'),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        _buildReligionChip('ইসলাম', 'islam'),
                        _buildReligionChip('হিন্দু', 'hinduism'),
                        _buildReligionChip('খ্রিস্টান', 'christianity'),
                      ],
                    ),
                    if (_selectedReligion != null) ...[
                      SizedBox(height: 12.h),
                      _buildSectionTitle('ধর্মীয় ধরন'),
                      SizedBox(height: 8.h),
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: _buildReligiousTypeChips(),
                      ),
                    ],
                    SizedBox(height: 16.h),

                    // Age Range
                    _buildSectionTitle('বয়স'),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${_ageRange.start.round()} বছর',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        Text(
                          '${_ageRange.end.round()} বছর',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ],
                    ),
                    RangeSlider(
                      values: _ageRange,
                      min: 18,
                      max: 70,
                      divisions: 52,
                      labels: RangeLabels(
                        _ageRange.start.round().toString(),
                        _ageRange.end.round().toString(),
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _ageRange = values;
                        });
                      },
                    ),
                    SizedBox(height: 16.h),

                    // Location Filter - Primary Section (Permanent Address)
                    _buildSectionTitle('স্থায়ী ঠিকানা'),
                    SizedBox(height: 8.h),
                    if (!_isAddressDataLoaded)
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.w),
                          child: SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      )
                    else ...[
                      // Division Multi-Select
                      _buildMultiSelectSection(
                        'বিভাগ নির্বাচন করুন',
                        _divisions,
                        _selectedDivisions,
                        (item, selected) {
                          setState(() {
                            if (selected) {
                              _selectedDivisions.add(item);
                            } else {
                              _selectedDivisions.remove(item);
                            }
                            // Clear dependent selections when divisions change
                            _selectedDistricts.clear();
                            _selectedUpazilas.clear();
                            _currentUpazilas = [];
                          });
                          _updateDistrictsForDivisions(
                            _selectedDivisions,
                            isPresent: false,
                          );
                        },
                      ),
                    ],
                    if (_selectedDivisions.isNotEmpty &&
                        _currentDistricts.isNotEmpty) ...[
                      SizedBox(height: 8.h),
                      // District Multi-Select
                      _buildMultiSelectSection(
                        'জেলা নির্বাচন করুন',
                        _currentDistricts,
                        _selectedDistricts,
                        (item, selected) {
                          setState(() {
                            if (selected) {
                              _selectedDistricts.add(item);
                            } else {
                              _selectedDistricts.remove(item);
                            }
                            // Clear dependent selections when districts change
                            _selectedUpazilas.clear();
                          });
                          _updateUpazilasForDistricts(
                            _selectedDistricts,
                            isPresent: false,
                          );
                        },
                      ),
                    ],
                    if (_selectedDistricts.isNotEmpty &&
                        _currentUpazilas.isNotEmpty) ...[
                      SizedBox(height: 8.h),
                      // Upazila Multi-Select
                      _buildMultiSelectSection(
                        'উপজেলা নির্বাচন করুন',
                        _currentUpazilas,
                        _selectedUpazilas,
                        (item, selected) {
                          setState(() {
                            if (selected) {
                              _selectedUpazilas.add(item);
                            } else {
                              _selectedUpazilas.remove(item);
                            }
                          });
                        },
                      ),
                    ],
                    SizedBox(height: 16.h),

                    // Expandable Advanced Filters Section
                    _buildExpandableSection('বিস্তারিত ফিল্টার', [
                      // Present Address
                      _buildSectionTitle('বর্তমান ঠিকানা', fontSize: 14.sp),
                      SizedBox(height: 8.h),
                      // Present Division Multi-Select
                      _buildMultiSelectSection(
                        'বিভাগ নির্বাচন করুন',
                        _divisions,
                        _selectedPresentDivisions,
                        (item, selected) {
                          setState(() {
                            if (selected) {
                              _selectedPresentDivisions.add(item);
                            } else {
                              _selectedPresentDivisions.remove(item);
                            }
                            // Clear dependent selections when divisions change
                            _selectedPresentDistricts.clear();
                            _selectedPresentUpazilas.clear();
                            _presentUpazilas = [];
                          });
                          _updateDistrictsForDivisions(
                            _selectedPresentDivisions,
                            isPresent: true,
                          );
                        },
                      ),
                      if (_selectedPresentDivisions.isNotEmpty &&
                          _presentDistricts.isNotEmpty) ...[
                        SizedBox(height: 8.h),
                        // Present District Multi-Select
                        _buildMultiSelectSection(
                          'জেলা নির্বাচন করুন',
                          _presentDistricts,
                          _selectedPresentDistricts,
                          (item, selected) {
                            setState(() {
                              if (selected) {
                                _selectedPresentDistricts.add(item);
                              } else {
                                _selectedPresentDistricts.remove(item);
                              }
                              // Clear dependent selections when districts change
                              _selectedPresentUpazilas.clear();
                            });
                            _updateUpazilasForDistricts(
                              _selectedPresentDistricts,
                              isPresent: true,
                            );
                          },
                        ),
                      ],
                      if (_selectedPresentDistricts.isNotEmpty &&
                          _presentUpazilas.isNotEmpty) ...[
                        SizedBox(height: 8.h),
                        // Present Upazila Multi-Select
                        _buildMultiSelectSection(
                          'উপজেলা নির্বাচন করুন',
                          _presentUpazilas,
                          _selectedPresentUpazilas,
                          (item, selected) {
                            setState(() {
                              if (selected) {
                                _selectedPresentUpazilas.add(item);
                              } else {
                                _selectedPresentUpazilas.remove(item);
                              }
                            });
                          },
                        ),
                      ],
                      SizedBox(height: 16.h),
                    ]),
                    SizedBox(height: 16.h),

                    // Address Section - Moved from here
                    // Now showing permanently above instead of in expandable section

                    // Education Section
                    _buildExpandableSection('শিক্ষা', [
                      _buildSectionTitle('পড়াশোনার মাধ্যম', fontSize: 14.sp),
                      SizedBox(height: 8.h),
                      _buildCheckboxGroup([
                        'জেনারেল',
                        // Islamic education mediums - only show for Islam or no religion selected
                        if (_showIslamicOptions) 'কওমী',
                        if (_showIslamicOptions) 'আলিয়া',
                      ], _selectedEducationMedium),
                      // দ্বীনি শিক্ষা - only show for Islam or no religion selected
                      if (_showIslamicOptions) ...[
                        SizedBox(height: 12.h),
                        _buildSectionTitle(
                          'দ্বীনি শিক্ষার যোগ্যতা',
                          fontSize: 14.sp,
                        ),
                        SizedBox(height: 8.h),
                        _buildCheckboxGroup([
                          'হাফেজ',
                          'মাওলানা',
                          'মুফতি',
                          'মুফাসসির',
                          'আলিম',
                          'ফাজিল',
                        ], _selectedDeeniEdu),
                      ],
                    ]),
                    SizedBox(height: 16.h),

                    // Personal Section
                    _buildExpandableSection('ব্যক্তিগত', [
                      _buildSectionTitle('উচ্চতা', fontSize: 14.sp),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${_heightRange.start.toStringAsFixed(1)}\' ফুট',
                            style: TextStyle(fontSize: 12.sp),
                          ),
                          Text(
                            '${_heightRange.end.toStringAsFixed(1)}\' ফুট',
                            style: TextStyle(fontSize: 12.sp),
                          ),
                        ],
                      ),
                      RangeSlider(
                        values: _heightRange,
                        min: 4.0,
                        max: 7.5,
                        divisions: 35,
                        labels: RangeLabels(
                          '${_heightRange.start.toStringAsFixed(1)}\'',
                          '${_heightRange.end.toStringAsFixed(1)}\'',
                        ),
                        onChanged: (RangeValues values) {
                          setState(() {
                            _heightRange = values;
                          });
                        },
                      ),
                      SizedBox(height: 12.h),
                      _buildSectionTitle('গাত্রবর্ণ', fontSize: 14.sp),
                      SizedBox(height: 8.h),
                      _buildCheckboxGroup([
                        'কালো',
                        'শ্যামলা',
                        'উজ্জ্বল শ্যামলা',
                        'ফর্সা',
                        'উজ্জ্বল ফর্সা',
                      ], _selectedComplexion),
                      SizedBox(height: 12.h),
                      // Fiqh - only show for Islam
                      if (_showIslamicOptions) ...[
                        _buildSectionTitle('ফিকহ অনুসরন', fontSize: 14.sp),
                        SizedBox(height: 8.h),
                        _buildCheckboxGroup([
                          'হানাফি',
                          'মালিকি',
                          'শাফিঈ',
                          'হাম্বলি',
                        ], _selectedFiqh),
                      ],
                    ]),
                    SizedBox(height: 16.h),

                    // Occupation Section
                    _buildExpandableSection('পেশা', [
                      _buildCheckboxGroup([
                        // Islamic occupations - only show for Islam or no religion selected
                        if (_showIslamicOptions) 'ইমাম',
                        if (_showIslamicOptions) 'মাদ্রাসা শিক্ষক',
                        'শিক্ষক',
                        'ডাক্তার',
                        'ইঞ্জিনিয়ার',
                        'ব্যবসায়ী',
                        'সরকারি চাকুরি',
                        'বেসরকারি চাকুরি',
                        'ফ্রিল্যান্সার',
                        'শিক্ষার্থী',
                        'প্রবাসী',
                        'অন্যান্য',
                        'পেশা নেই',
                      ], _selectedOccupation),
                    ]),
                    SizedBox(height: 16.h),

                    // Others Section
                    _buildExpandableSection('অন্যান্য', [
                      _buildSectionTitle('অর্থনৈতিক অবস্থা', fontSize: 14.sp),
                      SizedBox(height: 8.h),
                      _buildCheckboxGroup([
                        'উচ্চবিত্ত',
                        'উচ্চ মধ্যবিত্ত',
                        'মধ্যবিত্ত',
                        'নিম্ন মধ্যবিত্ত',
                        'নিম্নবিত্ত',
                      ], _selectedEconomicStatus),
                      SizedBox(height: 12.h),
                      _buildSectionTitle('ক্যাটাগরি', fontSize: 14.sp),
                      SizedBox(height: 8.h),
                      _buildCheckboxGroup([
                        'প্রতিবন্ধী',
                        'বন্ধ্যা',
                        // Islamic categories - only show for Islam or no religion selected
                        if (_showIslamicOptions) 'নওমুসলিম',
                        'এতিম',
                        if (_showIslamicOptions) 'মাসনা হতে আগ্রহী',
                        if (_showIslamicOptions) 'তাবলীগ',
                      ], _selectedCategories),
                    ]),
                  ],
                ),
              ),
            ),

            // Action Buttons
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                border: Border(top: BorderSide(color: Colors.grey[300]!)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _clearFilters,
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        'রিসেট করুন',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _applyFilters,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        'প্রয়োগ করুন',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, {double? fontSize}) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize ?? 16.sp,
        fontWeight: FontWeight.bold,
        color: Colors.grey[800],
      ),
    );
  }

  Widget _buildChip(String label, String filterKey, String value) {
    final isSelected = _filters[filterKey] == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          if (selected) {
            _filters[filterKey] = value;
          } else {
            _filters.remove(filterKey);
          }
        });
      },
      selectedColor: Theme.of(context).primaryColor.withValues(alpha: 0.2),
      checkmarkColor: Theme.of(context).primaryColor,
      labelStyle: TextStyle(
        fontSize: 13.sp,
        color: isSelected ? Theme.of(context).primaryColor : Colors.grey[700],
      ),
    );
  }

  // Religion chip with color coding
  Widget _buildReligionChip(String label, String value) {
    final isSelected = _selectedReligion == value;
    Color chipColor;
    switch (value) {
      case 'islam':
        chipColor = Colors.green;
        break;
      case 'hinduism':
        chipColor = Colors.orange;
        break;
      case 'christianity':
        chipColor = Colors.blue;
        break;
      default:
        chipColor = Colors.grey;
    }

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          if (selected) {
            _selectedReligion = value;
            _selectedReligiousType = null; // Reset religious type
            // Clear Islam-specific filters when changing religion
            if (value != 'islam') {
              _selectedFiqh.clear();
              _selectedDeeniEdu.clear();
              // Remove Islamic occupation/categories from selection
              _selectedOccupation.removeWhere(
                (o) => o == 'ইমাম' || o == 'মাদ্রাসা শিক্ষক',
              );
              _selectedCategories.removeWhere(
                (c) =>
                    c == 'নওমুসলিম' || c == 'মাসনা হতে আগ্রহী' || c == 'তাবলীগ',
              );
            }
          } else {
            _selectedReligion = null;
            _selectedReligiousType = null;
          }
        });
      },
      selectedColor: chipColor.withValues(alpha: 0.2),
      checkmarkColor: chipColor,
      backgroundColor: Colors.grey[100],
      side: BorderSide(color: isSelected ? chipColor : Colors.grey[300]!),
      labelStyle: TextStyle(
        fontSize: 13.sp,
        color: isSelected ? chipColor : Colors.grey[700],
      ),
    );
  }

  // Build religious type chips based on selected religion
  List<Widget> _buildReligiousTypeChips() {
    final chips = <Widget>[];

    if (_selectedReligion == 'islam') {
      chips.addAll([
        _buildReligiousTypeChip('প্র্যাক্টিসিং মুসলিম', 'practicing_muslim'),
        _buildReligiousTypeChip('সাধারণ মুসলিম', 'general_muslim'),
      ]);
    } else if (_selectedReligion == 'hinduism') {
      chips.addAll([
        _buildReligiousTypeChip('প্র্যাক্টিসিং হিন্দু', 'practicing_hindu'),
        _buildReligiousTypeChip('সাধারণ হিন্দু', 'general_hindu'),
      ]);
    } else if (_selectedReligion == 'christianity') {
      chips.addAll([
        _buildReligiousTypeChip(
          'প্র্যাক্টিসিং খ্রিস্টান',
          'practicing_christian',
        ),
        _buildReligiousTypeChip('সাধারণ খ্রিস্টান', 'general_christian'),
      ]);
    }

    return chips;
  }

  Widget _buildReligiousTypeChip(String label, String value) {
    final isSelected = _selectedReligiousType == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedReligiousType = selected ? value : null;
        });
      },
      selectedColor: Theme.of(context).primaryColor.withValues(alpha: 0.2),
      checkmarkColor: Theme.of(context).primaryColor,
      labelStyle: TextStyle(
        fontSize: 13.sp,
        color: isSelected ? Theme.of(context).primaryColor : Colors.grey[700],
      ),
    );
  }

  // Check if Islam-specific options should be shown
  bool get _showIslamicOptions =>
      _selectedReligion == null || _selectedReligion == 'islam';

  Widget _buildCheckboxGroup(List<String> items, Set<String> selectedSet) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: items.map((item) {
        final isSelected = selectedSet.contains(item);
        return FilterChip(
          label: Text(item),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                selectedSet.add(item);
              } else {
                selectedSet.remove(item);
              }
            });
          },
          selectedColor: Theme.of(context).primaryColor.withValues(alpha: 0.2),
          checkmarkColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.grey[100],
          side: BorderSide(
            color: isSelected
                ? Theme.of(context).primaryColor.withValues(alpha: 0.5)
                : Colors.grey[300]!,
          ),
          labelStyle: TextStyle(
            fontSize: 13.sp,
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.grey[700],
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        );
      }).toList(),
    );
  }

  Widget _buildExpandableSection(String title, List<Widget> children) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildMultiSelectSection(
    String title,
    List<String> items,
    Set<String> selectedItems,
    void Function(String item, bool selected) onItemToggle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
        ),
        SizedBox(height: 6.h),
        // Show selected items as chips
        if (selectedItems.isNotEmpty) ...[
          Wrap(
            spacing: 6.w,
            runSpacing: 4.h,
            children: selectedItems.map((item) {
              return Chip(
                label: Text(item, style: TextStyle(fontSize: 12.sp)),
                deleteIcon: Icon(Icons.close, size: 16.sp),
                onDeleted: () => onItemToggle(item, false),
                backgroundColor: Theme.of(
                  context,
                ).primaryColor.withValues(alpha: 0.1),
                side: BorderSide(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 8.h),
        ],
        // Searchable dropdown button
        InkWell(
          onTap: () => _showSearchableDropdown(
            context,
            title,
            items.where((item) => !selectedItems.contains(item)).toList(),
            (value) => onItemToggle(value, true),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]!),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedItems.isEmpty ? title : 'আরো যোগ করুন...',
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                ),
                Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showSearchableDropdown(
    BuildContext context,
    String title,
    List<String> items,
    void Function(String) onSelect,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) {
        return _SearchableDropdownSheet(
          title: title,
          items: items,
          onSelect: (value) {
            onSelect(value);
            Navigator.pop(context);
          },
        );
      },
    );
  }
}

class _SearchableDropdownSheet extends StatefulWidget {
  final String title;
  final List<String> items;
  final void Function(String) onSelect;

  const _SearchableDropdownSheet({
    required this.title,
    required this.items,
    required this.onSelect,
  });

  @override
  State<_SearchableDropdownSheet> createState() =>
      _SearchableDropdownSheetState();
}

class _SearchableDropdownSheetState extends State<_SearchableDropdownSheet> {
  final _searchController = TextEditingController();
  List<String> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = widget.items;
      } else {
        _filteredItems = widget.items
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: EdgeInsets.only(
        top: 16.h,
        left: 16.w,
        right: 16.w,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          // Title
          Text(
            widget.title,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12.h),
          // Search field
          TextField(
            controller: _searchController,
            onChanged: _filterItems,
            decoration: InputDecoration(
              hintText: 'অনুসন্ধান করুন...',
              prefixIcon: Icon(Icons.search, size: 20.sp),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear, size: 20.sp),
                      onPressed: () {
                        _searchController.clear();
                        _filterItems('');
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 12.h,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          // Items list as selectable chips
          Expanded(
            child: _filteredItems.isEmpty
                ? Center(
                    child: Text(
                      'কোনো ফলাফল পাওয়া যায়নি',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: _filteredItems.map((item) {
                        return ActionChip(
                          label: Text(item, style: TextStyle(fontSize: 13.sp)),
                          onPressed: () => widget.onSelect(item),
                          backgroundColor: Colors.grey[100],
                          side: BorderSide(color: Colors.grey[300]!),
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 8.h,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
