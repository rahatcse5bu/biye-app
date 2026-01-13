import 'package:freezed_annotation/freezed_annotation.dart';

part 'occupation_entity.freezed.dart';

@freezed
class OccupationEntity with _$OccupationEntity {
  const factory OccupationEntity({
    List<String>? occupation,
    String? occupationDetails,
    int? monthlyIncome,
  }) = _OccupationEntity;
}
