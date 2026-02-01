import 'package:freezed_annotation/freezed_annotation.dart';

part 'personal_info_entity.freezed.dart';

@freezed
class PersonalInfoEntity with _$PersonalInfoEntity {
  const factory PersonalInfoEntity({
    // Common Fields
    String? physicalProblem,
    String? aboutMe,
    String? myPhone,
    List<String>? myCategories,
    
    // Islamic Fields
    String? outsideClothings,
    String? isBeard,
    String? fromBeard,
    String? isTakhnu,
    String? isDailyFive,
    String? isDailyFiveJamaat,
    String? dailyFiveJamaatFrom,
    String? dailyFiveFrom,
    String? qadhaWeekly,
    String? mahramNonMahram,
    String? quranTilawat,
    String? fiqh,
    String? natokCinema,
    String? specialDeeniMehnot,
    String? mazar,
    String? islamicBooks,
    String? islamicScholars,
    String? isNeshaDrobbo,
    String? fromWhenNikhab,
    String? aboutRevertedIslam,
    String? aboutMiladQiyam,
    
    // Hindu Fields
    String? sampraday,
    String? subSampraday,
    String? caste,
    String? subCaste,
    String? gotra,
    String? beliefInGod,
    String? religiousPracticeLevel,
    String? regularPooja,
    String? vratObservance,
    String? templeVisitFrequency,
    String? ishtaDevata,
    String? kulDevata,
    String? spiritualGuide,
    String? foodHabit,
    String? alcoholConsumption,
    String? smoking,
    String? marriageView,
    String? vedicMarriageInterest,
    String? kundaliMatchingBelief,
    String? birthTime,
    String? rashi,
    String? mangalikStatus,
    String? partnerReligiousExpectation,
    String? religiousFlexibility,
    
    // Christian Fields
    String? denomination,
    String? churchName,
    String? bibleReadingFrequency,
    String? churchAttendance,
    String? churchActivityParticipation,
    String? baptismStatus,
    String? confirmationStatus,
    String? religiousValueImportance,
    String? followsChristianEthics,
    String? churchWeddingPreference,
    String? christianPartnerPreference,
    String? childrenReligiousEducation,
    String? expectsPartnerCooperation,
  }) = _PersonalInfoEntity;
}
