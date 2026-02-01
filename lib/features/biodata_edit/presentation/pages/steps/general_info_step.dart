import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/constants/religion_constants.dart';
import '../../providers/biodata_edit_provider.dart';

class GeneralInfoStep extends ConsumerStatefulWidget {
  const GeneralInfoStep({super.key});

  @override
  ConsumerState<GeneralInfoStep> createState() => _GeneralInfoStepState();
}

class _GeneralInfoStepState extends ConsumerState<GeneralInfoStep> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _heightController;
  late TextEditingController _weightController;
  DateTime? _selectedDate;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _heightController = TextEditingController();
    _weightController = TextEditingController();
  }

  void _initializeFormData(dynamic model) {
    if (!_isInitialized && mounted) {
      _isInitialized = true;
      _heightController.text = model.height > 0 ? model.height.toString() : '';
      _weightController.text = model.weight > 0 ? model.weight.toString() : '';
      _selectedDate = model.dateOfBirth;
      
      // Initialize the state provider with loaded data
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ref.read(generalInfoEditNotifierProvider.notifier).updateModel(model);
        }
      });
    }
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncModel = ref.watch(generalInfoEditProvider);
    final currentState = ref.watch(generalInfoEditNotifierProvider);

    return asyncModel.when(
      data: (loadedModel) {
        // Initialize form with loaded data
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
          _buildSectionTitle('বায়োডাটার ধরন'),
          _buildDropdown(
            value: model.bioType.isEmpty ? null : model.bioType,
            items: ['পাত্রের বায়োডাটা', 'পাত্রীর বায়োডাটা'],
            hint: 'নির্বাচন করুন',
            onChanged: (value) {
              ref.read(generalInfoEditNotifierProvider.notifier).updateModel(
                    model.copyWith(bioType: value ?? ''),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('জন্ম তারিখ *'),
          InkWell(
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: _selectedDate ?? DateTime.now().subtract(const Duration(days: 365 * 18)),
                firstDate: DateTime(1950),
                lastDate: DateTime.now(),
              );
              if (date != null) {
                setState(() => _selectedDate = date);
                ref.read(generalInfoEditNotifierProvider.notifier).updateModel(
                      model.copyWith(dateOfBirth: date),
                    );
              }
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDate != null
                        ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                        : 'তারিখ নির্বাচন করুন',
                    style: TextStyle(
                      color: _selectedDate != null ? Colors.black : Colors.grey,
                    ),
                  ),
                  const Icon(Icons.calendar_today, size: 20),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('উচ্চতা (ফুট) *'),
          TextFormField(
            controller: _heightController,
            keyboardType: TextInputType.number,
            decoration: _inputDecoration('উদাহরণ: 5.5'),
            onChanged: (value) {
              final height = double.tryParse(value) ?? 0.0;
              ref.read(generalInfoEditNotifierProvider.notifier).updateModel(
                    model.copyWith(height: height),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('ওজন (কেজি) *'),
          TextFormField(
            controller: _weightController,
            keyboardType: TextInputType.number,
            decoration: _inputDecoration('উদাহরণ: 62'),
            onChanged: (value) {
              final weight = double.tryParse(value) ?? 0.0;
              ref.read(generalInfoEditNotifierProvider.notifier).updateModel(
                    model.copyWith(weight: weight),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('লিঙ্গ *'),
          _buildDropdown(
            value: model.gender.isEmpty ? null : model.gender,
            items: ['পুরুষ', 'মহিলা'],
            hint: 'নির্বাচন করুন',
            onChanged: (value) {
              ref.read(generalInfoEditNotifierProvider.notifier).updateModel(
                    model.copyWith(gender: value ?? ''),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('রক্তের গ্রুপ *'),
          _buildDropdown(
            value: model.bloodGroup.isEmpty ? null : model.bloodGroup,
            items: ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'],
            hint: 'নির্বাচন করুন',
            onChanged: (value) {
              ref.read(generalInfoEditNotifierProvider.notifier).updateModel(
                    model.copyWith(bloodGroup: value ?? ''),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('গাত্রবর্ণ *'),
          _buildDropdown(
            value: model.screenColor.isEmpty ? null : model.screenColor,
            items: ['ফর্সা', 'শ্যামলা', 'কালো', 'উজ্জ্বল শ্যামলা', 'মাঝারি'],
            hint: 'নির্বাচন করুন',
            onChanged: (value) {
              ref.read(generalInfoEditNotifierProvider.notifier).updateModel(
                    model.copyWith(screenColor: value ?? ''),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('বৈবাহিক অবস্থা *'),
          _buildDropdown(
            value: model.maritalStatus.isEmpty ? null : model.maritalStatus,
            items: ['অবিবাহিত', 'বিবাহিত', 'ডিভোর্সড', 'বিধবা/বিধুর'],
            hint: 'নির্বাচন করুন',
            onChanged: (value) {
              ref.read(generalInfoEditNotifierProvider.notifier).updateModel(
                    model.copyWith(maritalStatus: value ?? ''),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('জাতীয়তা *'),
          TextFormField(
            initialValue: model.nationality,
            decoration: _inputDecoration('উদাহরণ: বাংলাদেশী'),
            onChanged: (value) {
              ref.read(generalInfoEditNotifierProvider.notifier).updateModel(
                    model.copyWith(nationality: value),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('ধর্ম *'),
          _buildDropdown(
            value: _getReligionDisplayName(model.religion),
            items: Religion.values.map((r) => r.displayName).toList(),
            hint: 'ধর্ম নির্বাচন করুন',
            onChanged: (value) {
              final religion = Religion.fromDisplayName(value);
              ref.read(generalInfoEditNotifierProvider.notifier).updateModel(
                    model.copyWith(
                      religion: religion?.value ?? 'islam',
                      religiousType: null, // Reset religious type when religion changes
                    ),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('ধর্মীয় ধরন *'),
          _buildDropdown(
            value: _getReligiousTypeDisplayName(model.religiousType),
            items: _getReligiousTypesForReligion(model.religion),
            hint: 'ধর্মীয় ধরন নির্বাচন করুন',
            onChanged: (value) {
              final religiousType = _getReligiousTypeFromDisplayName(value, model.religion);
              ref.read(generalInfoEditNotifierProvider.notifier).updateModel(
                    model.copyWith(religiousType: religiousType),
                  );
            },
          ),
        ],
      ),
    );
  }

  String? _getReligionDisplayName(String? religionValue) {
    if (religionValue == null || religionValue.isEmpty) return null;
    final religion = Religion.fromValue(religionValue);
    return religion?.displayName;
  }

  String? _getReligiousTypeDisplayName(String? religiousTypeValue) {
    if (religiousTypeValue == null || religiousTypeValue.isEmpty) return null;
    final religiousType = ReligiousType.fromValue(religiousTypeValue);
    return religiousType?.displayName;
  }

  List<String> _getReligiousTypesForReligion(String? religionValue) {
    if (religionValue == null || religionValue.isEmpty) {
      // Default to Islam types
      return ReligiousType.getTypesForReligion(Religion.islam)
          .map((t) => t.displayName)
          .toList();
    }
    final religion = Religion.fromValue(religionValue);
    if (religion == null) {
      return ReligiousType.getTypesForReligion(Religion.islam)
          .map((t) => t.displayName)
          .toList();
    }
    return ReligiousType.getTypesForReligion(religion)
        .map((t) => t.displayName)
        .toList();
  }

  String? _getReligiousTypeFromDisplayName(String? displayName, String? religionValue) {
    if (displayName == null || displayName.isEmpty) return null;
    for (var type in ReligiousType.values) {
      if (type.displayName == displayName) {
        return type.value;
      }
    }
    return null;
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
