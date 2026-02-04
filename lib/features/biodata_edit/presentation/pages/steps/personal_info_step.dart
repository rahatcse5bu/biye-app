import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/constants/religion_constants.dart';
import '../../providers/biodata_edit_provider.dart';
import '../../../data/models/personal_info_edit_model.dart';

class PersonalInfoStep extends ConsumerStatefulWidget {
  const PersonalInfoStep({super.key});

  @override
  ConsumerState<PersonalInfoStep> createState() => _PersonalInfoStepState();
}

class _PersonalInfoStepState extends ConsumerState<PersonalInfoStep> {
  final _formKey = GlobalKey<FormState>();
  bool _isInitialized = false;

  void _initializeFormData(PersonalInfoEditModel model) {
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
    final generalInfo = ref.watch(generalInfoEditNotifierProvider);
    final religion = Religion.fromValue(generalInfo.religion) ?? Religion.islam;

    return asyncModel.when(
      data: (loadedModel) {
        _initializeFormData(loadedModel);
        return _buildFormByReligion(currentState, religion);
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

  Widget _buildFormByReligion(PersonalInfoEditModel model, Religion religion) {
    switch (religion) {
      case Religion.hinduism:
        return _buildHinduForm(model);
      case Religion.christianity:
        return _buildChristianForm(model);
      case Religion.islam:
        return _buildIslamicForm(model);
    }
  }

  // ========== ISLAMIC FORM ==========
  Widget _buildIslamicForm(PersonalInfoEditModel model) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('ইসলামিক ব্যক্তিগত তথ্য'),
          const SizedBox(height: 16),

          _buildSectionTitle('নামাজ *'),
          _buildDropdown(
            value: model.isDailyFive,
            items: ['নিয়মিত পড়ি', 'কখনো কখনো', 'পড়ি না', 'চেষ্টা করছি'],
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(isDailyFive: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('দাড়ি রাখা আছে কি? *'),
          _buildDropdown(
            value: model.isBeard,
            items: ['হ্যাঁ, সুন্নত অনুযায়ী', 'হ্যাঁ', 'না', 'রাখার চেষ্টা করছি'],
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(isBeard: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('পোশাক পরিধান *'),
          _buildDropdown(
            value: model.outsideClothings,
            items: ['টাখনুর উপরে', 'সাধারণ পোশাক', 'ইসলামিক পোশাক', 'টুপি/পাগড়ি পরি'],
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(outsideClothings: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('গায়রে মাহরাম মেনে চলা *'),
          _buildDropdown(
            value: model.mahramNonMahram,
            items: ['হ্যাঁ, কঠোরভাবে মানি', 'চেষ্টা করি', 'মানি না'],
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(mahramNonMahram: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('মাজহাব *'),
          _buildDropdown(
            value: model.fiqh,
            items: ['হানাফি', 'শাফিঈ', 'মালিকি', 'হাম্বলি', 'আহলে হাদিস', 'অন্যান্য'],
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(fiqh: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('কুরআন তিলাওয়াত'),
          _buildDropdown(
            value: model.quranTilawat,
            items: ['নিয়মিত', 'মাঝে মাঝে', 'পড়ি না'],
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(quranTilawat: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('দ্বীনি জ্ঞান কোথা থেকে অর্জন করেছেন?'),
          TextFormField(
            key: ValueKey('islamic_books_${model.islamicBooks}'),
            initialValue: model.islamicBooks ?? '',
            decoration: _inputDecoration('মাদ্রাসা/মসজিদ/অনলাইন ইত্যাদি'),
            maxLines: 2,
            onChanged: (value) => _updateModel(model.copyWith(islamicBooks: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('বিশেষ দ্বীনি খেদমত'),
          TextFormField(
            key: ValueKey('special_deeni_mehnot_${model.specialDeeniMehnot}'),
            initialValue: model.specialDeeniMehnot ?? '',
            decoration: _inputDecoration('দাওয়াতি কাজ, মসজিদে খেদমত ইত্যাদি'),
            maxLines: 2,
            onChanged: (value) => _updateModel(model.copyWith(specialDeeniMehnot: value)),
          ),
          const SizedBox(height: 16),

          _buildCommonFields(model),
        ],
      ),
    );
  }

  // ========== HINDU FORM ==========
  Widget _buildHinduForm(PersonalInfoEditModel model) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('হিন্দু ধর্মীয় তথ্য'),
          const SizedBox(height: 16),

          // ধর্মীয় পরিচয়
          _buildSubSectionTitle('ধর্মীয় পরিচয়'),
          const SizedBox(height: 8),

          _buildSectionTitle('সম্প্রদায় / শাখা *'),
          _buildDropdown(
            value: model.sampraday,
            items: HinduConstants.sampradays,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(sampraday: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('উপ-সম্প্রদায়'),
          _buildDropdown(
            value: model.subSampraday,
            items: HinduConstants.subSampradays,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(subSampraday: value)),
          ),
          const SizedBox(height: 16),

          // জাতি ও গোত্র
          _buildSubSectionTitle('জাতি ও গোত্র'),
          const SizedBox(height: 8),

          _buildSectionTitle('বর্ণ / জাতি'),
          _buildDropdown(
            value: model.caste,
            items: HinduConstants.castes,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(caste: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('উপ-জাতি'),
          _buildDropdown(
            value: model.subCaste,
            items: HinduConstants.subCastes,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(subCaste: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('গোত্র'),
          _buildDropdown(
            value: model.gotra,
            items: HinduConstants.gotras,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(gotra: value)),
          ),
          const SizedBox(height: 16),

          // ধর্মীয় অনুশীলন
          _buildSubSectionTitle('ধর্মীয় অনুশীলন'),
          const SizedBox(height: 8),

          _buildSectionTitle('ঈশ্বরে বিশ্বাস আছে কি? *'),
          _buildDropdown(
            value: model.beliefInGod,
            items: CommonReligiousConstants.godBeliefOptions,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(beliefInGod: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('ধর্মাচরণ কেমন? *'),
          _buildDropdown(
            value: model.religiousPracticeLevel,
            items: HinduConstants.religiousPracticeLevels,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(religiousPracticeLevel: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('নিয়মিত পূজা করেন কি?'),
          _buildDropdown(
            value: model.regularPooja,
            items: HinduConstants.poojaFrequencies,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(regularPooja: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('ব্রত বা উপবাস পালন করেন কি?'),
          _buildDropdown(
            value: model.vratObservance,
            items: HinduConstants.vratObservances,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(vratObservance: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('মন্দিরে যান কি?'),
          _buildDropdown(
            value: model.templeVisitFrequency,
            items: HinduConstants.templeVisitFrequencies,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(templeVisitFrequency: value)),
          ),
          const SizedBox(height: 16),

          // উপাস্য দেবতা
          _buildSubSectionTitle('উপাস্য দেবতা'),
          const SizedBox(height: 8),

          _buildSectionTitle('ইষ্ট দেবতা'),
          _buildDropdown(
            value: model.ishtaDevata,
            items: HinduConstants.deities,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(ishtaDevata: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('কুলদেবতা / কুলদেবী'),
          _buildDropdown(
            value: model.kulDevata,
            items: HinduConstants.deities,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(kulDevata: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('গুরু বা আধ্যাত্মিক পথপ্রদর্শক'),
          TextFormField(
            key: ValueKey('spiritual_guide_${model.spiritualGuide}'),
            initialValue: model.spiritualGuide ?? '',
            decoration: _inputDecoration('গুরুর নাম বা নির্দিষ্ট নন'),
            onChanged: (value) => _updateModel(model.copyWith(spiritualGuide: value)),
          ),
          const SizedBox(height: 16),

          // খাদ্যাভ্যাস ও জীবনধারা
          _buildSubSectionTitle('খাদ্যাভ্যাস ও জীবনধারা'),
          const SizedBox(height: 8),

          _buildSectionTitle('খাদ্যাভ্যাস *'),
          _buildDropdown(
            value: model.foodHabit,
            items: HinduConstants.foodHabits,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(foodHabit: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('মদ্যপান করেন কি?'),
          _buildDropdown(
            value: model.alcoholConsumption,
            items: CommonReligiousConstants.alcoholConsumptionOptions,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(alcoholConsumption: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('ধূমপান করেন কি?'),
          _buildDropdown(
            value: model.smoking,
            items: CommonReligiousConstants.smokingOptions,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(smoking: value)),
          ),
          const SizedBox(height: 16),

          // বিবাহ সম্পর্কিত
          _buildSubSectionTitle('বিবাহ সম্পর্কিত বিশ্বাস'),
          const SizedBox(height: 8),

          _buildSectionTitle('বিবাহ সম্পর্কে দৃষ্টিভঙ্গি'),
          _buildDropdown(
            value: model.marriageView,
            items: ['বিবাহ একটি পবিত্র সংস্কার', 'সামাজিক চুক্তি', 'অন্যান্য'],
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(marriageView: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('হিন্দু বৈদিক মতে বিবাহে আগ্রহী কি?'),
          _buildDropdown(
            value: model.vedicMarriageInterest,
            items: ['হ্যাঁ', 'না', 'ঐচ্ছিক'],
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(vedicMarriageInterest: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('কুণ্ডলী মিলানে বিশ্বাস'),
          _buildDropdown(
            value: model.kundaliMatchingBelief,
            items: HinduConstants.kundaliBeliefs,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(kundaliMatchingBelief: value)),
          ),
          const SizedBox(height: 16),

          // জ্যোতিষ তথ্য
          _buildSubSectionTitle('জন্ম ও জ্যোতিষ তথ্য (ঐচ্ছিক)'),
          const SizedBox(height: 8),

          _buildSectionTitle('জন্ম সময়'),
          TextFormField(
            key: ValueKey('birth_time_${model.birthTime}'),
            initialValue: model.birthTime ?? '',
            decoration: _inputDecoration('উদাহরণ: সকাল ১০:৩০'),
            onChanged: (value) => _updateModel(model.copyWith(birthTime: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('রাশি'),
          _buildDropdown(
            value: model.rashi,
            items: HinduConstants.rashis,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(rashi: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('মাঙ্গলিক অবস্থা'),
          _buildDropdown(
            value: model.mangalikStatus,
            items: HinduConstants.mangalikStatuses,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(mangalikStatus: value)),
          ),
          const SizedBox(height: 16),

          // প্রত্যাশা
          _buildSubSectionTitle('জীবনসঙ্গীর কাছ থেকে ধর্মীয় প্রত্যাশা'),
          const SizedBox(height: 8),

          _buildSectionTitle('সঙ্গীর কাছে ধর্মীয় প্রত্যাশা'),
          TextFormField(
            key: ValueKey('partner_religious_expectation_${model.partnerReligiousExpectation}'),
            initialValue: model.partnerReligiousExpectation ?? '',
            decoration: _inputDecoration('হিন্দু ধর্ম ও পারিবারিক মূল্যবোধের প্রতি শ্রদ্ধাশীল'),
            maxLines: 2,
            onChanged: (value) => _updateModel(model.copyWith(partnerReligiousExpectation: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('ধর্মীয় বিষয়ে নমনীয়তা'),
          _buildDropdown(
            value: model.religiousFlexibility,
            items: CommonReligiousConstants.religiousFlexibilityOptions,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(religiousFlexibility: value)),
          ),
          const SizedBox(height: 16),

          _buildCommonFields(model),
        ],
      ),
    );
  }

  // ========== CHRISTIAN FORM ==========
  Widget _buildChristianForm(PersonalInfoEditModel model) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('খ্রিস্টান ধর্মীয় তথ্য'),
          const SizedBox(height: 16),

          // ধর্মীয় পরিচয়
          _buildSubSectionTitle('ধর্মীয় পরিচয়'),
          const SizedBox(height: 8),

          _buildSectionTitle('সম্প্রদায় (Denomination) *'),
          _buildDropdown(
            value: model.denomination,
            items: ChristianConstants.denominations,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(denomination: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('চার্চের নাম'),
          TextFormField(
            key: ValueKey('church_name_${model.churchName}'),
            initialValue: model.churchName ?? '',
            decoration: _inputDecoration('আপনার চার্চের নাম'),
            onChanged: (value) => _updateModel(model.copyWith(churchName: value)),
          ),
          const SizedBox(height: 16),

          // বিশ্বাস ও আধ্যাত্মিকতা
          _buildSubSectionTitle('বিশ্বাস ও আধ্যাত্মিকতা'),
          const SizedBox(height: 8),

          _buildSectionTitle('ঈশ্বরে বিশ্বাস *'),
          _buildDropdown(
            value: model.beliefInGod,
            items: ['হ্যাঁ, যীশু খ্রিস্টে দৃঢ় বিশ্বাসী', 'হ্যাঁ', 'মধ্যম মাত্রায়'],
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(beliefInGod: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('ধর্মচর্চার মাত্রা *'),
          _buildDropdown(
            value: model.religiousPracticeLevel,
            items: ChristianConstants.religiousPracticeLevels,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(religiousPracticeLevel: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('বাইবেল পাঠ করেন কি?'),
          _buildDropdown(
            value: model.bibleReadingFrequency,
            items: ChristianConstants.bibleReadingFrequencies,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(bibleReadingFrequency: value)),
          ),
          const SizedBox(height: 16),

          // চার্চ ও উপাসনা
          _buildSubSectionTitle('চার্চ ও উপাসনা'),
          const SizedBox(height: 8),

          _buildSectionTitle('নিয়মিত চার্চে যান কি?'),
          _buildDropdown(
            value: model.churchAttendance,
            items: ChristianConstants.churchAttendances,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(churchAttendance: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('চার্চের কার্যক্রমে যুক্ত আছেন কি?'),
          _buildDropdown(
            value: model.churchActivityParticipation,
            items: ChristianConstants.churchParticipations,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(churchActivityParticipation: value)),
          ),
          const SizedBox(height: 16),

          // ধর্মীয় আচার
          _buildSubSectionTitle('ধর্মীয় আচার ও উৎসব'),
          const SizedBox(height: 8),

          _buildSectionTitle('বাপ্তিস্ম গ্রহণ করেছেন কি? *'),
          _buildDropdown(
            value: model.baptismStatus,
            items: ChristianConstants.baptismStatuses,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(baptismStatus: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('কনফার্মেশন হয়েছে কি?'),
          _buildDropdown(
            value: model.confirmationStatus,
            items: ChristianConstants.confirmationStatuses,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(confirmationStatus: value)),
          ),
          const SizedBox(height: 16),

          // জীবনধারা
          _buildSubSectionTitle('জীবনধারা ও মূল্যবোধ'),
          const SizedBox(height: 8),

          _buildSectionTitle('ধর্মীয় মূল্যবোধ জীবনে কতটা গুরুত্বপূর্ণ?'),
          _buildDropdown(
            value: model.religiousValueImportance,
            items: ChristianConstants.religiousValueImportances,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(religiousValueImportance: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('খ্রিস্টীয় নৈতিকতা অনুসরণ করেন কি?'),
          _buildDropdown(
            value: model.followsChristianEthics,
            items: ['হ্যাঁ', 'চেষ্টা করি', 'না'],
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(followsChristianEthics: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('মদ্যপান সম্পর্কে দৃষ্টিভঙ্গি'),
          _buildDropdown(
            value: model.alcoholConsumption,
            items: CommonReligiousConstants.alcoholConsumptionOptions,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(alcoholConsumption: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('ধূমপান'),
          _buildDropdown(
            value: model.smoking,
            items: CommonReligiousConstants.smokingOptions,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(smoking: value)),
          ),
          const SizedBox(height: 16),

          // বিবাহ সম্পর্কিত
          _buildSubSectionTitle('বিবাহ সম্পর্কিত বিশ্বাস'),
          const SizedBox(height: 8),

          _buildSectionTitle('বিবাহ সম্পর্কে দৃষ্টিভঙ্গি'),
          _buildDropdown(
            value: model.marriageView,
            items: ['বিবাহ ঈশ্বরপ্রদত্ত একটি পবিত্র বন্ধন', 'সামাজিক চুক্তি', 'অন্যান্য'],
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(marriageView: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('চার্চে বিবাহে আগ্রহী কি?'),
          _buildDropdown(
            value: model.churchWeddingPreference,
            items: ChristianConstants.churchWeddingPreferences,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(churchWeddingPreference: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('খ্রিস্টান জীবনসঙ্গী কাম্য কি?'),
          _buildDropdown(
            value: model.christianPartnerPreference,
            items: ChristianConstants.christianPartnerPreferences,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(christianPartnerPreference: value)),
          ),
          const SizedBox(height: 16),

          // সন্তান পালন
          _buildSubSectionTitle('ধর্মীয় শিক্ষা ও সন্তান পালন'),
          const SizedBox(height: 8),

          _buildSectionTitle('ভবিষ্যৎ সন্তানের ধর্মীয় শিক্ষা সম্পর্কে মতামত'),
          _buildDropdown(
            value: model.childrenReligiousEducation,
            items: ChristianConstants.childrenReligiousEducationPreferences,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(childrenReligiousEducation: value)),
          ),
          const SizedBox(height: 16),

          // প্রত্যাশা
          _buildSubSectionTitle('জীবনসঙ্গীর কাছ থেকে ধর্মীয় প্রত্যাশা'),
          const SizedBox(height: 8),

          _buildSectionTitle('জীবনসঙ্গীর কাছে ধর্মীয় প্রত্যাশা'),
          TextFormField(
            key: ValueKey('partner_religious_expectation_${model.partnerReligiousExpectation}'),
            initialValue: model.partnerReligiousExpectation ?? '',
            decoration: _inputDecoration('খ্রিস্টীয় বিশ্বাস ও চার্চের প্রতি শ্রদ্ধাশীল'),
            maxLines: 2,
            onChanged: (value) => _updateModel(model.copyWith(partnerReligiousExpectation: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('ধর্মচর্চায় সহযোগিতা প্রত্যাশিত কি?'),
          _buildDropdown(
            value: model.expectsPartnerCooperation,
            items: ['হ্যাঁ', 'ঐচ্ছিক', 'না'],
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(expectsPartnerCooperation: value)),
          ),
          const SizedBox(height: 16),

          _buildSectionTitle('ধর্মীয় বিষয়ে নমনীয়তা'),
          _buildDropdown(
            value: model.religiousFlexibility,
            items: CommonReligiousConstants.religiousFlexibilityOptions,
            hint: 'নির্বাচন করুন',
            onChanged: (value) => _updateModel(model.copyWith(religiousFlexibility: value)),
          ),
          const SizedBox(height: 16),

          _buildCommonFields(model),
        ],
      ),
    );
  }

  // ========== COMMON FIELDS (all religions) ==========
  Widget _buildCommonFields(PersonalInfoEditModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSubSectionTitle('সাধারণ তথ্য'),
        const SizedBox(height: 8),

        _buildSectionTitle('শারীরিক অবস্থা *'),
        _buildDropdown(
          value: model.physicalProblem,
          items: ['সুস্থ', 'সামান্য সমস্যা আছে', 'দীর্ঘস্থায়ী রোগ আছে', 'প্রতিবন্ধী'],
          hint: 'নির্বাচন করুন',
          onChanged: (value) => _updateModel(model.copyWith(physicalProblem: value)),
        ),
        const SizedBox(height: 16),

        _buildSectionTitle('নিজের সম্পর্কে'),
        TextFormField(
          key: ValueKey('about_me_${model.aboutMe}'),
          initialValue: model.aboutMe ?? '',
          decoration: _inputDecoration('আপনার সম্পর্কে কিছু লিখুন...'),
          maxLines: 3,
          onChanged: (value) => _updateModel(model.copyWith(aboutMe: value)),
        ),
      ],
    );
  }

  void _updateModel(PersonalInfoEditModel model) {
    ref.read(personalInfoEditNotifierProvider.notifier).updateModel(model);
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: AppTheme.primaryColor),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubSectionTitle(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: AppTheme.primaryColor, width: 3),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
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
