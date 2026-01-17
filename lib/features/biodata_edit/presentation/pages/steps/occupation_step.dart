import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../providers/biodata_edit_provider.dart';

class OccupationStep extends ConsumerStatefulWidget {
  const OccupationStep({super.key});

  @override
  ConsumerState<OccupationStep> createState() => _OccupationStepState();
}

class _OccupationStepState extends ConsumerState<OccupationStep> {
  final _formKey = GlobalKey<FormState>();
  bool _isInitialized = false;

  void _initializeFormData(dynamic model) {
    if (!_isInitialized && mounted) {
      _isInitialized = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ref.read(occupationEditNotifierProvider.notifier).updateModel(model);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncModel = ref.watch(occupationEditProvider);
    final currentState = ref.watch(occupationEditNotifierProvider);

    return asyncModel.when(
      data: (loadedModel) {
        _initializeFormData(loadedModel);
        // Check if state has been populated
        if (currentState.occupationDetails.isEmpty && loadedModel.occupationDetails.isNotEmpty) {
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
          _buildSectionTitle('পেশা *'),
          TextFormField(            key: ValueKey('occupation_${model.occupation.join(', ')}'),            initialValue: model.occupation.join(', '),
            decoration: _inputDecoration('উদাহরণ: সফটওয়্যার ইঞ্জিনিয়ার'),
            onChanged: (value) {
              ref.read(occupationEditNotifierProvider.notifier).updateModel(
                    model.copyWith(occupation: value.split(',').map((e) => e.trim()).toList()),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('পেশার বিস্তারিত বিবরণ'),
          TextFormField(            key: ValueKey('occupation_details_${model.occupationDetails}'),            initialValue: model.occupationDetails,
            decoration: _inputDecoration('কাজের প্রকৃতি, দায়িত্ব ইত্যাদি'),
            maxLines: 3,
            onChanged: (value) {
              ref.read(occupationEditNotifierProvider.notifier).updateModel(
                    model.copyWith(occupationDetails: value),
                  );
            },
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('মাসিক আয়'),
          TextFormField(            key: ValueKey('monthly_income_${model.monthlyIncome}'),            initialValue: model.monthlyIncome.toString(),
            decoration: _inputDecoration('উদাহরণ: 50000 টাকা'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              ref.read(occupationEditNotifierProvider.notifier).updateModel(
                    model.copyWith(monthlyIncome: double.tryParse(value) ?? 0.0),
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
