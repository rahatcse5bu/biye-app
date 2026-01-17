import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../providers/biodata_edit_provider.dart';

class AddressStep extends ConsumerStatefulWidget {
  const AddressStep({super.key});

  @override
  ConsumerState<AddressStep> createState() => _AddressStepState();
}

class _AddressStepState extends ConsumerState<AddressStep> {
  final _formKey = GlobalKey<FormState>();
  bool _isInitialized = false;

  void _initializeFormData(dynamic model) {
    if (!_isInitialized && mounted) {
      _isInitialized = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ref.read(addressEditNotifierProvider.notifier).updateModel(model);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncModel = ref.watch(addressEditProvider);
    final currentState = ref.watch(addressEditNotifierProvider);
    final divisions = ref.watch(divisionsProvider);
    final districts = ref.watch(districtsProvider);
    final upzilas = ref.watch(upzilasProvider);

    return asyncModel.when(
      data: (loadedModel) {
        _initializeFormData(loadedModel);
        // Check if state has been populated (not empty)
        if (currentState.permanentAddress.isEmpty && loadedModel.permanentAddress.isNotEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return _buildForm(currentState, divisions, districts, upzilas);
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

  Widget _buildForm(
    dynamic model,
    AsyncValue<List<dynamic>> divisions,
    AsyncValue<List<dynamic>> districts,
    AsyncValue<List<dynamic>> upzilas,
  ) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('স্থায়ী ঠিকানা'),
          const SizedBox(height: 16),

          _buildSectionTitle('বিভাগ *'),
          divisions.when(
            data: (divList) => _buildDropdown(
              value: model.division.isEmpty ? null : model.division,
              items: divList.map((d) => d.value as String).toList(),
              hint: 'বিভাগ নির্বাচন করুন',
              onChanged: (value) {
                ref.read(addressEditNotifierProvider.notifier).updateModel(
                      model.copyWith(division: value ?? ''),
                    );
              },
            ),
            loading: () => const CircularProgressIndicator(),
            error: (e, s) => Text('Error: $e'),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('জেলা *'),
          districts.when(
            data: (distList) => _buildDropdown(
              value: model.zilla.isEmpty ? null : model.zilla,
              items: distList.map((d) => d.value as String).toList(),
              hint: 'জেলা নির্বাচন করুন',
              onChanged: (value) {
                ref.read(addressEditNotifierProvider.notifier).updateModel(
                      model.copyWith(zilla: value ?? ''),
                    );
              },
            ),
            loading: () => const CircularProgressIndicator(),
            error: (e, s) => Text('Error: $e'),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('উপজেলা/থানা *'),
          upzilas.when(
            data: (upList) => _buildDropdown(
              value: model.upzilla.isEmpty ? null : model.upzilla,
              items: upList.map((u) => u.value as String).toList(),
              hint: 'উপজেলা নির্বাচন করুন',
              onChanged: (value) {
                ref.read(addressEditNotifierProvider.notifier).updateModel(
                      model.copyWith(upzilla: value ?? ''),
                    );
              },
            ),
            loading: () => const CircularProgressIndicator(),
            error: (e, s) => Text('Error: $e'),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('পোস্ট কোড'),
          TextFormField(
            key: ValueKey('zip_${model.zip}'),
            initialValue: model.zip > 0 ? model.zip.toString() : '',
            decoration: _inputDecoration('উদাহরণ: 1207'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final zipCode = int.tryParse(value) ?? 0;
              ref.read(addressEditNotifierProvider.notifier).updateModel(
                    model.copyWith(zip: zipCode),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('গ্রাম/এলাকা'),
          TextFormField(
            key: ValueKey('permanent_area_${model.permanentArea}'),
            initialValue: model.permanentArea,
            decoration: _inputDecoration('গ্রাম/এলাকার নাম লিখুন'),
            maxLines: 2,
            onChanged: (value) {
              ref.read(addressEditNotifierProvider.notifier).updateModel(
                    model.copyWith(permanentArea: value),
                  );
            },
          ),
          const SizedBox(height: 24),

          _buildSectionHeader('বর্তমান ঠিকানা'),
          const SizedBox(height: 16),

          _buildSectionTitle('বিভাগ *'),
          divisions.when(
            data: (divList) => _buildDropdown(
              value: model.presentDivision.isEmpty ? null : model.presentDivision,
              items: divList.map((d) => d.value as String).toList(),
              hint: 'বিভাগ নির্বাচন করুন',
              onChanged: (value) {
                ref.read(addressEditNotifierProvider.notifier).updateModel(
                      model.copyWith(presentDivision: value ?? ''),
                    );
              },
            ),
            loading: () => const CircularProgressIndicator(),
            error: (e, s) => Text('Error: $e'),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('জেলা *'),
          districts.when(
            data: (distList) => _buildDropdown(
              value: model.presentZilla.isEmpty ? null : model.presentZilla,
              items: distList.map((d) => d.value as String).toList(),
              hint: 'জেলা নির্বাচন করুন',
              onChanged: (value) {
                ref.read(addressEditNotifierProvider.notifier).updateModel(
                      model.copyWith(presentZilla: value ?? ''),
                    );
              },
            ),
            loading: () => const CircularProgressIndicator(),
            error: (e, s) => Text('Error: $e'),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('উপজেলা/থানা *'),
          upzilas.when(
            data: (upList) => _buildDropdown(
              value: model.presentUpzilla.isEmpty ? null : model.presentUpzilla,
              items: upList.map((u) => u.value as String).toList(),
              hint: 'উপজেলা নির্বাচন করুন',
              onChanged: (value) {
                ref.read(addressEditNotifierProvider.notifier).updateModel(
                      model.copyWith(presentUpzilla: value ?? ''),
                    );
              },
            ),
            loading: () => const CircularProgressIndicator(),
            error: (e, s) => Text('Error: $e'),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('পোস্ট কোড'),
          TextFormField(
            initialValue: '',
            decoration: _inputDecoration('উদাহরণ: 1207'),
            onChanged: (value) {
              // Note: Model only has one zip field, using it for permanent address
            },
          ),
          _buildSectionTitle('গ্রাম/এলাকা'),
          TextFormField(
            key: ValueKey('present_area_${model.presentArea}'),
            initialValue: model.presentArea,
            decoration: _inputDecoration('গ্রাম/এলাকার নাম লিখুন'),
            maxLines: 2,
            onChanged: (value) {
              ref.read(addressEditNotifierProvider.notifier).updateModel(
                    model.copyWith(presentArea: value),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('বেড়ে ওঠা'),
          TextFormField(            key: ValueKey('grown_up_${model.grownUp}'),            initialValue: model.grownUp,
            decoration: _inputDecoration('যেখানে বেড়ে উঠেছেন'),
            maxLines: 2,
            onChanged: (value) {
              ref.read(addressEditNotifierProvider.notifier).updateModel(
                    model.copyWith(grownUp: value),
                  );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppTheme.primaryColor,
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
