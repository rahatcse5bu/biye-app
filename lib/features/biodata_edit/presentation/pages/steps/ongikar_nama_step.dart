import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../providers/biodata_edit_provider.dart';

class OngikarNamaStep extends ConsumerStatefulWidget {
  const OngikarNamaStep({super.key});

  @override
  ConsumerState<OngikarNamaStep> createState() => _OngikarNamaStepState();
}

class _OngikarNamaStepState extends ConsumerState<OngikarNamaStep> {
  final _formKey = GlobalKey<FormState>();
  bool _isInitialized = false;

  void _initializeFormData(dynamic model) {
    if (!_isInitialized && mounted) {
      _isInitialized = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ref.read(ongikarNamaEditNotifierProvider.notifier).updateModel(model);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncModel = ref.watch(ongikarNamaEditProvider);
    final currentState = ref.watch(ongikarNamaEditNotifierProvider);

    return asyncModel.when(
      data: (loadedModel) {
        _initializeFormData(loadedModel);
        // Check if state has been populated
        if (currentState.isFamilyKnow.isEmpty && loadedModel.isFamilyKnow.isNotEmpty) {
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
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'আমি আল্লাহর নামে অঙ্গীকার করছি যে, এখানে যে তথ্যগুলো দেওয়া হয়েছে তা সঠিক। অসত্য বা ভুয়ো তথ্য প্রদানের জন্য এই ওয়েবসাইট কর্তৃপক্ষ দায়ী নয়।',
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 24),

          _buildSectionTitle('পরিবার কি জানে? *'),
          _buildDropdown(
            value: model.isFamilyKnow.isEmpty ? null : model.isFamilyKnow,
            items: ['হ্যাঁ', 'না'],
            hint: 'নির্বাচন করুন',
            onChanged: (value) {
              ref.read(ongikarNamaEditNotifierProvider.notifier).updateModel(
                    model.copyWith(isFamilyKnow: value ?? ''),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('তথ্য সত্য? *'),
          _buildDropdown(
            value: model.isTrueData.isEmpty ? null : model.isTrueData,
            items: ['হ্যাঁ', 'না'],
            hint: 'নির্বাচন করুন',
            onChanged: (value) {
              ref.read(ongikarNamaEditNotifierProvider.notifier).updateModel(
                    model.copyWith(isTrueData: value ?? ''),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('সম্মত? *'),
          _buildDropdown(
            value: model.isAgree.isEmpty ? null : model.isAgree,
            items: ['হ্যাঁ', 'না'],
            hint: 'নির্বাচন করুন',
            onChanged: (value) {
              ref.read(ongikarNamaEditNotifierProvider.notifier).updateModel(
                    model.copyWith(isAgree: value ?? ''),
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
