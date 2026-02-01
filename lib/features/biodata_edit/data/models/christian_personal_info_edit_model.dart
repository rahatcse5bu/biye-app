/// Christian-specific personal information model
class ChristianPersonalInfoEditModel {
  final String? id;
  final String? userId;
  
  // ধর্মীয় পরিচয় (Religious Identity)
  final String? denomination; // ক্যাথলিক / প্রোটেস্ট্যান্ট / অর্থডক্স / ব্যাপ্টিস্ট / মেথডিস্ট / পেন্টেকস্টাল
  final String? churchName; // চার্চের নাম
  
  // বিশ্বাস ও আধ্যাত্মিকতা (Faith & Spirituality)
  final String? beliefInGod; // ঈশ্বরে বিশ্বাস
  final String? religiousPracticeLevel; // ধর্মচর্চার মাত্রা
  final String? bibleReadingFrequency; // বাইবেল পাঠ করেন কি
  
  // চার্চ ও উপাসনা (Church & Worship)
  final String? churchAttendance; // নিয়মিত চার্চে যান কি
  final String? prayerParticipation; // কোন কোন প্রার্থনায় অংশগ্রহণ
  final String? churchActivityParticipation; // চার্চের কার্যক্রমে যুক্ত আছেন কি
  
  // ধর্মীয় আচার ও উৎসব (Religious Rituals & Festivals)
  final List<String> festivalsCelebrated; // কোন কোন খ্রিস্টান উৎসব পালন করেন
  final String? baptismStatus; // বাপ্তিস্ম গ্রহণ করেছেন কি
  final String? confirmationStatus; // কনফার্মেশন হয়েছে কি
  
  // জীবনধারা ও মূল্যবোধ (Lifestyle & Values)
  final String? religiousValueImportance; // ধর্মীয় মূল্যবোধ জীবনে কতটা গুরুত্বপূর্ণ
  final String? followsChristianEthics; // খ্রিস্টীয় নৈতিকতা অনুসরণ
  final String? churchBasedFamilyPreference; // চার্চভিত্তিক পারিবারিক জীবন পছন্দ
  
  // খাদ্যাভ্যাস ও জীবনযাপন (Food & Lifestyle)
  final String? foodHabit; // খাদ্যাভ্যাস
  final String? alcoholConsumption; // মদ্যপান সম্পর্কে দৃষ্টিভঙ্গি
  final String? smoking; // ধূমপান
  
  // বিবাহ সম্পর্কিত বিশ্বাস (Marriage Beliefs)
  final String? marriageView; // বিবাহ সম্পর্কে দৃষ্টিভঙ্গি
  final String? churchWeddingPreference; // চার্চে বিবাহে আগ্রহী
  final String? christianPartnerPreference; // খ্রিস্টান জীবনসঙ্গী কাম্য কি
  
  // ধর্মীয় শিক্ষা ও সন্তান পালন (Religious Education & Children)
  final String? childrenReligiousEducation; // ভবিষ্যৎ সন্তানের ধর্মীয় শিক্ষা সম্পর্কে মতামত
  final String? churchBasedEducationBelief; // চার্চভিত্তিক শিক্ষায় বিশ্বাস
  
  // জীবনসঙ্গীর প্রত্যাশা (Partner Expectations)
  final String? partnerReligiousExpectation; // জীবনসঙ্গীর কাছে ধর্মীয় প্রত্যাশা
  final String? expectsPartnerCooperation; // ধর্মচর্চায় সহযোগিতা প্রত্যাশিত কি
  final String? religiousFlexibility; // ধর্মীয় বিষয়ে নমনীয়তা
  
  // Common fields
  final String? physicalProblem;
  final String? aboutMe;

