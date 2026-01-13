// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PersonalInfoModelImpl _$$PersonalInfoModelImplFromJson(
  Map<String, dynamic> json,
) => _$PersonalInfoModelImpl(
  outsideClothings: json['outside_clothings'] as String?,
  isBeard: json['isBeard'] as String?,
  fromBeard: json['from_beard'] as String?,
  isTakhnu: json['isTakhnu'] as String?,
  isDailyFive: json['isDailyFive'] as String?,
  isDailyFiveJamaat: json['isDailyFiveJamaat'] as String?,
  dailyFiveJamaatFrom: json['daily_five_jamaat_from'] as String?,
  dailyFiveFrom: json['daily_five_from'] as String?,
  qadhaWeekly: json['qadha_weekly'] as String?,
  mahramNonMahram: json['mahram_non_mahram'] as String?,
  quranTilawat: json['quran_tilawat'] as String?,
  fiqh: json['fiqh'] as String?,
  natokCinema: json['natok_cinema'] as String?,
  physicalProblem: json['physical_problem'] as String?,
  specialDeeniMehnot: json['special_deeni_mehnot'] as String?,
  mazar: json['mazar'] as String?,
  islamicBooks: json['islamic_books'] as String?,
  islamicScholars: json['islamic_scholars'] as String?,
  myCategories: (json['my_categories'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  aboutMe: json['about_me'] as String?,
  myPhone: json['my_phone'] as String?,
  isNeshaDrobbo: json['isNeshaDrobbo'] as String?,
  fromWhenNikhab: json['from_when_nikhab'] as String?,
  aboutRevertedIslam: json['about_reverted_islam'] as String?,
  aboutMiladQiyam: json['about_milad_qiyam'] as String?,
);

Map<String, dynamic> _$$PersonalInfoModelImplToJson(
  _$PersonalInfoModelImpl instance,
) => <String, dynamic>{
  'outside_clothings': instance.outsideClothings,
  'isBeard': instance.isBeard,
  'from_beard': instance.fromBeard,
  'isTakhnu': instance.isTakhnu,
  'isDailyFive': instance.isDailyFive,
  'isDailyFiveJamaat': instance.isDailyFiveJamaat,
  'daily_five_jamaat_from': instance.dailyFiveJamaatFrom,
  'daily_five_from': instance.dailyFiveFrom,
  'qadha_weekly': instance.qadhaWeekly,
  'mahram_non_mahram': instance.mahramNonMahram,
  'quran_tilawat': instance.quranTilawat,
  'fiqh': instance.fiqh,
  'natok_cinema': instance.natokCinema,
  'physical_problem': instance.physicalProblem,
  'special_deeni_mehnot': instance.specialDeeniMehnot,
  'mazar': instance.mazar,
  'islamic_books': instance.islamicBooks,
  'islamic_scholars': instance.islamicScholars,
  'my_categories': instance.myCategories,
  'about_me': instance.aboutMe,
  'my_phone': instance.myPhone,
  'isNeshaDrobbo': instance.isNeshaDrobbo,
  'from_when_nikhab': instance.fromWhenNikhab,
  'about_reverted_islam': instance.aboutRevertedIslam,
  'about_milad_qiyam': instance.aboutMiladQiyam,
};
