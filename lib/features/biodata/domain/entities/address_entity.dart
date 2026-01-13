import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_entity.freezed.dart';

@freezed
class AddressEntity with _$AddressEntity {
  const factory AddressEntity({
    String? permanentAddress,
    String? presentAddress,
    String? grownUp,
    String? presentArea,
    String? permanentArea,
    String? zilla,
    String? upzilla,
    String? division,
    String? presentZilla,
    String? presentUpzilla,
    String? presentDivision,
    String? city,
    int? zip,
  }) = _AddressEntity;
}
