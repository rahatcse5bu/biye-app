import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  // Address selections
  String? _selectedDivision;
  String? _selectedDistrict;
  String? _selectedUpazila;
  String? _selectedPresentDivision;
  String? _selectedPresentDistrict;
  String? _selectedPresentUpazila;

  // Multi-select sets
  Set<String> _selectedEducationMedium = {};
  Set<String> _selectedDeeniEdu = {};
  Set<String> _selectedComplexion = {};
  Set<String> _selectedFiqh = {};
  Set<String> _selectedOccupation = {};
  Set<String> _selectedEconomicStatus = {};
  Set<String> _selectedCategories = {};

  // Location data
  final List<String> _divisions = [
    'ঢাকা',
    'চট্টগ্রাম',
    'রাজশাহী',
    'খুলনা',
    'বরিশাল',
    'সিলেট',
    'রংপুর',
    'ময়মনসিংহ',
  ];

  Map<String, List<String>> get _districtsByDivision => {
    'ঢাকা': ['ঢাকা', 'গাজীপুর', 'নারায়ণগঞ্জ', 'টাঙ্গাইল', 'মানিকগঞ্জ', 'কিশোরগঞ্জ'],
    'চট্টগ্রাম': ['চট্টগ্রাম', 'কক্সবাজার', 'কুমিল্লা', 'নোয়াখালী', 'ফেনী', 'ব্রাহ্মণবাড়িয়া'],
    'রাজশাহী': ['রাজশাহী', 'নাটোর', 'বগুড়া', 'পাবনা', 'সিরাজগঞ্জ'],
    'খুলনা': ['খুলনা', 'যশোর', 'সাতক্ষীরা', 'বাগেরহাট', 'কুষ্টিয়া'],
    'বরিশাল': ['বরিশাল', 'পটুয়াখালী', 'ভোলা', 'বরগুনা', 'ঝালকাঠি', 'পিরোজপুর'],
    'সিলেট': ['সিলেট', 'মৌলভীবাজার', 'হবিগঞ্জ', 'সুনামগঞ্জ'],
    'রংপুর': ['রংপুর', 'দিনাজপুর', 'কুড়িগ্রাম', 'লালমনিরহাট', 'নীলফামারী'],
    'ময়মনসিংহ': ['ময়মনসিংহ', 'জামালপুর', 'শেরপুর', 'নেত্রকোনা'],
  };

  Map<String, List<String>> get _upazilasByDistrict => {
    'ঢাকা': ['ধানমন্ডি', 'মিরপুর', 'গুলশান', 'উত্তরা', 'মোহাম্মদপুর', 'তেজগাঁও'],
    'চট্টগ্রাম': ['পাঁচলাইশ', 'হালিশহর', 'আগ্রাবাদ', 'বাকলিয়া', 'চান্দগাঁও'],
    'গাজীপুর': ['গাজীপুর সদর', 'কালিয়াকৈর', 'কাপাসিয়া', 'শ্রীপুর'],
    'কক্সবাজার': ['কক্সবাজার সদর', 'চকরিয়া', 'রামু', 'উখিয়া', 'টেকনাফ'],
    'বরিশাল': ['বরিশাল সদর', 'বাকেরগঞ্জ', 'বানারীপাড়া', 'গৌরনদী'],
  };

  @override
  void initState() {
    super.initState();
    _filters = Map.from(widget.currentFilters);
    _initializeFromFilters();
  }

  void _initializeFromFilters() {
    // Initialize from existing filters
    if (_filters['minAge'] != null) _ageRange = RangeValues((_filters['minAge'] as num).toDouble(), _ageRange.end);
    if (_filters['maxAge'] != null) _ageRange = RangeValues(_ageRange.start, (_filters['maxAge'] as num).toDouble());
    
    if (_filters['minHeight'] != null) _heightRange = RangeValues((_filters['minHeight'] as num).toDouble() / 30.48, _heightRange.end);
    if (_filters['maxHeight'] != null) _heightRange = RangeValues(_heightRange.start, (_filters['maxHeight'] as num).toDouble() / 30.48);
    
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
      _selectedDivision = null;
      _selectedDistrict = null;
      _selectedUpazila = null;
      _selectedPresentDivision = null;
      _selectedPresentDistrict = null;
      _selectedPresentUpazila = null;
      _selectedEducationMedium.clear();
      _selectedDeeniEdu.clear();
      _selectedComplexion.clear();
      _selectedFiqh.clear();
      _selectedOccupation.clear();
      _selectedEconomicStatus.clear();
      _selectedCategories.clear();
    });
  }

  void _applyFilters() {
    // Build filter map
    final filters = <String, dynamic>{};
    
    // Basic filters
    if (_filters['gender'] != null) filters['gender'] = _filters['gender'];
    if (_filters['bioType'] != null) filters['bio_type'] = _filters['bioType'];
    if (_filters['maritalStatus'] != null) filters['marital_status'] = _filters['maritalStatus'];
    if (_filters['division'] != null) filters['division'] = _filters['division'];
    if (_filters['current_upzilla'] != null) filters['current_upzilla'] = _filters['current_upzilla'];
    
    // Permanent address - use upazila if selected, else district, else division
    if (_selectedUpazila != null && _selectedUpazila!.isNotEmpty) {
      filters['permanent_address'] = _selectedUpazila;
    } else if (_selectedDistrict != null && _selectedDistrict!.isNotEmpty) {
      filters['permanent_address'] = _selectedDistrict;
    } else if (_selectedDivision != null && _selectedDivision!.isNotEmpty) {
      filters['permanent_address'] = _selectedDivision;
    }
    
    // Present address - use upazila if selected, else district
    if (_selectedPresentUpazila != null && _selectedPresentUpazila!.isNotEmpty) {
      filters['current_upzilla'] = _selectedPresentUpazila;
    } else if (_selectedPresentDistrict != null && _selectedPresentDistrict!.isNotEmpty) {
      filters['current_upzilla'] = _selectedPresentDistrict;
    }
    
    // Age range
    filters['minAge'] = _ageRange.start.round();
    filters['maxAge'] = _ageRange.end.round();
    
    // Height range (convert feet to cm)
    filters['minHeight'] = (_heightRange.start * 30.48).round();
    filters['maxHeight'] = (_heightRange.end * 30.48).round();
    
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
    
    widget.onApplyFilters(filters);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.85),
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
                    // Gender Filter
                    _buildSectionTitle('লিঙ্গ'),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 8.w,
                      children: [
                        _buildChip('পুরুষ', 'gender', 'পুরুষ'),
                        _buildChip('মহিলা', 'gender', 'মহিলা'),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Biodata Type Filter
                    _buildSectionTitle('ব্যাবসায়িক ধরন'),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        _buildChip('সাধারণ বিবাহ', 'bioType', 'সাধারণ বিবাহ'),
                        _buildChip('দ্বিতীয় বিবাহ', 'bioType', 'দ্বিতীয় বিবাহ'),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Marital Status Filter
                    _buildSectionTitle('ৈবরাহিত অবস্থা'),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        _buildChip('অবিবাহিত', 'maritalStatus', 'অবিবাহিত'),
                        _buildChip('বিবাহিত', 'maritalStatus', 'বিবাহিত'),
                        _buildChip('তালাকপ্রাপ্ত', 'maritalStatus', 'তালাকপ্রাপ্ত'),
                        _buildChip('বিধবা/বিপত্নীক', 'maritalStatus', 'বিধবা/বিপত্নীক'),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Age Range
                    _buildSectionTitle('বয়স'),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${_ageRange.start.round()} বছর', style: TextStyle(fontSize: 12.sp)),
                        Text('${_ageRange.end.round()} বছর', style: TextStyle(fontSize: 12.sp)),
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

                    // Location Filter - Primary Section
                    _buildSectionTitle('ঠিকানা'),
                    SizedBox(height: 8.h),
                    _buildDropdown(
                      'বিভাগ নির্বাচন করুন',
                      _divisions,
                      _selectedDivision,
                      (value) {
                        setState(() {
                          _selectedDivision = value;
                          _selectedDistrict = null;
                          _selectedUpazila = null;
                        });
                      },
                    ),
                    if (_selectedDivision != null) ...[
                      SizedBox(height: 8.h),
                      _buildDropdown(
                        'জেলা নির্বাচন করুন',
                        _districtsByDivision[_selectedDivision] ?? [],
                        _selectedDistrict,
                        (value) {
                          setState(() {
                            _selectedDistrict = value;
                            _selectedUpazila = null;
                          });
                        },
                      ),
                    ],
                    if (_selectedDistrict != null) ...[
                      SizedBox(height: 8.h),
                      _buildDropdown(
                        'উপজেলা নির্বাচন করুন',
                        _upazilasByDistrict[_selectedDistrict] ?? [],
                        _selectedUpazila,
                        (value) {
                          setState(() {
                            _selectedUpazila = value;
                          });
                        },
                      ),
                    ],
                    SizedBox(height: 16.h),

                    // Expandable Advanced Filters Section
                    _buildExpandableSection(
                      'বিস্তারিত ফিল্টার',
                      [
                        // Present Address
                        _buildSectionTitle('বর্তমান ঠিকানা', fontSize: 14.sp),
                        SizedBox(height: 8.h),
                        _buildDropdown(
                          'বিভাগ নির্বাচন করুন',
                          _divisions,
                          _selectedPresentDivision,
                          (value) {
                            setState(() {
                              _selectedPresentDivision = value;
                              _selectedPresentDistrict = null;
                              _selectedPresentUpazila = null;
                            });
                          },
                        ),
                        if (_selectedPresentDivision != null) ...[
                          SizedBox(height: 8.h),
                          _buildDropdown(
                            'জেলা নির্বাচন করুন',
                            _districtsByDivision[_selectedPresentDivision] ?? [],
                            _selectedPresentDistrict,
                            (value) {
                              setState(() {
                                _selectedPresentDistrict = value;
                                _selectedPresentUpazila = null;
                              });
                            },
                          ),
                        ],
                        if (_selectedPresentDistrict != null) ...[
                          SizedBox(height: 8.h),
                          _buildDropdown(
                            'উপজেলা নির্বাচন করুন',
                            _upazilasByDistrict[_selectedPresentDistrict] ?? [],
                            _selectedPresentUpazila,
                            (value) {
                              setState(() {
                                _selectedPresentUpazila = value;
                              });
                            },
                          ),
                        ],
                        SizedBox(height: 16.h),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Address Section - Moved from here
                    // Now showing permanently above instead of in expandable section

                    // Education Section
                    _buildExpandableSection(
                      'শিক্ষা',
                      [
                        _buildSectionTitle('পড়ুয়াশোনার মাধ্যম', fontSize: 14.sp),
                        SizedBox(height: 8.h),
                        _buildCheckboxGroup([
                          'জেনারেল',
                          'কওমি',
                          'আলিয়া',
                        ], _selectedEducationMedium),
                        SizedBox(height: 12.h),
                        _buildSectionTitle('স্কুল শিক্ষাগত যোগ্যতা', fontSize: 14.sp),
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
                    ),
                    SizedBox(height: 16.h),

                    // Personal Section
                    _buildExpandableSection(
                      'ব্যক্তিগত',
                      [
                        _buildSectionTitle('উচ্চতা', fontSize: 14.sp),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${_heightRange.start.toStringAsFixed(1)}\' ফুট', style: TextStyle(fontSize: 12.sp)),
                            Text('${_heightRange.end.toStringAsFixed(1)}\' ফুট', style: TextStyle(fontSize: 12.sp)),
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
                        _buildSectionTitle('ফিজিক অনুসরণ', fontSize: 14.sp),
                        SizedBox(height: 8.h),
                        _buildCheckboxGroup([
                          'হানাফি',
                          'মালিকি',
                          'শাফিই',
                          'হাবলী',
                          'আহলে হাদিস / শালাফি',
                        ], _selectedFiqh),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Occupation Section
                    _buildExpandableSection(
                      'পেশা',
                      [
                        _buildCheckboxGroup([
                          'ইমাম',
                          'আয়াতুল্লাহ শিক্ষক',
                          'শিক্ষক',
                          'ইসলামিয়ার',
                          'ব্যবসায়ী',
                          'সরকারি চাকুরী',
                          'ডাক্তার',
                          'সেবাধর্মী চাকুরী',
                          'MBBS/BDS শিক্ষার্থী',
                          'শিক্ষার্থী',
                          'প্রবাসী',
                          'পেশা নেই',
                        ], _selectedOccupation),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Others Section
                    _buildExpandableSection(
                      'অন্যান্য',
                      [
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
                          'বন্ধা',
                          'নারীবাদি',
                          'এতিম',
                          '২২ বছর হতে আধুরই',
                          'তালাকপ্রা',
                        ], _selectedCategories),
                      ],
                    ),
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

  Widget _buildCheckboxGroup(List<String> items, Set<String> selectedSet) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 4.h,
      children: items.map((item) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: CheckboxListTile(
                title: Text(
                  item,
                  style: TextStyle(fontSize: 12.sp),
                ),
                value: selectedSet.contains(item),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      selectedSet.add(item);
                    } else {
                      selectedSet.remove(item);
                    }
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                dense: true,
              ),
            ),
          ],
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

  Widget _buildDropdown(
    String hint,
    List<String> items,
    String? selectedValue,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[400]!),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(hint, style: TextStyle(fontSize: 14.sp)),
          value: selectedValue,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: TextStyle(fontSize: 14.sp)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
