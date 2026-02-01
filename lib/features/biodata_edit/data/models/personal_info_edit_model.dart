/// Unified Personal Info Edit Model supporting Islam, Hinduism, and Christianity
class PersonalInfoEditModel {
  final String? id;
  final String? userId;
  
  // ========== COMMON FIELDS ==========
  final String? physicalProblem;
  final String? aboutMe;
  final String? myPhone;
  
  // ========== ISLAMIC FIELDS ==========
  final String? outsideClothings;
  final String? isBeard;
  final String? fromBeard;
  final String? isTakhnu;
  final String? isDailyFive;
  final String? isDailyFiveJamaat;
  final String? dailyFiveJamaatFrom;
  final String? dailyFiveFrom;
  final String? qadhaWeekly;
  final String? mahramNonMahram;
  final String? quranTilawat;
  final String? fiqh;
  final String? natokCinema;
  final String? specialDeeniMehnot;
  final String? mazar;
  final String? islamicBooks;
  final String? islamicScholars;
  final List<String> myCategories;
  final String? isNeshaDrobbo;
  final String? fromWhenNikhab;
  final String? aboutRevertedIslam;
  final String? aboutMiladQiyam;
  
  // ========== HINDU FIELDS ==========
  // ধর্মীয় পরিচয় (Religious Identity)
  final String? sampraday; // বৈষ্ণব / শৈব / শাক্ত / স্মার্ত
  final String? subSampraday; // ইসকন / আর্য সমাজ / রামকৃষ্ণ মিশন
  
  // জাতি ও গোত্র (Caste & Gotra)
  final String? caste; // ব্রাহ্মণ / ক্ষত্রিয় / বৈশ্য / শূদ্র
  final String? subCaste;
  final String? community;
  final String? gotra;
  
  // ধর্মীয় অনুশীলন (Religious Practice)
  final String? beliefInGod;
  final String? religiousPracticeLevel;
  final String? regularPooja;
  final String? vratObservance;
  final String? templeVisitFrequency;
  
  // উপাস্য দেবতা (Deities)
  final String? ishtaDevata;
  final String? kulDevata;
  final String? spiritualGuide;
  
  // উৎসব ও আচার (Festivals & Rituals)
  final List<String> festivalsCelebrated;
  final String? followsFamilyRituals;
  final String? postMarriageRitualsView;
  
  // খাদ্যাভ্যাস ও জীবনধারা (Food & Lifestyle)
  final String? foodHabit;
  final String? alcoholConsumption;
  final String? smoking;
  final String? sattvicLifestyle;
  
  // বিবাহ সম্পর্কিত (Marriage)
  final String? marriageView;
  final String? vedicMarriageInterest;
  final String? kundaliMatchingBelief;
  
  // জ্যোতিষ (Astrology)
  final String? birthTime;
  final String? birthPlace;
  final String? rashi;
  final String? nakshatra;
  final String? mangalikStatus;
  
  // প্রত্যাশা (Expectations)
  final String? partnerReligiousExpectation;
  final String? partnerWillingnessToLearnRituals;
  final String? religiousFlexibility;
  
  // ========== CHRISTIAN FIELDS ==========
  final String? denomination;
  final String? churchName;
  final String? bibleReadingFrequency;
  final String? churchAttendance;
  final String? prayerParticipation;
  final String? churchActivityParticipation;
  final String? baptismStatus;
  final String? confirmationStatus;
  final String? religiousValueImportance;
  final String? followsChristianEthics;
  final String? churchBasedFamilyPreference;
  final String? churchWeddingPreference;
  final String? christianPartnerPreference;
  final String? childrenReligiousEducation;
  final String? churchBasedEducationBelief;
  final String? expectsPartnerCooperation;

