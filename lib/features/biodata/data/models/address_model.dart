import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/address_entity.dart';

part 'address_model.freezed.dart';
part 'address_model.g.dart';

@freezed
class AddressModel with _$AddressModel {
  const AddressModel._();
  
  const factory AddressModel({
    @JsonKey(name: 'permanent_address') String? permanentAddress,
    @JsonKey(name: 'present_address') String? presentAddress,
    @JsonKey(name: 'grown_up') String? grownUp,
    @JsonKey(name: 'present_area') String? presentArea,
    @JsonKey(name: 'permanent_area') String? permanentArea,
    String? zilla,
    String? upzilla,
    String? division,
    @JsonKey(name: 'present_zilla') String? presentZilla,
    @JsonKey(name: 'present_upzilla') String? presentUpzilla,
    @JsonKey(name: 'present_division') String? presentDivision,
    String? city,
    int? zip,
  }) = _AddressModel;
  
  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
  
  AddressEntity toEntity() {
    return AddressEntity(
      permanentAddress: permanentAddress,
      presentAddress: presentAddress,
      grownUp: grownUp,
      presentArea: presentArea,
      permanentArea: permanentArea,
      zilla: zilla,
      upzilla: upzilla,
      division: division,
      presentZilla: presentZilla,
      presentUpzilla: presentUpzilla,
      presentDivision: presentDivision,
      city: city,
      zip: zip,
    );
  }
}
