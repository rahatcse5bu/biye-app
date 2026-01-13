import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/occupation_entity.dart';

part 'occupation_model.freezed.dart';
part 'occupation_model.g.dart';

@freezed
class OccupationModel with _$OccupationModel {
  const OccupationModel._();
  
  const factory OccupationModel({
    List<String>? occupation,
    @JsonKey(name: 'occupation_details') String? occupationDetails,
    @JsonKey(name: 'monthly_income') int? monthlyIncome,
  }) = _OccupationModel;
  
  factory OccupationModel.fromJson(Map<String, dynamic> json) =>
      _$OccupationModelFromJson(json);
  
  OccupationEntity toEntity() {
    return OccupationEntity(
      occupation: occupation,
      occupationDetails: occupationDetails,
      monthlyIncome: monthlyIncome,
    );
  }
}
