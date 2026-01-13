import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/personal_info_entity.dart';

part 'personal_info_model.freezed.dart';
part 'personal_info_model.g.dart';

@freezed
class PersonalInfoModel with _$PersonalInfoModel {
  const PersonalInfoModel._();
  
  const factory PersonalInfoModel({
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
    @JsonKey(name: 'physical_problem') String? physicalProblem,
    @JsonKey(name: 'special_deeni_mehnot') String? specialDeeniMehnot,
    String? mazar,
    @JsonKey(name: 'islamic_books') String? islamicBooks,
    @JsonKey(name: 'islamic_scholars') String? islamicScholars,
    @JsonKey(name: 'my_categories') List<String>? myCategories,
    @JsonKey(name: 'about_me') String? aboutMe,
    @JsonKey(name: 'my_phone') String? myPhone,
    @JsonKey(name: 'isNeshaDrobbo') String? isNeshaDrobbo,
    @JsonKey(name: 'from_when_nikhab') String? fromWhenNikhab,
    @JsonKey(name: 'about_reverted_islam') String? aboutRevertedIslam,
    @JsonKey(name: 'about_milad_qiyam') String? aboutMiladQiyam,
  }) = _PersonalInfoModel;
  
  factory PersonalInfoModel.fromJson(Map<String, dynamic> json) =>
      _$PersonalInfoModelFromJson(json);
  
  PersonalInfoEntity toEntity() {
    return PersonalInfoEntity(
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
      physicalProblem: physicalProblem,
      specialDeeniMehnot: specialDeeniMehnot,
      mazar: mazar,
      islamicBooks: islamicBooks,
      islamicScholars: islamicScholars,
      myCategories: myCategories,
      aboutMe: aboutMe,
      myPhone: myPhone,
      isNeshaDrobbo: isNeshaDrobbo,
      fromWhenNikhab: fromWhenNikhab,
      aboutRevertedIslam: aboutRevertedIslam,
      aboutMiladQiyam: aboutMiladQiyam,
    );
  }
}
