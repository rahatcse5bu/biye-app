import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../providers/biodata_edit_provider.dart';

class MaritalInfoStep extends ConsumerStatefulWidget {
  const MaritalInfoStep({super.key});

  @override
  ConsumerState<MaritalInfoStep> createState() => _MaritalInfoStepState();
}

class _MaritalInfoStepState extends ConsumerState<MaritalInfoStep> {
  final _formKey = GlobalKey<FormState>();
  bool _isInitialized = false;

  void _initializeFormData(dynamic model) {
    if (!_isInitialized && mounted) {
      _isInitialized = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ref.read(maritalInfoEditNotifierProvider.notifier).updateModel(model);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncModel = ref.watch(maritalInfoEditProvider);
    final currentState = ref.watch(maritalInfoEditNotifierProvider);

    return asyncModel.when(
      data: (loadedModel) {
        _initializeFormData(loadedModel);
        // Wait one frame for initialization
        if (!_isInitialized) {
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
          _buildSectionTitle('পরিবার কি বিবাহে সম্মত?'),
          TextFormField(
            key: ValueKey('is_family_agree_${model.isFamilyAgree}'),
            initialValue: model.isFamilyAgree ?? '',
            decoration: _inputDecoration('হ্যাঁ/না'),
            onChanged: (value) {
              ref.read(maritalInfoEditNotifierProvider.notifier).updateModel(
                    model.copyWith(isFamilyAgree: value),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('স্ত্রীকে পর্দা করতে দিবেন?'),
          TextFormField(
            key: ValueKey('is_porda_to_wife_${model.isPordaToWife}'),
            initialValue: model.isPordaToWife ?? '',
            decoration: _inputDecoration('হ্যাঁ/না'),
            onChanged: (value) {
              ref.read(maritalInfoEditNotifierProvider.notifier).updateModel(
                    model.copyWith(isPordaToWife: value),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('স্ত্রীকে পড়াশোনার অনুমতি দিবেন?'),
          TextFormField(            key: ValueKey('permission_for_study_${model.permissionForStudy}'),            initialValue: model.permissionForStudy ?? '',
            decoration: _inputDecoration('হ্যাঁ/না/শর্ত সাপেক্ষে'),
            onChanged: (value) {
              ref.read(maritalInfoEditNotifierProvider.notifier).updateModel(
                    model.copyWith(permissionForStudy: value),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('স্ত্রীকে চাকরির অনুমতি দিবেন?'),
          TextFormField(
            key: ValueKey('permission_for_job_${model.permissionForJob}'),
            initialValue: model.permissionForJob ?? '',
            decoration: _inputDecoration('হ্যাঁ/না/শর্ত সাপেক্ষে'),
            onChanged: (value) {
              ref.read(maritalInfoEditNotifierProvider.notifier).updateModel(
                    model.copyWith(permissionForJob: value),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('যৌতুক সম্পর্কে ধারণা'),
          TextFormField(            key: ValueKey('is_joutuk_${model.isJoutuk}'),            initialValue: model.isJoutuk ?? '',
            decoration: _inputDecoration('যৌতুক নেওয়া হারাম/গ্রহণযোগ্য নয়'),
            maxLines: 2,
            onChanged: (value) {
              ref.read(maritalInfoEditNotifierProvider.notifier).updateModel(
                    model.copyWith(isJoutuk: value),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('বিবাহের পর কোথায় থাকবেন?'),
          TextFormField(            key: ValueKey('after_marriage_where_${model.afterMarriageWhere}'),            initialValue: model.afterMarriageWhere ?? '',
            decoration: _inputDecoration('যৌথ পরিবার/আলাদা'),
            onChanged: (value) {
              ref.read(maritalInfoEditNotifierProvider.notifier).updateModel(
                    model.copyWith(afterMarriageWhere: value),
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
