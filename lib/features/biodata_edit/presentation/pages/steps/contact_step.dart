import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../providers/biodata_edit_provider.dart';

class ContactStep extends ConsumerStatefulWidget {
  const ContactStep({super.key});

  @override
  ConsumerState<ContactStep> createState() => _ContactStepState();
}

class _ContactStepState extends ConsumerState<ContactStep> {
  final _formKey = GlobalKey<FormState>();
  bool _isInitialized = false;

  void _initializeFormData(dynamic model) {
    if (!_isInitialized && mounted) {
      _isInitialized = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ref.read(contactEditNotifierProvider.notifier).updateModel(model);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncModel = ref.watch(contactEditProvider);
    final currentState = ref.watch(contactEditNotifierProvider);

    return asyncModel.when(
      data: (loadedModel) {
        _initializeFormData(loadedModel);
        // Check if state has been populated
        if (currentState.fullName.isEmpty && loadedModel.fullName.isNotEmpty) {
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
          _buildSectionTitle('অভিভাবকের নাম *'),
          TextFormField(
            key: ValueKey('full_name_${model.fullName}'),
            initialValue: model.fullName,
            decoration: _inputDecoration('পূর্ণ নাম লিখুন'),
            onChanged: (value) {
              ref.read(contactEditNotifierProvider.notifier).updateModel(
                    model.copyWith(fullName: value),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('অভিভাবকের সম্পর্ক *'),
          _buildDropdown(
            value: model.relation.isEmpty ? null : model.relation,
            items: ['পিতা', 'মাতা', 'ভাই', 'চাচা', 'মামা', 'খালু', 'অন্যান্য'],
            hint: 'সম্পর্ক নির্বাচন করুন',
            onChanged: (value) {
              ref.read(contactEditNotifierProvider.notifier).updateModel(
                    model.copyWith(relation: value ?? ''),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('অভিভাবকের মোবাইল নাম্বার *'),
          TextFormField(
            key: ValueKey('family_number_${model.familyNumber}'),
            initialValue: model.familyNumber,
            decoration: _inputDecoration('উদাহরণ: ০১৭১০০০০০০০'),
            keyboardType: TextInputType.phone,
            onChanged: (value) {
              ref.read(contactEditNotifierProvider.notifier).updateModel(
                    model.copyWith(familyNumber: value),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('ইমেইল *'),
          TextFormField(
            key: ValueKey('bio_receiving_email_${model.bioReceivingEmail}'),
            initialValue: model.bioReceivingEmail,
            decoration: _inputDecoration('example@email.com'),
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              ref.read(contactEditNotifierProvider.notifier).updateModel(
                    model.copyWith(bioReceivingEmail: value),
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
