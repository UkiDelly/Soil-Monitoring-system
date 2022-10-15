import 'package:freezed_annotation/freezed_annotation.dart';

part "rice_model.freezed.dart";

@freezed
class RiceModel with _$RiceModel {
  const RiceModel._();

  factory RiceModel(
      {required double nitrogen,
      required double phosphorous,
      required double potassium,
      required double ph}) = _RiceModel;
}
