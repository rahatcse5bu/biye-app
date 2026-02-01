/// Religion types supported by the application
enum Religion {
  islam('ইসলাম', 'islam'),
  hinduism('হিন্দু', 'hinduism'),
  christianity('খ্রিস্টান', 'christianity');

  final String displayName;
  final String value;
  
  const Religion(this.displayName, this.value);
  
  static Religion? fromValue(String? value) {
    if (value == null || value.isEmpty) return null;
    try {
      return Religion.values.firstWhere((e) => e.value == value);
    } catch (e) {
      return null;
    }
  }
  
  static Religion? fromDisplayName(String? displayName) {
    if (displayName == null || displayName.isEmpty) return null;
    try {
      return Religion.values.firstWhere((e) => e.displayName == displayName);
    } catch (e) {
      return null;
    }
  }
}

/// Religious practice types for each religion
enum ReligiousType {
  // Islam
  practicingMuslim('প্র্যাক্টিসিং মুসলিম', 'practicing_muslim', Religion.islam),
  generalMuslim('সাধারণ মুসলিম', 'general_muslim', Religion.islam),
  
  // Hinduism
  practicingHindu('প্র্যাক্টিসিং হিন্দু', 'practicing_hindu', Religion.hinduism),
  generalHindu('সাধারণ হিন্দু', 'general_hindu', Religion.hinduism),
  
  // Christianity
  practicingChristian('প্র্যাক্টিসিং খ্রিস্টান', 'practicing_christian', Religion.christianity),
  generalChristian('সাধারণ খ্রিস্টান', 'general_christian', Religion.christianity);

  final String displayName;
  final String value;
  final Religion religion;
  
  const ReligiousType(this.displayName, this.value, this.religion);
  
  static ReligiousType? fromValue(String? value) {
    if (value == null || value.isEmpty) return null;
    try {
      return ReligiousType.values.firstWhere((e) => e.value == value);
    } catch (e) {
      return null;
    }
  }
  
  static List<ReligiousType> getTypesForReligion(Religion religion) {
    return ReligiousType.values.where((e) => e.religion == religion).toList();
  }
  
  bool get isPracticing {
    return value.startsWith('practicing_');
  }
}

/// Hindu-specific constants
class HinduConstants {
  // Sampraday (Sect)
  static const List<String> sampradays = [
    'বৈষ্ণব',
    'শৈব',
    'শাক্ত',
    'স্মার্ত',
    'নির্দিষ্ট নয়',
  ];
  
  // Sub-sampraday
  static const List<String> subSampradays = [
    'ইসকন অনুসারী',
    'আর্য সমাজ',
    'রামকৃষ্ণ মিশন',
    'পারিবারিক রীতি অনুযায়ী',
    'অন্যান্য',
  ];
  
  // Caste (Varna)
  static const List<String> castes = [
    'ব্রাহ্মণ',
    'ক্ষত্রিয়',
    'বৈশ্য',
    'শূদ্র',
    'অন্যান্য',
  ];
  
  // Sub-caste
  static const List<String> subCastes = [
    'কুলীন ব্রাহ্মণ',
    'রাঢ়ী ব্রাহ্মণ',
    'কায়স্থ',
    'অন্যান্য',
  ];
  
  // Gotra
  static const List<String> gotras = [
    'কাশ্যপ',
    'ভরদ্বাজ',
    'বশিষ্ঠ',
    'গৌতম',
    'জানা নেই',
    'অন্যান্য',
  ];
  
  // Religious Practice Level
  static const List<String> religiousPracticeLevels = [
    'অত্যন্ত ধর্মপরায়ণ',
    'মধ্যম মাত্রায় ধর্মপরায়ণ',
    'সামান্য ধর্মপরায়ণ',
    'ধর্মীয় আচরণ পালন করি না',
  ];
  
  // Pooja Frequency
  static const List<String> poojaFrequencies = [
    'নিয়মিত',
    'মাঝে মাঝে',
    'না',
  ];
  
  // Vrat/Upabash Observance
  static const List<String> vratObservances = [
    'একাদশী, মহাশিবরাত্রি ইত্যাদি উপলক্ষে',
    'শুধু বিশেষ দিনে',
    'করি না',
  ];
  
  // Temple Visit Frequency
  static const List<String> templeVisitFrequencies = [
    'নিয়মিত',
    'উৎসবের সময়',
    'মাঝে মাঝে',
    'যাই না',
  ];
  
  // Ishtadevata (Deity)
  static const List<String> deities = [
    'শ্রীকৃষ্ণ',
    'শিব',
    'মা দুর্গা',
    'বিষ্ণু',
    'গণেশ',
    'মা কালী',
    'মা সরস্বতী',
    'অন্যান্য',
  ];
  
  // Festivals
  static const List<String> festivals = [
    'দুর্গাপূজা',
    'কালীপূজা',
    'দীপাবলি',
    'সরস্বতী পূজা',
    'জন্মাষ্টমী',
    'হোলি',
    'রথযাত্রা',
    'অন্যান্য',
  ];
  
  // Food Habit
  static const List<String> foodHabits = [
    'নিরামিষ',
    'ডিম গ্রহণযোগ্য',
    'মাঝে মাঝে আমিষ',
    'নিয়মিত আমিষ',
  ];
  
