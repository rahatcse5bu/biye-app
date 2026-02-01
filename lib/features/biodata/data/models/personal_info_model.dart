import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/personal_info_entity.dart';

part 'personal_info_model.freezed.dart';
part 'personal_info_model.g.dart';

@freezed
class PersonalInfoModel with _$PersonalInfoModel {
  const PersonalInfoModel._();
  
  const factory PersonalInfoModel({
    // Common Fields
    @JsonKey(name: 'physical_problem') String? physicalProblem,
    @JsonKey(name: 'about_me') String? aboutMe,
    @JsonKey(name: 'my_phone') String? myPhone,
    @JsonKey(name: 'my_categories') List<String>? myCategories,
    
    // Islamic Fields
    @JsonKey(name: 'outside_clothings') String? outsideClothings,
    @JsonKey(name: 'isBeard') String? isBeard,
    @JsonKey(name: 'from_beard') String? fromBeard,
    @JsonKey(name: 'isTakhnu') String? isTakhnu,
    @JsonKey(name: 'isDailyFive') String? isDailyFive,
    @JsonKey(name: 'isDailyFiveJamaat') String? isDailyFiveJamaat,
    @JsonKey(name: 'daily_five_jamaat_from') String? dailyFiveJamaatFrom,
    @JsonKey(name: 'daily_five_from') String? dailyFiveFrom,
    @JsonKey(name: 'qadha_weekly') String? qadhaWeekly,
    @JsonKey(name: 'mahram_non_mahram') String? mahramNonMahram,
    @JsonKey(name: 'quran_tilawat') String? quranTilawat,
    String? fiqh,
    @JsonKey(name: 'natok_cinema') String? natokCinema,
    @JsonKey(name: 'special_deeni_mehnot') String? specialDeeniMehnot,
    String? mazar,
    @JsonKey(name: 'islamic_books') String? islamicBooks,
    @JsonKey(name: 'islamic_scholars') String? islamicScholars,
    @JsonKey(name: 'isNeshaDrobbo') String? isNeshaDrobbo,
    @JsonKey(name: 'from_when_nikhab') String? fromWhenNikhab,
    @JsonKey(name: 'about_reverted_islam') String? aboutRevertedIslam,
    @JsonKey(name: 'about_milad_qiyam') String? aboutMiladQiyam,
    
    // Hindu Fields
    String? sampraday,
    @JsonKey(name: 'sub_sampraday') String? subSampraday,
    String? caste,
    @JsonKey(name: 'sub_caste') String? subCaste,
    String? gotra,
    @JsonKey(name: 'belief_in_god') String? beliefInGod,
    @JsonKey(name: 'religious_practice_level') String? religiousPracticeLevel,
    @JsonKey(name: 'regular_pooja') String? regularPooja,
    @JsonKey(name: 'vrat_observance') String? vratObservance,
    @JsonKey(name: 'temple_visit_frequency') String? templeVisitFrequency,
    @JsonKey(name: 'ishta_devata') String? ishtaDevata,
    @JsonKey(name: 'kul_devata') String? kulDevata,
    @JsonKey(name: 'spiritual_guide') String? spiritualGuide,
    @JsonKey(name: 'food_habit') String? foodHabit,
    @JsonKey(name: 'alcohol_consumption') String? alcoholConsumption,
    String? smoking,
    @JsonKey(name: 'marriage_view') String? marriageView,
    @JsonKey(name: 'vedic_marriage_interest') String? vedicMarriageInterest,
    @JsonKey(name: 'kundali_matching_belief') String? kundaliMatchingBelief,
    @JsonKey(name: 'birth_time') String? birthTime,
    String? rashi,
    @JsonKey(name: 'mangalik_status') String? mangalikStatus,
    @JsonKey(name: 'partner_religious_expectation') String? partnerReligiousExpectation,
    @JsonKey(name: 'religious_flexibility') String? religiousFlexibility,
    
    // Christian Fields
    String? denomination,
    @JsonKey(name: 'church_name') String? churchName,
    @JsonKey(name: 'bible_reading_frequency') String? bibleReadingFrequency,
    @JsonKey(name: 'church_attendance') String? churchAttendance,
    @JsonKey(name: 'church_activity_participation') String? churchActivityParticipation,
    @JsonKey(name: 'baptism_status') String? baptismStatus,
    @JsonKey(name: 'confirmation_status') String? confirmationStatus,
    @JsonKey(name: 'religious_value_importance') String? religiousValueImportance,
    @JsonKey(name: 'follows_christian_ethics') String? followsChristianEthics,
    @JsonKey(name: 'church_wedding_preference') String? churchWeddingPreference,
    @JsonKey(name: 'christian_partner_preference') String? christianPartnerPreference,
    @JsonKey(name: 'children_religious_education') String? childrenReligiousEducation,
    @JsonKey(name: 'expects_partner_cooperation') String? expectsPartnerCooperation,
  }) = _PersonalInfoModel;
  
