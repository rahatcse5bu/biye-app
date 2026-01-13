import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/biodata_entity.dart';

part 'biodata_state.freezed.dart';

@freezed
class BiodataState with _$BiodataState {
  const factory BiodataState.initial() = _Initial;
  const factory BiodataState.loading() = _Loading;
  const factory BiodataState.loaded(List<BiodataEntity> biodatas) = _Loaded;
  const factory BiodataState.error(String message) = _Error;
}

@freezed
class BiodataDetailState with _$BiodataDetailState {
  const factory BiodataDetailState.initial() = _DetailInitial;
  const factory BiodataDetailState.loading() = _DetailLoading;
  const factory BiodataDetailState.loaded(BiodataEntity biodata) = _DetailLoaded;
  const factory BiodataDetailState.error(String message) = _DetailError;
}
