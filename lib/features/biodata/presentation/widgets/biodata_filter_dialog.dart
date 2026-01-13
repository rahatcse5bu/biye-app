import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BiodataFilterDialog extends StatefulWidget {
  final Map<String, dynamic> currentFilters;
  final Function(Map<String, dynamic>) onApplyFilters;

  const BiodataFilterDialog({
    super.key,
    required this.currentFilters,
    required this.onApplyFilters,
  });

  @override
  State<BiodataFilterDialog> createState() => _BiodataFilterDialogState();
}

class _BiodataFilterDialogState extends State<BiodataFilterDialog> {
  late Map<String, dynamic> _filters;
  final _ageStartController = TextEditingController();
  final _ageEndController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filters = Map.from(widget.currentFilters);
    if (_filters['minAge'] != null) {
      _ageStartController.text = _filters['minAge'].toString();
    }
    if (_filters['maxAge'] != null) {
      _ageEndController.text = _filters['maxAge'].toString();
    }
  }

  @override
  void dispose() {
    _ageStartController.dispose();
    _ageEndController.dispose();
    super.dispose();
  }

  void _clearFilters() {
    setState(() {
      _filters.clear();
      _ageStartController.clear();
      _ageEndController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
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
                    _buildSectionTitle('বায়োডাটার ধরন'),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        _buildChip('সাধারণ বিবাহ', 'bioType', 'সাধারণ বিবাহ'),
                        _buildChip('বিধবা বিবাহ', 'bioType', 'বিধবা বিবাহ'),
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
                        _buildChip('তালাকপ্রাপ্ত', 'maritalStatus', 'তালাকপ্রাপ্ত'),
                        _buildChip('বিধবা/বিপত্নীক', 'maritalStatus', 'বিধবা/বিপত্নীক'),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Age Range Filter
                    _buildSectionTitle('বয়স'),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _ageStartController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'সর্বনিম্ন',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 12.h,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _filters['minAge'] = int.tryParse(value);
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: TextField(
                            controller: _ageEndController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'সর্বোচ্চ',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 12.h,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _filters['maxAge'] = int.tryParse(value);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Division Filter
                    _buildSectionTitle('বিভাগ'),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        _buildChip('ঢাকা', 'division', 'ঢাকা'),
                        _buildChip('চট্টগ্রাম', 'division', 'চট্টগ্রাম'),
                        _buildChip('রাজশাহী', 'division', 'রাজশাহী'),
                        _buildChip('খুলনা', 'division', 'খুলনা'),
                        _buildChip('বরিশাল', 'division', 'বরিশাল'),
                        _buildChip('সিলেট', 'division', 'সিলেট'),
                        _buildChip('রংপুর', 'division', 'রংপুর'),
                        _buildChip('ময়মনসিংহ', 'division', 'ময়মনসিংহ'),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Education Level Filter
                    _buildSectionTitle('শিক্ষাগত যোগ্যতা'),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        _buildChip('এসএসসি', 'education', 'এসএসসি'),
                        _buildChip('এইচএসসি', 'education', 'এইচএসসি'),
                        _buildChip('ডিপ্লোমা', 'education', 'ডিপ্লোমা'),
                        _buildChip('স্নাতক', 'education', 'স্নাতক'),
                        _buildChip('স্নাতকোত্তর', 'education', 'স্নাতকোত্তর'),
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
                      onPressed: () {
                        widget.onApplyFilters(_filters);
                        Navigator.pop(context);
                      },
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16.sp,
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
      selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
      checkmarkColor: Theme.of(context).primaryColor,
      labelStyle: TextStyle(
        fontSize: 13.sp,
        color: isSelected ? Theme.of(context).primaryColor : Colors.grey[700],
      ),
    );
  }
}
