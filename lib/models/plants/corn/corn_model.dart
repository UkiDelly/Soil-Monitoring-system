import 'package:freezed_annotation/freezed_annotation.dart';

part "corn_model.freezed.dart";

@freezed
class CornModel with _$CornModel {
  const CornModel._();

  factory CornModel(
      {required double nitrogen,
      required double phosphorous,
      required double potassium,
      required double ph}) = _CornModel;
}