  ChristianPersonalInfoEditModel({
    this.id,
    this.userId,
    this.denomination,
    this.churchName,
    this.beliefInGod,
    this.religiousPracticeLevel,
    this.bibleReadingFrequency,
    this.churchAttendance,
    this.prayerParticipation,
    this.churchActivityParticipation,
    this.festivalsCelebrated = const [],
    this.baptismStatus,
    this.confirmationStatus,
    this.religiousValueImportance,
    this.followsChristianEthics,
    this.churchBasedFamilyPreference,
    this.foodHabit,
    this.alcoholConsumption,
    this.smoking,
    this.marriageView,
    this.churchWeddingPreference,
    this.christianPartnerPreference,
    this.childrenReligiousEducation,
    this.churchBasedEducationBelief,
    this.partnerReligiousExpectation,
    this.expectsPartnerCooperation,
    this.religiousFlexibility,
    this.physicalProblem,
    this.aboutMe,
  });

  factory ChristianPersonalInfoEditModel.fromJson(Map<String, dynamic> json) {
    return ChristianPersonalInfoEditModel(
      id: json['_id']?.toString(),
      userId: json['user']?.toString(),
      denomination: json['denomination']?.toString(),
      churchName: json['church_name']?.toString(),
      beliefInGod: json['belief_in_god']?.toString(),
      religiousPracticeLevel: json['religious_practice_level']?.toString(),
      bibleReadingFrequency: json['bible_reading_frequency']?.toString(),
      churchAttendance: json['church_attendance']?.toString(),
      prayerParticipation: json['prayer_participation']?.toString(),
      churchActivityParticipation: json['church_activity_participation']?.toString(),
      festivalsCelebrated: json['festivals_celebrated'] != null
          ? List<String>.from(json['festivals_celebrated'].map((x) => x.toString()))
          : [],
      baptismStatus: json['baptism_status']?.toString(),
      confirmationStatus: json['confirmation_status']?.toString(),
      religiousValueImportance: json['religious_value_importance']?.toString(),
      followsChristianEthics: json['follows_christian_ethics']?.toString(),
      churchBasedFamilyPreference: json['church_based_family_preference']?.toString(),
      foodHabit: json['food_habit']?.toString(),
      alcoholConsumption: json['alcohol_consumption']?.toString(),
      smoking: json['smoking']?.toString(),
      marriageView: json['marriage_view']?.toString(),
      churchWeddingPreference: json['church_wedding_preference']?.toString(),
      christianPartnerPreference: json['christian_partner_preference']?.toString(),
      childrenReligiousEducation: json['children_religious_education']?.toString(),
      churchBasedEducationBelief: json['church_based_education_belief']?.toString(),
      partnerReligiousExpectation: json['partner_religious_expectation']?.toString(),
      expectsPartnerCooperation: json['expects_partner_cooperation']?.toString(),
      religiousFlexibility: json['religious_flexibility']?.toString(),
      physicalProblem: json['physical_problem']?.toString(),
      aboutMe: json['about_me']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      if (userId != null) 'user': userId,
      'religion': 'christianity',
      if (denomination != null) 'denomination': denomination,
      if (churchName != null) 'church_name': churchName,
      if (beliefInGod != null) 'belief_in_god': beliefInGod,
      if (religiousPracticeLevel != null) 'religious_practice_level': religiousPracticeLevel,
      if (bibleReadingFrequency != null) 'bible_reading_frequency': bibleReadingFrequency,
      if (churchAttendance != null) 'church_attendance': churchAttendance,
      if (prayerParticipation != null) 'prayer_participation': prayerParticipation,
      if (churchActivityParticipation != null) 'church_activity_participation': churchActivityParticipation,
      'festivals_celebrated': festivalsCelebrated,
      if (baptismStatus != null) 'baptism_status': baptismStatus,
      if (confirmationStatus != null) 'confirmation_status': confirmationStatus,
      if (religiousValueImportance != null) 'religious_value_importance': religiousValueImportance,
      if (followsChristianEthics != null) 'follows_christian_ethics': followsChristianEthics,
      if (churchBasedFamilyPreference != null) 'church_based_family_preference': churchBasedFamilyPreference,
      if (foodHabit != null) 'food_habit': foodHabit,
      if (alcoholConsumption != null) 'alcohol_consumption': alcoholConsumption,
      if (smoking != null) 'smoking': smoking,
      if (marriageView != null) 'marriage_view': marriageView,
      if (churchWeddingPreference != null) 'church_wedding_preference': churchWeddingPreference,
      if (christianPartnerPreference != null) 'christian_partner_preference': christianPartnerPreference,
      if (childrenReligiousEducation != null) 'children_religious_education': childrenReligiousEducation,
      if (churchBasedEducationBelief != null) 'church_based_education_belief': churchBasedEducationBelief,
      if (partnerReligiousExpectation != null) 'partner_religious_expectation': partnerReligiousExpectation,
      if (expectsPartnerCooperation != null) 'expects_partner_cooperation': expectsPartnerCooperation,
      if (religiousFlexibility != null) 'religious_flexibility': religiousFlexibility,
      if (physicalProblem != null) 'physical_problem': physicalProblem,
      if (aboutMe != null) 'about_me': aboutMe,
    };
  }