  PersonalInfoEditModel({
    this.id,
    this.userId,
    // Common
    this.physicalProblem,
    this.aboutMe,
    this.myPhone,
    // Islamic
    this.outsideClothings,
    this.isBeard,
    this.fromBeard,
    this.isTakhnu,
    this.isDailyFive,
    this.isDailyFiveJamaat,
    this.dailyFiveJamaatFrom,
    this.dailyFiveFrom,
    this.qadhaWeekly,
    this.mahramNonMahram,
    this.quranTilawat,
    this.fiqh,
    this.natokCinema,
    this.specialDeeniMehnot,
    this.mazar,
    this.islamicBooks,
    this.islamicScholars,
    this.myCategories = const [],
    this.isNeshaDrobbo,
    this.fromWhenNikhab,
    this.aboutRevertedIslam,
    this.aboutMiladQiyam,
    // Hindu
    this.sampraday,
    this.subSampraday,
    this.caste,
    this.subCaste,
    this.community,
    this.gotra,
    this.beliefInGod,
    this.religiousPracticeLevel,
    this.regularPooja,
    this.vratObservance,
    this.templeVisitFrequency,
    this.ishtaDevata,
    this.kulDevata,
    this.spiritualGuide,
    this.festivalsCelebrated = const [],
    this.followsFamilyRituals,
    this.postMarriageRitualsView,
    this.foodHabit,
    this.alcoholConsumption,
    this.smoking,
    this.sattvicLifestyle,
    this.marriageView,
    this.vedicMarriageInterest,
    this.kundaliMatchingBelief,
    this.birthTime,
    this.birthPlace,
    this.rashi,
    this.nakshatra,
    this.mangalikStatus,
    this.partnerReligiousExpectation,
    this.partnerWillingnessToLearnRituals,
    this.religiousFlexibility,
    // Christian
    this.denomination,
    this.churchName,
    this.bibleReadingFrequency,
    this.churchAttendance,
    this.prayerParticipation,
    this.churchActivityParticipation,
    this.baptismStatus,
    this.confirmationStatus,
    this.religiousValueImportance,
    this.followsChristianEthics,
    this.churchBasedFamilyPreference,
    this.churchWeddingPreference,
    this.christianPartnerPreference,
    this.childrenReligiousEducation,
    this.churchBasedEducationBelief,
    this.expectsPartnerCooperation,
  });

