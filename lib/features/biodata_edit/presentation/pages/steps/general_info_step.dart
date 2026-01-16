import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_theme.dart';
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

  @override
  void initState() {
    super.initState();
    _heightController = TextEditingController();
    _weightController = TextEditingController();
    
    // Load existing data
    Future.microtask(() {
      final asyncData = ref.read(generalInfoEditProvider);
      asyncData.whenData((model) {
        if (mounted) {
          ref.read(generalInfoEditNotifierProvider.notifier).updateModel(model);
          _heightController.text = model.height.toString();
          _weightController.text = model.weight.toString();
          _selectedDate = model.dateOfBirth;
        }
      });
    });
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(generalInfoEditNotifierProvider);

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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
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
