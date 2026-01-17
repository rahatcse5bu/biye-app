class PersonalInfoEditModel {
  final String? id;
  final String? userId;
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
  final String? physicalProblem;
  final String? specialDeeniMehnot;
  final String? mazar;
  final String? islamicBooks;
  final String? islamicScholars;
  final List<String> myCategories;
  final String? aboutMe;
  final String? myPhone;
  final String? isNeshaDrobbo;
  final String? fromWhenNikhab;
  final String? aboutRevertedIslam;
  final String? aboutMiladQiyam;

  PersonalInfoEditModel({
    this.id,
    this.userId,
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
    this.physicalProblem,
    this.specialDeeniMehnot,
    this.mazar,
    this.islamicBooks,
    this.islamicScholars,
    this.myCategories = const [],
    this.aboutMe,
    this.myPhone,
    this.isNeshaDrobbo,
    this.fromWhenNikhab,
    this.aboutRevertedIslam,
    this.aboutMiladQiyam,
  });

  factory PersonalInfoEditModel.fromJson(Map<String, dynamic> json) {
    return PersonalInfoEditModel(
      id: json['_id']?.toString(),
      userId: json['user']?.toString(),
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
      physicalProblem: json['physical_problem']?.toString(),
      specialDeeniMehnot: json['special_deeni_mehnot']?.toString(),
      mazar: json['mazar']?.toString(),
      islamicBooks: json['islamic_books']?.toString(),
      islamicScholars: json['islamic_scholars']?.toString(),
      myCategories: json['my_categories'] != null
          ? List<String>.from(json['my_categories'].map((x) => x.toString()))
          : [],
      aboutMe: json['about_me']?.toString(),
      myPhone: json['my_phone']?.toString(),
      isNeshaDrobbo: json['isNeshaDrobbo']?.toString(),
      fromWhenNikhab: json['from_when_nikhab']?.toString(),
      aboutRevertedIslam: json['about_reverted_islam']?.toString(),
      aboutMiladQiyam: json['about_milad_qiyam']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      if (userId != null) 'user': userId,
      'user_form': 4, // Step 4 - Personal Info
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
      if (physicalProblem != null) 'physical_problem': physicalProblem,
      if (specialDeeniMehnot != null) 'special_deeni_mehnot': specialDeeniMehnot,
      if (mazar != null) 'mazar': mazar,
      if (islamicBooks != null) 'islamic_books': islamicBooks,
      if (islamicScholars != null) 'islamic_scholars': islamicScholars,
      'my_categories': myCategories,
      if (aboutMe != null) 'about_me': aboutMe,
      if (myPhone != null) 'my_phone': myPhone,
      if (isNeshaDrobbo != null) 'isNeshaDrobbo': isNeshaDrobbo,
      if (fromWhenNikhab != null) 'from_when_nikhab': fromWhenNikhab,
      if (aboutRevertedIslam != null) 'about_reverted_islam': aboutRevertedIslam,
      if (aboutMiladQiyam != null) 'about_milad_qiyam': aboutMiladQiyam,
    };
  }

  static PersonalInfoEditModel empty() {
    return PersonalInfoEditModel();
  }
}