  factory PersonalInfoModel.fromJson(Map<String, dynamic> json) =>
      _$PersonalInfoModelFromJson(json);
  
  PersonalInfoEntity toEntity() {
    return PersonalInfoEntity(
      // Common
      physicalProblem: physicalProblem,
      aboutMe: aboutMe,
      myPhone: myPhone,
      myCategories: myCategories,
      
      // Islamic
      outsideClothings: outsideClothings,
      isBeard: isBeard,
      fromBeard: fromBeard,
      isTakhnu: isTakhnu,
      isDailyFive: isDailyFive,
      isDailyFiveJamaat: isDailyFiveJamaat,
      dailyFiveJamaatFrom: dailyFiveJamaatFrom,
      dailyFiveFrom: dailyFiveFrom,
      qadhaWeekly: qadhaWeekly,
      mahramNonMahram: mahramNonMahram,
      quranTilawat: quranTilawat,
      fiqh: fiqh,
      natokCinema: natokCinema,
      specialDeeniMehnot: specialDeeniMehnot,
      mazar: mazar,
      islamicBooks: islamicBooks,
      islamicScholars: islamicScholars,
      isNeshaDrobbo: isNeshaDrobbo,
      fromWhenNikhab: fromWhenNikhab,
      aboutRevertedIslam: aboutRevertedIslam,
      aboutMiladQiyam: aboutMiladQiyam,
      
      // Hindu
      sampraday: sampraday,
      subSampraday: subSampraday,
      caste: caste,
      subCaste: subCaste,
      gotra: gotra,
      beliefInGod: beliefInGod,
      religiousPracticeLevel: religiousPracticeLevel,
      regularPooja: regularPooja,
      vratObservance: vratObservance,
      templeVisitFrequency: templeVisitFrequency,
      ishtaDevata: ishtaDevata,
      kulDevata: kulDevata,
      spiritualGuide: spiritualGuide,
      foodHabit: foodHabit,
      alcoholConsumption: alcoholConsumption,
      smoking: smoking,
      marriageView: marriageView,
      vedicMarriageInterest: vedicMarriageInterest,
      kundaliMatchingBelief: kundaliMatchingBelief,
      birthTime: birthTime,
      rashi: rashi,
      mangalikStatus: mangalikStatus,
      partnerReligiousExpectation: partnerReligiousExpectation,
      religiousFlexibility: religiousFlexibility,
      
      // Christian
      denomination: denomination,
      churchName: churchName,
      bibleReadingFrequency: bibleReadingFrequency,
      churchAttendance: churchAttendance,
      churchActivityParticipation: churchActivityParticipation,
      baptismStatus: baptismStatus,
      confirmationStatus: confirmationStatus,
      religiousValueImportance: religiousValueImportance,
      followsChristianEthics: followsChristianEthics,
      churchWeddingPreference: churchWeddingPreference,
      christianPartnerPreference: christianPartnerPreference,
      childrenReligiousEducation: childrenReligiousEducation,
      expectsPartnerCooperation: expectsPartnerCooperation,
    );
  }
}