  ChristianPersonalInfoEditModel copyWith({
    String? id,
    String? userId,
    String? denomination,
    String? churchName,
    String? beliefInGod,
    String? religiousPracticeLevel,
    String? bibleReadingFrequency,
    String? churchAttendance,
    String? prayerParticipation,
    String? churchActivityParticipation,
    List<String>? festivalsCelebrated,
    String? baptismStatus,
    String? confirmationStatus,
    String? religiousValueImportance,
    String? followsChristianEthics,
    String? churchBasedFamilyPreference,
    String? foodHabit,
    String? alcoholConsumption,
    String? smoking,
    String? marriageView,
    String? churchWeddingPreference,
    String? christianPartnerPreference,
    String? childrenReligiousEducation,
    String? churchBasedEducationBelief,
    String? partnerReligiousExpectation,
    String? expectsPartnerCooperation,
    String? religiousFlexibility,
    String? physicalProblem,
    String? aboutMe,
  }) {
    return ChristianPersonalInfoEditModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      denomination: denomination ?? this.denomination,
      churchName: churchName ?? this.churchName,
      beliefInGod: beliefInGod ?? this.beliefInGod,
      religiousPracticeLevel: religiousPracticeLevel ?? this.religiousPracticeLevel,
      bibleReadingFrequency: bibleReadingFrequency ?? this.bibleReadingFrequency,
      churchAttendance: churchAttendance ?? this.churchAttendance,
      prayerParticipation: prayerParticipation ?? this.prayerParticipation,
      churchActivityParticipation: churchActivityParticipation ?? this.churchActivityParticipation,
      festivalsCelebrated: festivalsCelebrated ?? this.festivalsCelebrated,
      baptismStatus: baptismStatus ?? this.baptismStatus,
      confirmationStatus: confirmationStatus ?? this.confirmationStatus,
      religiousValueImportance: religiousValueImportance ?? this.religiousValueImportance,
      followsChristianEthics: followsChristianEthics ?? this.followsChristianEthics,
      churchBasedFamilyPreference: churchBasedFamilyPreference ?? this.churchBasedFamilyPreference,
      foodHabit: foodHabit ?? this.foodHabit,
      alcoholConsumption: alcoholConsumption ?? this.alcoholConsumption,
      smoking: smoking ?? this.smoking,
      marriageView: marriageView ?? this.marriageView,
      churchWeddingPreference: churchWeddingPreference ?? this.churchWeddingPreference,
      christianPartnerPreference: christianPartnerPreference ?? this.christianPartnerPreference,
      childrenReligiousEducation: childrenReligiousEducation ?? this.childrenReligiousEducation,
      churchBasedEducationBelief: churchBasedEducationBelief ?? this.churchBasedEducationBelief,
      partnerReligiousExpectation: partnerReligiousExpectation ?? this.partnerReligiousExpectation,
      expectsPartnerCooperation: expectsPartnerCooperation ?? this.expectsPartnerCooperation,
      religiousFlexibility: religiousFlexibility ?? this.religiousFlexibility,
      physicalProblem: physicalProblem ?? this.physicalProblem,
      aboutMe: aboutMe ?? this.aboutMe,
    );
  }

  static ChristianPersonalInfoEditModel empty() {
    return ChristianPersonalInfoEditModel();
  }
}
