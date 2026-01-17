import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../providers/biodata_edit_provider.dart';

class PersonalInfoStep extends ConsumerStatefulWidget {
  const PersonalInfoStep({super.key});

  @override
  ConsumerState<PersonalInfoStep> createState() => _PersonalInfoStepState();
}

class _PersonalInfoStepState extends ConsumerState<PersonalInfoStep> {
  final _formKey = GlobalKey<FormState>();
  bool _isInitialized = false;

  void _initializeFormData(dynamic model) {
    if (!_isInitialized && mounted) {
      _isInitialized = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ref.read(personalInfoEditNotifierProvider.notifier).updateModel(model);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncModel = ref.watch(personalInfoEditProvider);
    final currentState = ref.watch(personalInfoEditNotifierProvider);

    return asyncModel.when(
      data: (loadedModel) {
        _initializeFormData(loadedModel);
        // Check if state has been populated
        if ((currentState.isDailyFive?.isEmpty ?? true) && (loadedModel.isDailyFive?.isNotEmpty ?? false)) {
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
          _buildSectionTitle('নামাজ *'),
          TextFormField(            key: ValueKey('daily_five_${model.isDailyFive}'),            initialValue: model.isDailyFive ?? '',
            decoration: _inputDecoration('নিয়মিত/কখনো কখনো/পড়ি না'),
            onChanged: (value) {
              ref.read(personalInfoEditNotifierProvider.notifier).updateModel(
                    model.copyWith(isDailyFive: value),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('দাড়ি রাখা আছে কি? *'),
          TextFormField(            key: ValueKey('is_beard_${model.isBeard}'),            initialValue: model.isBeard ?? '',
            decoration: _inputDecoration('হ্যাঁ/না/সুন্নত অনুযায়ী রাখি'),
            onChanged: (value) {
              ref.read(personalInfoEditNotifierProvider.notifier).updateModel(
                    model.copyWith(isBeard: value),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('পোশাক পরিধান *'),
          TextFormField(
            key: ValueKey('outside_clothings_${model.outsideClothings}'),
            initialValue: model.outsideClothings ?? '',
            decoration: _inputDecoration('টাখনুর উপরে/সাধারণ পোশাক/ইসলামিক পোশাক'),
            onChanged: (value) {
              ref.read(personalInfoEditNotifierProvider.notifier).updateModel(
                    model.copyWith(outsideClothings: value),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('গায়রে মাহরাম মেনে চলা *'),
          TextFormField(            key: ValueKey('mahram_non_mahram_${model.mahramNonMahram}'),            initialValue: model.mahramNonMahram ?? '',
            decoration: _inputDecoration('হ্যাঁ/না/চেষ্টা করি'),
            onChanged: (value) {
              ref.read(personalInfoEditNotifierProvider.notifier).updateModel(
                    model.copyWith(mahramNonMahram: value),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('দ্বীনি জ্ঞান কোথা থেকে অর্জন করেছেন?'),
          TextFormField(
            key: ValueKey('islamic_books_${model.islamicBooks}'),
            initialValue: model.islamicBooks ?? '',
            decoration: _inputDecoration('মাদ্রাসা/মসজিদ/অনলাইন ইত্যাদি'),
            maxLines: 2,
            onChanged: (value) {
              ref.read(personalInfoEditNotifierProvider.notifier).updateModel(
                    model.copyWith(islamicBooks: value),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('শারীরিক অবস্থা *'),
          TextFormField(
            key: ValueKey('physical_problem_${model.physicalProblem}'),
            initialValue: model.physicalProblem ?? '',
            decoration: _inputDecoration('সুস্থ/অসুস্থ/প্রতিবন্ধী'),
            onChanged: (value) {
              ref.read(personalInfoEditNotifierProvider.notifier).updateModel(
                    model.copyWith(physicalProblem: value),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('বিশেষ রোগের বিবরণ (যদি থাকে)'),
          TextFormField(
            key: ValueKey('about_me_${model.aboutMe}'),
            initialValue: model.aboutMe ?? '',
            decoration: _inputDecoration('রোগের বিস্তারিত'),
            maxLines: 2,
            onChanged: (value) {
              ref.read(personalInfoEditNotifierProvider.notifier).updateModel(
                    model.copyWith(aboutMe: value),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('মাজহাব *'),
          _buildDropdown(
            value: (model.fiqh?.isEmpty ?? true) ? null : model.fiqh,
            items: ['হানাফি', 'শাফিঈ', 'মালিকি', 'হাম্বলি', 'অন্যান্য'],
            hint: 'নির্বাচন করুন',
            onChanged: (value) {
              ref.read(personalInfoEditNotifierProvider.notifier).updateModel(
                    model.copyWith(fiqh: value),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('বিশেষ দ্বীনি খেদমত'),
          TextFormField(            key: ValueKey('special_deeni_mehnot_${model.specialDeeniMehnot}'),            initialValue: model.specialDeeniMehnot ?? '',
            decoration: _inputDecoration('দাওয়াতি কাজ, মসজিদে খেদমত ইত্যাদি'),
            maxLines: 2,
            onChanged: (value) {
              ref.read(personalInfoEditNotifierProvider.notifier).updateModel(
                    model.copyWith(specialDeeniMehnot: value),
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
