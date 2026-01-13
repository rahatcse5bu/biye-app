import 'package:freezed_annotation/freezed_annotation.dart';

part 'personal_info_entity.freezed.dart';

@freezed
class PersonalInfoEntity with _$PersonalInfoEntity {
  const factory PersonalInfoEntity({
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
    String? physicalProblem,
    String? specialDeeniMehnot,
    String? mazar,
    String? islamicBooks,
    String? islamicScholars,
    List<String>? myCategories,
    String? aboutMe,
    String? myPhone,
    String? isNeshaDrobbo,
    String? fromWhenNikhab,
    String? aboutRevertedIslam,
    String? aboutMiladQiyam,
  }) = _PersonalInfoEntity;
}
