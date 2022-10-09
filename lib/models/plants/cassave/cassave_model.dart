import 'package:freezed_annotation/freezed_annotation.dart';

part "cassave_model.freezed.dart";

@freezed
class CassaveModel with _$CassaveModel {
  const CassaveModel._();

  factory CassaveModel(
      {required double nitrogen,
      required double phosphorous,
      required double potassium,
      required double ph}) = _CassaveModel;

  factory CassaveModel.fromJson(Map<String, dynamic> json) => _$CassaveModelFromJson(json);
}
