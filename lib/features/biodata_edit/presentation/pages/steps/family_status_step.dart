import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../providers/biodata_edit_provider.dart';

class FamilyStatusStep extends ConsumerStatefulWidget {
  const FamilyStatusStep({super.key});

  @override
  ConsumerState<FamilyStatusStep> createState() => _FamilyStatusStepState();
}

class _FamilyStatusStepState extends ConsumerState<FamilyStatusStep> {
  final _formKey = GlobalKey<FormState>();
  bool _isInitialized = false;

  void _initializeFormData(dynamic model) {
    if (!_isInitialized && mounted) {
      _isInitialized = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ref.read(familyStatusEditNotifierProvider.notifier).updateModel(model);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncModel = ref.watch(familyStatusEditProvider);
    final currentState = ref.watch(familyStatusEditNotifierProvider);

    return asyncModel.when(
      data: (loadedModel) {
        _initializeFormData(loadedModel);
        // Check if state has been populated
        if (currentState.fatherName.isEmpty && loadedModel.fatherName.isNotEmpty) {
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
          _buildSectionTitle('পিতার নাম *'),
          TextFormField(
            key: ValueKey('father_name_${model.fatherName}'),
            initialValue: model.fatherName,
            decoration: _inputDecoration('পিতার পূর্ণ নাম লিখুন'),
            onChanged: (value) {
              ref.read(familyStatusEditNotifierProvider.notifier).updateModel(
                    model.copyWith(fatherName: value),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('পিতার পেশা *'),
          TextFormField(
            key: ValueKey('father_occupation_${model.fatherOccupation}'),
            initialValue: model.fatherOccupation,
            decoration: _inputDecoration('পেশার বিবরণ'),
            onChanged: (value) {
              ref.read(familyStatusEditNotifierProvider.notifier).updateModel(
                    model.copyWith(fatherOccupation: value),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('পিতা জীবিত আছেন? *'),
          TextFormField(
            key: ValueKey('father_alive_${model.isFatherAlive}'),
            initialValue: model.isFatherAlive,
            decoration: _inputDecoration('হ্যাঁ/না'),
            onChanged: (value) {
              ref.read(familyStatusEditNotifierProvider.notifier).updateModel(
                    model.copyWith(isFatherAlive: value),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('মাতার নাম *'),
          TextFormField(
            key: ValueKey('mother_name_${model.motherName}'),
            initialValue: model.motherName,
            decoration: _inputDecoration('মাতার পূর্ণ নাম লিখুন'),
            onChanged: (value) {
              ref.read(familyStatusEditNotifierProvider.notifier).updateModel(
                    model.copyWith(motherName: value),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('মাতা জীবিত আছেন? *'),
          TextFormField(
            key: ValueKey('mother_alive_${model.isMotherAlive}'),
            initialValue: model.isMotherAlive,
            decoration: _inputDecoration('হ্যাঁ/না'),
            onChanged: (value) {
              ref.read(familyStatusEditNotifierProvider.notifier).updateModel(
                    model.copyWith(isMotherAlive: value),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('মাতার পেশা'),
          TextFormField(
            key: ValueKey('mother_occupation_${model.motherOccupation}'),
            initialValue: model.motherOccupation,
            decoration: _inputDecoration('পেশার বিবরণ'),
            onChanged: (value) {
              ref.read(familyStatusEditNotifierProvider.notifier).updateModel(
                    model.copyWith(motherOccupation: value),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('ভাই এর সংখ্যা'),
          TextFormField(
            key: ValueKey('brothers_${model.numberOfBrothers}'),
            initialValue: model.numberOfBrothers,
            decoration: _inputDecoration('সংখ্যা লিখুন'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              ref.read(familyStatusEditNotifierProvider.notifier).updateModel(
                    model.copyWith(numberOfBrothers: value),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('বোন এর সংখ্যা'),
          TextFormField(
            key: ValueKey('sisters_${model.numberOfSisters}'),
            initialValue: model.numberOfSisters,
            decoration: _inputDecoration('সংখ্যা লিখুন'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              ref.read(familyStatusEditNotifierProvider.notifier).updateModel(
                    model.copyWith(numberOfSisters: value),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('পরিবারের আর্থিক অবস্থা *'),
          TextFormField(
            key: ValueKey('eco_condition_${model.familyEcoCondition}'),
            initialValue: model.familyEcoCondition,
            decoration: _inputDecoration('উচ্চবিত্ত/মধ্যবিত্ত/নিম্নবিত্ত'),
            maxLines: 2,
            onChanged: (value) {
              ref.read(familyStatusEditNotifierProvider.notifier).updateModel(
                    model.copyWith(familyEcoCondition: value),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('পরিবারের দ্বীনি অবস্থা *'),
          TextFormField(
            key: ValueKey('deeni_info_${model.familyDeeniInfo}'),
            initialValue: model.familyDeeniInfo,
            decoration: _inputDecoration('পরিবারের দ্বীনি পরিবেশ সম্পর্কে লিখুন'),
            maxLines: 3,
            onChanged: (value) {
              ref.read(familyStatusEditNotifierProvider.notifier).updateModel(
                    model.copyWith(familyDeeniInfo: value),
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