  factory PersonalInfoEditModel.fromJson(Map<String, dynamic> json) {
    return PersonalInfoEditModel(
      id: json['_id']?.toString(),
      userId: json['user']?.toString(),
      // Common
      physicalProblem: json['physical_problem']?.toString(),
      aboutMe: json['about_me']?.toString(),
      myPhone: json['my_phone']?.toString(),
      // Islamic
      outsideClothings: json['outside_clothings']?.toString(),
      isBeard: json['isBeard']?.toString(),
      fromBeard: json['from_beard']?.toString(),
      isTakhnu: json['isTakhnu']?.toString(),
      isDailyFive: json['isDailyFive']?.toString(),
      isDailyFiveJamaat: json['isDailyFiveJamaat']?.toString(),
      dailyFiveJamaatFrom: json['daily_five_jamaat_from']?.toString(),
      dailyFiveFrom: json['daily_five_from']?.toString(),
      qadhaWeekly: json['qadha_weekly']?.toString(),
      mahramNonMahram: json['mahram_non_mahram']?.toString(),
      quranTilawat: json['quran_tilawat']?.toString(),
      fiqh: json['fiqh']?.toString(),
      natokCinema: json['natok_cinema']?.toString(),
      specialDeeniMehnot: json['special_deeni_mehnot']?.toString(),
      mazar: json['mazar']?.toString(),
      islamicBooks: json['islamic_books']?.toString(),
      islamicScholars: json['islamic_scholars']?.toString(),
      myCategories: json['my_categories'] != null
          ? List<String>.from(json['my_categories'].map((x) => x.toString()))
          : [],
      isNeshaDrobbo: json['isNeshaDrobbo']?.toString(),
      fromWhenNikhab: json['from_when_nikhab']?.toString(),
      aboutRevertedIslam: json['about_reverted_islam']?.toString(),
      aboutMiladQiyam: json['about_milad_qiyam']?.toString(),
      // Hindu
      sampraday: json['sampraday']?.toString(),
      subSampraday: json['sub_sampraday']?.toString(),
      caste: json['caste']?.toString(),
      subCaste: json['sub_caste']?.toString(),
      community: json['community']?.toString(),
      gotra: json['gotra']?.toString(),
      beliefInGod: json['belief_in_god']?.toString(),
      religiousPracticeLevel: json['religious_practice_level']?.toString(),
      regularPooja: json['regular_pooja']?.toString(),
      vratObservance: json['vrat_observance']?.toString(),
      templeVisitFrequency: json['temple_visit_frequency']?.toString(),
      ishtaDevata: json['ishta_devata']?.toString(),
      kulDevata: json['kul_devata']?.toString(),
      spiritualGuide: json['spiritual_guide']?.toString(),
      festivalsCelebrated: json['festivals_celebrated'] != null
          ? List<String>.from(json['festivals_celebrated'].map((x) => x.toString()))
          : [],
      followsFamilyRituals: json['follows_family_rituals']?.toString(),
      postMarriageRitualsView: json['post_marriage_rituals_view']?.toString(),
      foodHabit: json['food_habit']?.toString(),
      alcoholConsumption: json['alcohol_consumption']?.toString(),
      smoking: json['smoking']?.toString(),
      sattvicLifestyle: json['sattvic_lifestyle']?.toString(),
      marriageView: json['marriage_view']?.toString(),
      vedicMarriageInterest: json['vedic_marriage_interest']?.toString(),
      kundaliMatchingBelief: json['kundali_matching_belief']?.toString(),
      birthTime: json['birth_time']?.toString(),
      birthPlace: json['birth_place']?.toString(),
      rashi: json['rashi']?.toString(),
      nakshatra: json['nakshatra']?.toString(),
      mangalikStatus: json['mangalik_status']?.toString(),
      partnerReligiousExpectation: json['partner_religious_expectation']?.toString(),
      partnerWillingnessToLearnRituals: json['partner_willingness_to_learn_rituals']?.toString(),
      religiousFlexibility: json['religious_flexibility']?.toString(),
      // Christian
      denomination: json['denomination']?.toString(),
      churchName: json['church_name']?.toString(),
      bibleReadingFrequency: json['bible_reading_frequency']?.toString(),
      churchAttendance: json['church_attendance']?.toString(),
      prayerParticipation: json['prayer_participation']?.toString(),
      churchActivityParticipation: json['church_activity_participation']?.toString(),
      baptismStatus: json['baptism_status']?.toString(),
      confirmationStatus: json['confirmation_status']?.toString(),
      religiousValueImportance: json['religious_value_importance']?.toString(),
      followsChristianEthics: json['follows_christian_ethics']?.toString(),
      churchBasedFamilyPreference: json['church_based_family_preference']?.toString(),
      churchWeddingPreference: json['church_wedding_preference']?.toString(),
      christianPartnerPreference: json['christian_partner_preference']?.toString(),
      childrenReligiousEducation: json['children_religious_education']?.toString(),
      churchBasedEducationBelief: json['church_based_education_belief']?.toString(),
      expectsPartnerCooperation: json['expects_partner_cooperation']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      if (userId != null) 'user': userId,
      'user_form': 4, // Step 4 - Personal Info
      // Common
      if (physicalProblem != null) 'physical_problem': physicalProblem,
      if (aboutMe != null) 'about_me': aboutMe,
      if (myPhone != null) 'my_phone': myPhone,
      // Islamic
      if (outsideClothings != null) 'outside_clothings': outsideClothings,
      if (isBeard != null) 'isBeard': isBeard,
      if (fromBeard != null) 'from_beard': fromBeard,
      if (isTakhnu != null) 'isTakhnu': isTakhnu,
      if (isDailyFive != null) 'isDailyFive': isDailyFive,
      if (isDailyFiveJamaat != null) 'isDailyFiveJamaat': isDailyFiveJamaat,
      if (dailyFiveJamaatFrom != null) 'daily_five_jamaat_from': dailyFiveJamaatFrom,
      if (dailyFiveFrom != null) 'daily_five_from': dailyFiveFrom,
      if (qadhaWeekly != null) 'qadha_weekly': qadhaWeekly,
      if (mahramNonMahram != null) 'mahram_non_mahram': mahramNonMahram,
      if (quranTilawat != null) 'quran_tilawat': quranTilawat,
      if (fiqh != null) 'fiqh': fiqh,
      if (natokCinema != null) 'natok_cinema': natokCinema,
      if (specialDeeniMehnot != null) 'special_deeni_mehnot': specialDeeniMehnot,
      if (mazar != null) 'mazar': mazar,
      if (islamicBooks != null) 'islamic_books': islamicBooks,
      if (islamicScholars != null) 'islamic_scholars': islamicScholars,
      'my_categories': myCategories,
      if (isNeshaDrobbo != null) 'isNeshaDrobbo': isNeshaDrobbo,
      if (fromWhenNikhab != null) 'from_when_nikhab': fromWhenNikhab,
      if (aboutRevertedIslam != null) 'about_reverted_islam': aboutRevertedIslam,
      if (aboutMiladQiyam != null) 'about_milad_qiyam': aboutMiladQiyam,
      // Hindu
      if (sampraday != null) 'sampraday': sampraday,
      if (subSampraday != null) 'sub_sampraday': subSampraday,
      if (caste != null) 'caste': caste,
      if (subCaste != null) 'sub_caste': subCaste,
      if (community != null) 'community': community,
      if (gotra != null) 'gotra': gotra,
      if (beliefInGod != null) 'belief_in_god': beliefInGod,
      if (religiousPracticeLevel != null) 'religious_practice_level': religiousPracticeLevel,
      if (regularPooja != null) 'regular_pooja': regularPooja,
      if (vratObservance != null) 'vrat_observance': vratObservance,
      if (templeVisitFrequency != null) 'temple_visit_frequency': templeVisitFrequency,
      if (ishtaDevata != null) 'ishta_devata': ishtaDevata,
      if (kulDevata != null) 'kul_devata': kulDevata,
      if (spiritualGuide != null) 'spiritual_guide': spiritualGuide,
      'festivals_celebrated': festivalsCelebrated,
      if (followsFamilyRituals != null) 'follows_family_rituals': followsFamilyRituals,
      if (postMarriageRitualsView != null) 'post_marriage_rituals_view': postMarriageRitualsView,
      if (foodHabit != null) 'food_habit': foodHabit,
      if (alcoholConsumption != null) 'alcohol_consumption': alcoholConsumption,
      if (smoking != null) 'smoking': smoking,
      if (sattvicLifestyle != null) 'sattvic_lifestyle': sattvicLifestyle,
      if (marriageView != null) 'marriage_view': marriageView,
      if (vedicMarriageInterest != null) 'vedic_marriage_interest': vedicMarriageInterest,
      if (kundaliMatchingBelief != null) 'kundali_matching_belief': kundaliMatchingBelief,
      if (birthTime != null) 'birth_time': birthTime,
      if (birthPlace != null) 'birth_place': birthPlace,
      if (rashi != null) 'rashi': rashi,
      if (nakshatra != null) 'nakshatra': nakshatra,
      if (mangalikStatus != null) 'mangalik_status': mangalikStatus,
      if (partnerReligiousExpectation != null) 'partner_religious_expectation': partnerReligiousExpectation,
      if (partnerWillingnessToLearnRituals != null) 'partner_willingness_to_learn_rituals': partnerWillingnessToLearnRituals,
      if (religiousFlexibility != null) 'religious_flexibility': religiousFlexibility,
      // Christian
      if (denomination != null) 'denomination': denomination,
      if (churchName != null) 'church_name': churchName,
      if (bibleReadingFrequency != null) 'bible_reading_frequency': bibleReadingFrequency,
      if (churchAttendance != null) 'church_attendance': churchAttendance,
      if (prayerParticipation != null) 'prayer_participation': prayerParticipation,
      if (churchActivityParticipation != null) 'church_activity_participation': churchActivityParticipation,
      if (baptismStatus != null) 'baptism_status': baptismStatus,
      if (confirmationStatus != null) 'confirmation_status': confirmationStatus,
      if (religiousValueImportance != null) 'religious_value_importance': religiousValueImportance,
      if (followsChristianEthics != null) 'follows_christian_ethics': followsChristianEthics,
      if (churchBasedFamilyPreference != null) 'church_based_family_preference': churchBasedFamilyPreference,
      if (churchWeddingPreference != null) 'church_wedding_preference': churchWeddingPreference,
      if (christianPartnerPreference != null) 'christian_partner_preference': christianPartnerPreference,
      if (childrenReligiousEducation != null) 'children_religious_education': childrenReligiousEducation,
      if (churchBasedEducationBelief != null) 'church_based_education_belief': churchBasedEducationBelief,
      if (expectsPartnerCooperation != null) 'expects_partner_cooperation': expectsPartnerCooperation,
    };
  }

