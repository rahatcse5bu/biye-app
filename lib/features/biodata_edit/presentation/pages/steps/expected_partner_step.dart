import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../providers/biodata_edit_provider.dart';

class ExpectedPartnerStep extends ConsumerStatefulWidget {
  const ExpectedPartnerStep({super.key});

  @override
  ConsumerState<ExpectedPartnerStep> createState() =>
      _ExpectedPartnerStepState();
}

class _ExpectedPartnerStepState extends ConsumerState<ExpectedPartnerStep> {
  final _formKey = GlobalKey<FormState>();
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // Reset initialization flag when widget is created
    _isInitialized = false;
  }

  void _initializeFormData(dynamic model) {
    if (!_isInitialized && mounted) {
      _isInitialized = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ref.read(expectedPartnerEditNotifierProvider.notifier).updateModel(model);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncModel = ref.watch(expectedPartnerEditProvider);
    final currentState = ref.watch(expectedPartnerEditNotifierProvider);

    return asyncModel.when(
      data: (loadedModel) {
        _initializeFormData(loadedModel);
        return _buildForm(currentState);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text(
          'ডেটা লোড করতে ব্যর্থ: $error',
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget _buildForm(dynamic model) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('বয়স: ${model.minAge} - ${model.maxAge} বছর'),
          RangeSlider(
            values: RangeValues(model.minAge.toDouble(), model.maxAge.toDouble()),
            min: 18,
            max: 60,
            divisions: 42,
            labels: RangeLabels(
              model.minAge.toString(),
              model.maxAge.toString(),
            ),
            onChanged: (RangeValues values) {
              ref.read(expectedPartnerEditNotifierProvider.notifier).updateModel(
                    model.copyWith(
                      minAge: values.start.round(),
                      maxAge: values.end.round(),
                    ),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('উচ্চতা: ${model.minHeight.toStringAsFixed(1)} - ${model.maxHeight.toStringAsFixed(1)} ফুট'),
          RangeSlider(
            values: RangeValues(model.minHeight, model.maxHeight),
            min: 4.0,
            max: 7.0,
            divisions: 30,
            labels: RangeLabels(
              model.minHeight.toStringAsFixed(1),
              model.maxHeight.toStringAsFixed(1),
            ),
            onChanged: (RangeValues values) {
              ref.read(expectedPartnerEditNotifierProvider.notifier).updateModel(
                    model.copyWith(
                      minHeight: values.start,
                      maxHeight: values.end,
                    ),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('গাত্রবর্ণ'),
          _buildMultiSelect(
            selectedItems: model.color,
            allItems: ['ফর্সা', 'শ্যামলা', 'কালো', 'উজ্জ্বল শ্যামলা', 'যেকোনো'],
            hint: 'গাত্রবর্ণ নির্বাচন করুন',
            onChanged: (selected) {
              ref.read(expectedPartnerEditNotifierProvider.notifier).updateModel(
                    model.copyWith(color: selected),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('শিক্ষাগত যোগ্যতা *'),
          _buildMultiSelect(
            selectedItems: model.educationalQualifications,
            allItems: ['এসএসসি', 'এইচএসসি', 'স্নাতক', 'স্নাতকোত্তর', 'ডিপ্লোমা', 'মাদ্রাসা', 'দাখিল', 'আলিম', 'ফাজিল', 'কামিল'],
            hint: 'শিক্ষাগত যোগ্যতা নির্বাচন করুন',
            onChanged: (selected) {
              ref.read(expectedPartnerEditNotifierProvider.notifier).updateModel(
                    model.copyWith(educationalQualifications: selected),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('পেশা'),
          _buildMultiSelect(
            selectedItems: model.occupation,
            allItems: ['চাকরিজীবী', 'ব্যবসায়ী', 'ছাত্র/ছাত্রী', 'শিক্ষক', 'ডাক্তার', 'ইঞ্জিনিয়ার', 'গৃহিণী', 'অন্যান্য'],
            hint: 'পেশা নির্বাচন করুন',
            onChanged: (selected) {
              ref.read(expectedPartnerEditNotifierProvider.notifier).updateModel(
                    model.copyWith(occupation: selected),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('জেলা'),
          _buildMultiSelect(
            selectedItems: model.zilla,
            allItems: ['ঢাকা', 'চট্টগ্রাম', 'রাজশাহী', 'খুলনা', 'বরিশাল', 'সিলেট', 'রংপুর', 'ময়মনসিংহ', 'যেকোনো'],
            hint: 'জেলা নির্বাচন করুন',
            onChanged: (selected) {
              ref.read(expectedPartnerEditNotifierProvider.notifier).updateModel(
                    model.copyWith(zilla: selected),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('বৈবাহিক অবস্থা'),
          _buildMultiSelect(
            selectedItems: model.maritalStatus,
            allItems: ['অবিবাহিত', 'বিবাহিত', 'ডিভোর্সড', 'বিধবা/বিধুর'],
            hint: 'বৈবাহিক অবস্থা নির্বাচন করুন',
            onChanged: (selected) {
              ref.read(expectedPartnerEditNotifierProvider.notifier).updateModel(
                    model.copyWith(maritalStatus: selected),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('অন্যান্য গুণাবলী *'),
          TextFormField(
            key: ValueKey('expected_characteristics_${model.expectedCharacteristics}'),
            initialValue: model.expectedCharacteristics ?? '',
            decoration: _inputDecoration('জীবনসঙ্গীর কাছে কী আশা করেন'),
            maxLines: 4,
            onChanged: (value) {
              ref.read(expectedPartnerEditNotifierProvider.notifier).updateModel(
                    model.copyWith(expectedCharacteristics: value),
                  );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required String hint,
    required void Function(String?) onChanged,
  }) {
    // Validate that value exists in items to prevent assertion errors
    final validValue = (value != null && items.contains(value)) ? value : null;
    
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: validValue,
          isExpanded: true,
          hint: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(hint, style: TextStyle(color: Colors.grey[600])),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildMultiSelect({
    required List<String> selectedItems,
    required List<String> allItems,
    required String hint,
    required void Function(List<String>) onChanged,
  }) {
    // Filter out already selected items from dropdown
    final availableItems = allItems.where((item) => !selectedItems.contains(item)).toList();
    
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Selected items as chips
          if (selectedItems.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 8),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: selectedItems.map((item) {
                  return Chip(
                    label: Text(item, style: const TextStyle(fontSize: 13)),
                    deleteIcon: const Icon(Icons.close, size: 18),
                    onDeleted: () {
                      final updated = List<String>.from(selectedItems)..remove(item);
                      onChanged(updated);
                    },
                    backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                    side: BorderSide.none,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  );
                }).toList(),
              ),
            ),
          // Dropdown to add more items
          if (availableItems.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(hint, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  items: availableItems
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      final updated = List<String>.from(selectedItems)..add(value);
                      onChanged(updated);
                    }
                  },
                ),
              ),
            )
          else if (selectedItems.isEmpty)
            Padding(
              padding: const EdgeInsets.all(14),
              child: Text(hint, style: TextStyle(color: Colors.grey[600])),
            ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.all(14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppTheme.primaryColor),
      ),
    );
  }
}
