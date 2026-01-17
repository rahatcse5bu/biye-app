import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/biodata_edit_provider.dart';
import 'steps/general_info_step.dart';
import 'steps/address_step.dart';
import 'steps/educational_qualification_step.dart';
import 'steps/family_status_step.dart';
import 'steps/personal_info_step.dart';
import 'steps/occupation_step.dart';
import 'steps/marital_info_step.dart';
import 'steps/expected_partner_step.dart';
import 'steps/contact_step.dart';
import 'steps/ongikar_nama_step.dart';

class BiodataEditPage extends ConsumerWidget {
  const BiodataEditPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStep = ref.watch(currentStepNotifierProvider);

    final steps = [
      _StepInfo(
        title: 'সাধারন তথ্য',
        icon: Icons.person_outline,
        widget: const GeneralInfoStep(),
      ),
      _StepInfo(
        title: 'ঠিকানা',
        icon: Icons.location_on_outlined,
        widget: const AddressStep(),
      ),
      _StepInfo(
        title: 'শিক্ষাগত যোগ্যতা',
        icon: Icons.school_outlined,
        widget: const EducationalQualificationStep(),
      ),
      _StepInfo(
        title: 'পারিবারিক তথ্য',
        icon: Icons.family_restroom_outlined,
        widget: const FamilyStatusStep(),
      ),
      _StepInfo(
        title: 'ব্যক্তিগত তথ্য',
        icon: Icons.info_outline,
        widget: const PersonalInfoStep(),
      ),
      _StepInfo(
        title: 'পেশাগত তথ্য',
        icon: Icons.work_outline,
        widget: const OccupationStep(),
      ),
      _StepInfo(
        title: 'বিবাহ সম্পর্কিত তথ্য',
        icon: Icons.favorite_outline,
        widget: const MaritalInfoStep(),
      ),
      _StepInfo(
        title: 'প্রত্যাশিত জীবনসঙ্গী',
        icon: Icons.people_outline,
        widget: const ExpectedPartnerStep(),
      ),
      _StepInfo(
        title: 'যোগাযোগ',
        icon: Icons.contact_phone_outlined,
        widget: const ContactStep(),
      ),
      _StepInfo(
        title: 'অঙ্গীকারনামা',
        icon: Icons.verified_outlined,
        widget: const OngikarNamaStep(),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('বায়োডাটা সম্পাদনা'),
        elevation: 0,
        backgroundColor: AppTheme.primaryColor,
      ),
      body: Column(
        children: [
          // Progress Indicator
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ধাপ ${currentStep + 1}/${steps.length}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    Text(
                      '${((currentStep + 1) / steps.length * 100).toStringAsFixed(0)}%',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.secondaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: (currentStep + 1) / steps.length,
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppTheme.primaryColor,
                  ),
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(3),
                ),
                const SizedBox(height: 8),
                Text(
                  steps[currentStep].title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Step Navigator
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: steps.length,
                itemBuilder: (context, index) {
                  final isActive = index == currentStep;
                  final isCompleted = index < currentStep;
                  
                  return GestureDetector(
                    onTap: () {
                      ref.read(currentStepNotifierProvider.notifier).goToStep(index);
                    },
                    child: Container(
                      width: 70,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isActive
                                  ? AppTheme.primaryColor
                                  : isCompleted
                                      ? AppTheme.secondaryColor
                                      : Colors.grey[300],
                              border: Border.all(
                                color: isActive
                                    ? AppTheme.primaryColor
                                    : isCompleted
                                        ? AppTheme.secondaryColor
                                        : Colors.grey[400]!,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: isCompleted
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 20,
                                    )
                                  : Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        color: isActive
                                            ? Colors.white
                                            : Colors.grey[600],
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            steps[index].title,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                              color: isActive
                                  ? AppTheme.primaryColor
                                  : Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Step Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: steps[currentStep].widget,
            ),
          ),

          // Navigation Buttons
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                if (currentStep > 0)
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ref.read(currentStepNotifierProvider.notifier).previousStep();
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('পূর্ববর্তী'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.primaryColor,
                        side: const BorderSide(color: AppTheme.primaryColor),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                if (currentStep > 0) const SizedBox(width: 12),
                Expanded(
                  flex: currentStep == 0 ? 1 : 1,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      if (currentStep < steps.length - 1) {
                        // Save current step
                        try {
                          await _saveCurrentStep(ref, currentStep);
                          ref.read(currentStepNotifierProvider.notifier).nextStep();
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('সংরক্ষণ ব্যর্থ: ${e.toString()}'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      } else {
                        // Final save and exit
                        try {
                          await _saveCurrentStep(ref, currentStep);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('বায়োডাটা সফলভাবে সংরক্ষিত হয়েছে'),
                                backgroundColor: AppTheme.secondaryColor,
                              ),
                            );
                            Navigator.of(context).pop();
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('সংরক্ষণ ব্যর্থ: ${e.toString()}'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      }
                    },
                    icon: Icon(
                      currentStep < steps.length - 1
                          ? Icons.arrow_forward
                          : Icons.check,
                    ),
                    label: Text(
                      currentStep < steps.length - 1 ? 'সংরক্ষণ ও পরবর্তী' : 'সম্পন্ন করুন',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveCurrentStep(WidgetRef ref, int step) async {
    switch (step) {
      case 0:
        await ref.read(generalInfoEditNotifierProvider.notifier).save();
        break;
      case 1:
        await ref.read(addressEditNotifierProvider.notifier).save();
        break;
      case 2:
        await ref
            .read(educationalQualificationEditNotifierProvider.notifier)
            .save();
        break;
      case 3:
        await ref.read(familyStatusEditNotifierProvider.notifier).save();
        break;
      case 4:
        await ref.read(personalInfoEditNotifierProvider.notifier).save();
        break;
      case 5:
        await ref.read(occupationEditNotifierProvider.notifier).save();
        break;
      case 6:
        await ref.read(maritalInfoEditNotifierProvider.notifier).save();
        break;
      case 7:
        await ref.read(expectedPartnerEditNotifierProvider.notifier).save();
        break;
      case 8:
        await ref.read(contactEditNotifierProvider.notifier).save();
        break;
      case 9:
        await ref.read(ongikarNamaEditNotifierProvider.notifier).save();
        break;
    }
  }
}

class _StepInfo {
  final String title;
  final IconData icon;
  final Widget widget;

  _StepInfo({
    required this.title,
    required this.icon,
    required this.widget,
  });
}
