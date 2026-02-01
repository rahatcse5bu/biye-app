/// Hindu-specific personal information model
class HinduPersonalInfoEditModel {
  final String? id;
  final String? userId;
  
  // ধর্মীয় পরিচয় (Religious Identity)
  final String? sampraday; // বৈষ্ণব / শৈব / শাক্ত / স্মার্ত
  final String? subSampraday; // ইসকন / আর্য সমাজ / রামকৃষ্ণ মিশন
  
  // জাতি ও গোত্র (Caste & Gotra)
  final String? caste; // ব্রাহ্মণ / ক্ষত্রিয় / বৈশ্য / শূদ্র
  final String? subCaste; // কুলীন ব্রাহ্মণ / রাঢ়ী ব্রাহ্মণ
  final String? community; // সম্প্রদায়
  final String? gotra; // কাশ্যপ / ভরদ্বাজ / বশিষ্ঠ
  
  // ধর্মীয় অনুশীলন (Religious Practice)
  final String? beliefInGod; // ঈশ্বরে বিশ্বাস
  final String? religiousPracticeLevel; // ধর্মাচরণ কেমন
  final String? regularPooja; // নিয়মিত পূজা করেন কি
  final String? vratObservance; // ব্রত বা উপবাস পালন
  final String? templeVisitFrequency; // মন্দিরে যান কি
  
  // উপাস্য দেবতা (Deities)
  final String? ishtaDevata; // ইষ্ট দেবতা
  final String? kulDevata; // কুলদেবতা / কুলদেবী
  final String? spiritualGuide; // গুরু বা আধ্যাত্মিক পথপ্রদর্শক
  
  // উৎসব ও আচার (Festivals & Rituals)
  final List<String> festivalsCelebrated; // কোন কোন উৎসব পালন করেন
  final String? followsFamilyRituals; // পারিবারিক ধর্মীয় রীতি মানেন কি
  final String? postMarriageRitualsView; // বিবাহোত্তর আচার পালনে মতামত
  
  // খাদ্যাভ্যাস ও জীবনধারা (Food & Lifestyle)
  final String? foodHabit; // খাদ্যাভ্যাস
  final String? alcoholConsumption; // মদ্যপান
  final String? smoking; // ধূমপান
  final String? sattvicLifestyle; // সাত্ত্বিক জীবনযাপন
  
  // বিবাহ সম্পর্কিত বিশ্বাস (Marriage Beliefs)
  final String? marriageView; // বিবাহ সম্পর্কে দৃষ্টিভঙ্গি
  final String? vedicMarriageInterest; // হিন্দু বৈদিক মতে বিবাহে আগ্রহী
  final String? kundaliMatchingBelief; // কুণ্ডলী মিলানে বিশ্বাস
  
  // জন্ম ও জ্যোতিষ তথ্য (Birth & Astrology - Optional)
  final String? birthTime; // জন্ম সময়
  final String? birthPlace; // জন্মস্থান
  final String? rashi; // রাশি
  final String? nakshatra; // নক্ষত্র
  final String? mangalikStatus; // মাঙ্গলিক
  
  // জীবনসঙ্গীর প্রত্যাশা (Partner Expectations)
  final String? partnerReligiousExpectation; // সঙ্গীর কাছে ধর্মীয় প্রত্যাশা
  final String? partnerWillingnessToLearnRituals; // ধর্মীয় রীতি শেখার মানসিকতা
  final String? religiousFlexibility; // ধর্মীয় বিষয়ে নমনীয়তা
  
  // Common fields
  final String? physicalProblem;
  final String? aboutMe;

  HinduPersonalInfoEditModel({
    this.id,
    this.userId,
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
    this.physicalProblem,
    this.aboutMe,
  });

  factory HinduPersonalInfoEditModel.fromJson(Map<String, dynamic> json) {
    return HinduPersonalInfoEditModel(
      id: json['_id']?.toString(),
      userId: json['user']?.toString(),
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
      physicalProblem: json['physical_problem']?.toString(),
      aboutMe: json['about_me']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      if (userId != null) 'user': userId,
      'religion': 'hinduism',
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
      if (physicalProblem != null) 'physical_problem': physicalProblem,
      if (aboutMe != null) 'about_me': aboutMe,
    };
  }

  HinduPersonalInfoEditModel copyWith({
    String? id,
    String? userId,
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
    String? physicalProblem,
    String? aboutMe,
  }) {
    return HinduPersonalInfoEditModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
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
      physicalProblem: physicalProblem ?? this.physicalProblem,
      aboutMe: aboutMe ?? this.aboutMe,
    );
  }

  static HinduPersonalInfoEditModel empty() {
    return HinduPersonalInfoEditModel();
  }
}