  PersonalInfoEditModel copyWith({
    String? id,
    String? userId,
    // Common
    String? physicalProblem,
    String? aboutMe,
    String? myPhone,
    // Islamic
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
    List<String>? myCategories,
    String? isNeshaDrobbo,
    String? fromWhenNikhab,
    String? aboutRevertedIslam,
    String? aboutMiladQiyam,
    // Hindu
    String? sampraday,
    String? subSampraday,
    String? caste,
    String? subCaste,
    String? community,
    String? gotra,
    String? beliefInGod,
    String? religiousPracticeLevel,
    String? regularPooja,
    String? vratObservance,
    String? templeVisitFrequency,
    String? ishtaDevata,
    String? kulDevata,
    String? spiritualGuide,
    List<String>? festivalsCelebrated,
    String? followsFamilyRituals,
    String? postMarriageRitualsView,
    String? foodHabit,
    String? alcoholConsumption,
    String? smoking,
    String? sattvicLifestyle,
    String? marriageView,
    String? vedicMarriageInterest,
    String? kundaliMatchingBelief,
    String? birthTime,
    String? birthPlace,
    String? rashi,
    String? nakshatra,
    String? mangalikStatus,
    String? partnerReligiousExpectation,
    String? partnerWillingnessToLearnRituals,
    String? religiousFlexibility,
    // Christian
    String? denomination,
    String? churchName,
    String? bibleReadingFrequency,
    String? churchAttendance,
    String? prayerParticipation,
    String? churchActivityParticipation,
    String? baptismStatus,
    String? confirmationStatus,
    String? religiousValueImportance,
    String? followsChristianEthics,
    String? churchBasedFamilyPreference,
    String? churchWeddingPreference,
    String? christianPartnerPreference,
    String? childrenReligiousEducation,
    String? churchBasedEducationBelief,
    String? expectsPartnerCooperation,
  }) {
    return PersonalInfoEditModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      // Common
      physicalProblem: physicalProblem ?? this.physicalProblem,
      aboutMe: aboutMe ?? this.aboutMe,
      myPhone: myPhone ?? this.myPhone,
      // Islamic
      outsideClothings: outsideClothings ?? this.outsideClothings,
      isBeard: isBeard ?? this.isBeard,
      fromBeard: fromBeard ?? this.fromBeard,
      isTakhnu: isTakhnu ?? this.isTakhnu,
      isDailyFive: isDailyFive ?? this.isDailyFive,
      isDailyFiveJamaat: isDailyFiveJamaat ?? this.isDailyFiveJamaat,
      dailyFiveJamaatFrom: dailyFiveJamaatFrom ?? this.dailyFiveJamaatFrom,
      dailyFiveFrom: dailyFiveFrom ?? this.dailyFiveFrom,
      qadhaWeekly: qadhaWeekly ?? this.qadhaWeekly,
      mahramNonMahram: mahramNonMahram ?? this.mahramNonMahram,
      quranTilawat: quranTilawat ?? this.quranTilawat,
      fiqh: fiqh ?? this.fiqh,
      natokCinema: natokCinema ?? this.natokCinema,
      specialDeeniMehnot: specialDeeniMehnot ?? this.specialDeeniMehnot,
      mazar: mazar ?? this.mazar,
      islamicBooks: islamicBooks ?? this.islamicBooks,
      islamicScholars: islamicScholars ?? this.islamicScholars,
      myCategories: myCategories ?? this.myCategories,
      isNeshaDrobbo: isNeshaDrobbo ?? this.isNeshaDrobbo,
      fromWhenNikhab: fromWhenNikhab ?? this.fromWhenNikhab,
      aboutRevertedIslam: aboutRevertedIslam ?? this.aboutRevertedIslam,
      aboutMiladQiyam: aboutMiladQiyam ?? this.aboutMiladQiyam,
      // Hindu
      sampraday: sampraday ?? this.sampraday,
      subSampraday: subSampraday ?? this.subSampraday,
      caste: caste ?? this.caste,
      subCaste: subCaste ?? this.subCaste,
      community: community ?? this.community,
      gotra: gotra ?? this.gotra,
      beliefInGod: beliefInGod ?? this.beliefInGod,
      religiousPracticeLevel: religiousPracticeLevel ?? this.religiousPracticeLevel,
      regularPooja: regularPooja ?? this.regularPooja,
      vratObservance: vratObservance ?? this.vratObservance,
      templeVisitFrequency: templeVisitFrequency ?? this.templeVisitFrequency,
      ishtaDevata: ishtaDevata ?? this.ishtaDevata,
      kulDevata: kulDevata ?? this.kulDevata,
      spiritualGuide: spiritualGuide ?? this.spiritualGuide,
      festivalsCelebrated: festivalsCelebrated ?? this.festivalsCelebrated,
      followsFamilyRituals: followsFamilyRituals ?? this.followsFamilyRituals,
      postMarriageRitualsView: postMarriageRitualsView ?? this.postMarriageRitualsView,
      foodHabit: foodHabit ?? this.foodHabit,
      alcoholConsumption: alcoholConsumption ?? this.alcoholConsumption,
      smoking: smoking ?? this.smoking,
      sattvicLifestyle: sattvicLifestyle ?? this.sattvicLifestyle,
      marriageView: marriageView ?? this.marriageView,
      vedicMarriageInterest: vedicMarriageInterest ?? this.vedicMarriageInterest,
      kundaliMatchingBelief: kundaliMatchingBelief ?? this.kundaliMatchingBelief,
      birthTime: birthTime ?? this.birthTime,
      birthPlace: birthPlace ?? this.birthPlace,
      rashi: rashi ?? this.rashi,
      nakshatra: nakshatra ?? this.nakshatra,
      mangalikStatus: mangalikStatus ?? this.mangalikStatus,
      partnerReligiousExpectation: partnerReligiousExpectation ?? this.partnerReligiousExpectation,
      partnerWillingnessToLearnRituals: partnerWillingnessToLearnRituals ?? this.partnerWillingnessToLearnRituals,
      religiousFlexibility: religiousFlexibility ?? this.religiousFlexibility,
      // Christian
      denomination: denomination ?? this.denomination,
      churchName: churchName ?? this.churchName,
      bibleReadingFrequency: bibleReadingFrequency ?? this.bibleReadingFrequency,
      churchAttendance: churchAttendance ?? this.churchAttendance,
      prayerParticipation: prayerParticipation ?? this.prayerParticipation,
      churchActivityParticipation: churchActivityParticipation ?? this.churchActivityParticipation,
      baptismStatus: baptismStatus ?? this.baptismStatus,
      confirmationStatus: confirmationStatus ?? this.confirmationStatus,
      religiousValueImportance: religiousValueImportance ?? this.religiousValueImportance,
      followsChristianEthics: followsChristianEthics ?? this.followsChristianEthics,
      churchBasedFamilyPreference: churchBasedFamilyPreference ?? this.churchBasedFamilyPreference,
      churchWeddingPreference: churchWeddingPreference ?? this.churchWeddingPreference,
      christianPartnerPreference: christianPartnerPreference ?? this.christianPartnerPreference,
      childrenReligiousEducation: childrenReligiousEducation ?? this.childrenReligiousEducation,
      churchBasedEducationBelief: churchBasedEducationBelief ?? this.churchBasedEducationBelief,
      expectsPartnerCooperation: expectsPartnerCooperation ?? this.expectsPartnerCooperation,
    );
  }

  static PersonalInfoEditModel empty() {
    return PersonalInfoEditModel();
  }
}