  // Kundali Matching Belief
  static const List<String> kundaliBeliefs = [
    'বিশ্বাসী',
    'ঐচ্ছিক',
    'বিশ্বাসী নই',
  ];
  
  // Rashi (Zodiac)
  static const List<String> rashis = [
    'মেষ',
    'বৃষ',
    'মিথুন',
    'কর্কট',
    'সিংহ',
    'কন্যা',
    'তুলা',
    'বৃশ্চিক',
    'ধনু',
    'মকর',
    'কুম্ভ',
    'মীন',
  ];
  
  // Mangalik Status
  static const List<String> mangalikStatuses = [
    'মাঙ্গলিক',
    'নন-মাঙ্গলিক',
    'জানা নেই',
  ];
}

/// Christian-specific constants
class ChristianConstants {
  // Denominations
  static const List<String> denominations = [
    'ক্যাথলিক',
    'প্রোটেস্ট্যান্ট',
    'অর্থডক্স',
    'ব্যাপ্টিস্ট',
    'মেথডিস্ট',
    'পেন্টেকস্টাল',
    'অ্যাংলিকান',
    'লুথেরান',
    'অন্যান্য',
  ];
  
  // Religious Practice Level
  static const List<String> religiousPracticeLevels = [
    'নিয়মিত ধর্মচর্চা করি',
    'মধ্যম মাত্রায় ধর্মপরায়ণ',
    'মাঝে মাঝে ধর্মচর্চা করি',
    'ধর্মচর্চা করি না',
  ];
  
  // Bible Reading Frequency
  static const List<String> bibleReadingFrequencies = [
    'নিয়মিত',
    'মাঝে মাঝে',
    'কদাচিৎ',
    'পড়ি না',
  ];
  
  // Church Attendance
  static const List<String> churchAttendances = [
    'হ্যাঁ, প্রতি সপ্তাহে',
    'উৎসবের সময়',
    'মাঝে মাঝে',
    'যাই না',
  ];
  
  // Church Activity Participation
  static const List<String> churchParticipations = [
    'হ্যাঁ, সক্রিয়ভাবে',
    'মাঝে মাঝে',
    'না',
  ];
  
  // Festivals
  static const List<String> festivals = [
    'বড়দিন (Christmas)',
    'ইস্টার (Easter)',
    'গুড ফ্রাইডে',
    'পাম সানডে',
    'অ্যাশ ওয়েডনেসডে',
    'অন্যান্য',
  ];
  
  // Baptism Status
  static const List<String> baptismStatuses = [
    'হ্যাঁ',
    'না',
  ];
  
  // Confirmation Status
  static const List<String> confirmationStatuses = [
    'হ্যাঁ',
    'না',
    'প্রযোজ্য নয়',
  ];
  
  // Importance of Religious Values
  static const List<String> religiousValueImportances = [
    'অত্যন্ত গুরুত্বপূর্ণ',
    'গুরুত্বপূর্ণ',
    'মোটামুটি',
    'কম গুরুত্বপূর্ণ',
  ];
  
  // Church-based Family Life Preference
  static const List<String> churchBasedFamilyPreferences = [
    'হ্যাঁ',
    'না',
    'ঐচ্ছিক',
  ];
  
  // Church Wedding Preference
  static const List<String> churchWeddingPreferences = [
    'হ্যাঁ',
    'না',
    'ঐচ্ছিক',
  ];
  
  // Christian Partner Preference
  static const List<String> christianPartnerPreferences = [
    'হ্যাঁ, অবশ্যই',
    'প্রাধান্য দেই',
    'ঐচ্ছিক',
  ];
  
  // Religious Education for Children
  static const List<String> childrenReligiousEducationPreferences = [
    'খ্রিস্টীয় মূল্যবোধ অনুযায়ী বড় করতে আগ্রহী',
    'ঐচ্ছিক',
    'প্রয়োজন নেই',
  ];
}

/// Common constants for all religions
class CommonReligiousConstants {
  // Belief in God
  static const List<String> godBeliefOptions = [
    'হ্যাঁ, দৃঢ় বিশ্বাসী',
    'হ্যাঁ',
    'অনিশ্চিত',
    'না',
  ];
  
  // Alcohol Consumption
  static const List<String> alcoholConsumptionOptions = [
    'না',
    'মাঝে মাঝে সামাজিকভাবে',
    'হ্যাঁ',
  ];
  
  // Smoking
  static const List<String> smokingOptions = [
    'না',
    'মাঝে মাঝে',
    'হ্যাঁ',
  ];
  
  // Marriage View
  static const List<String> marriageViewOptions = [
    'বিবাহ একটি পবিত্র বন্ধন',
    'বিবাহ একটি সামাজিক চুক্তি',
    'অন্যান্য',
  ];
  
  // Religious Flexibility with Partner
  static const List<String> religiousFlexibilityOptions = [
    'পারস্পরিক সম্মানের ভিত্তিতে',
    'আমার ধর্মীয় রীতি মানতে হবে',
    'সম্পূর্ণ নমনীয়',
  ];
}
