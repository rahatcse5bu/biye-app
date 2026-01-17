import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../providers/biodata_edit_provider.dart';

class EducationalQualificationStep extends ConsumerStatefulWidget {
  const EducationalQualificationStep({super.key});

  @override
  ConsumerState<EducationalQualificationStep> createState() =>
      _EducationalQualificationStepState();
}

class _EducationalQualificationStepState
    extends ConsumerState<EducationalQualificationStep> {
  final _formKey = GlobalKey<FormState>();
  bool _isInitialized = false;

  void _initializeFormData(dynamic model) {
    if (!_isInitialized && mounted) {
      _isInitialized = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ref.read(educationalQualificationEditNotifierProvider.notifier).updateModel(model);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncModel = ref.watch(educationalQualificationEditProvider);
    final currentState = ref.watch(educationalQualificationEditNotifierProvider);

    return asyncModel.when(
      data: (loadedModel) {
        _initializeFormData(loadedModel);
        // Check if state has been populated
        if ((currentState.highestEduLevel?.isEmpty ?? true) && (loadedModel.highestEduLevel?.isNotEmpty ?? false)) {
          return const Center(child: CircularProgressIndicator());
        }
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
          _buildSectionTitle('শিক্ষাগত যোগ্যতা *'),
          _buildDropdown(
            value: (model.highestEduLevel?.isEmpty ?? true)
                ? null
                : model.highestEduLevel,
            items: [
              'এসএসসি',
              'দাখিল',
              'এইচএসসি',
              'আলিম',
              'স্নাতক',
              'ফাজিল',
              'স্নাতকোত্তর',
              'কামিল',
              'স্নাতকোত্তর / কামিল',
              'ডিপ্লোমা',
              'মাদ্রাসা',
              'অন্যান্য'
            ],
            hint: 'সর্বোচ্চ শিক্ষা নির্বাচন করুন',
            onChanged: (value) {
              ref.read(educationalQualificationEditNotifierProvider.notifier).updateModel(
                    model.copyWith(highestEduLevel: value ?? ''),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('পড়াশোনার মাধ্যম'),
          _buildDropdown(
            value: (model.educationMedium?.isEmpty ?? true)
                ? null
                : model.educationMedium,
            items: ['জেনারেল', 'কওমি', 'আলিয়া'],
            hint: 'নির্বাচন করুন',
            onChanged: (value) {
              ref.read(educationalQualificationEditNotifierProvider.notifier).updateModel(
                    model.copyWith(educationMedium: value),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('এসএসসি পাসের বছর'),
          TextFormField(
            key: ValueKey('ssc_year_${model.sscYear}'),
            initialValue: model.sscYear?.toString() ?? '',
            decoration: _inputDecoration('উদাহরণ: 2015'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              ref.read(educationalQualificationEditNotifierProvider.notifier).updateModel(
                    model.copyWith(sscYear: int.tryParse(value)),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('এসএসসি গ্রুপ'),
          TextFormField(            key: ValueKey('ssc_group_${model.sscGroup}'),            initialValue: model.sscGroup ?? '',
            decoration: _inputDecoration('বিজ্ঞান/ব্যবসায়/মানবিক'),
            onChanged: (value) {
              ref.read(educationalQualificationEditNotifierProvider.notifier).updateModel(
                    model.copyWith(sscGroup: value),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('এসএসসি ফলাফল'),
          TextFormField(
            key: ValueKey('ssc_result_${model.sscResult}'),
            initialValue: model.sscResult ?? '',
            decoration: _inputDecoration('উদাহরণ: 5.00'),
            onChanged: (value) {
              ref.read(educationalQualificationEditNotifierProvider.notifier).updateModel(
                    model.copyWith(sscResult: value),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('অন্যান্য শিক্ষাগত যোগ্যতা'),
          TextFormField(
            key: ValueKey('others_edu_${model.othersEdu}'),
            initialValue: model.othersEdu ?? '',
            decoration: _inputDecoration('অতিরিক্ত কোর্স, সার্টিফিকেট ইত্যাদি'),
            maxLines: 3,
            onChanged: (value) {
              ref.read(educationalQualificationEditNotifierProvider.notifier).updateModel(
                    model.copyWith(othersEdu: value),
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
    // If value exists but not in items, add it to avoid assertion error
    List<String> dropdownItems = List.from(items);
    if (value != null && value.isNotEmpty && !items.contains(value)) {
      dropdownItems.add(value);
    }
    
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: (value?.isEmpty ?? true) ? null : value,
          isExpanded: true,
          hint: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(hint, style: TextStyle(color: Colors.grey[600])),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          items: dropdownItems
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
