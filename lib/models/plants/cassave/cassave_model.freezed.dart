// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'cassave_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CassaveModel {
  double get nitrogen => throw _privateConstructorUsedError;
  double get phosphorous => throw _privateConstructorUsedError;
  double get potassium => throw _privateConstructorUsedError;
  double get ph => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CassaveModelCopyWith<CassaveModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CassaveModelCopyWith<$Res> {
  factory $CassaveModelCopyWith(
          CassaveModel value, $Res Function(CassaveModel) then) =
      _$CassaveModelCopyWithImpl<$Res>;
  $Res call({double nitrogen, double phosphorous, double potassium, double ph});
}

/// @nodoc
class _$CassaveModelCopyWithImpl<$Res> implements $CassaveModelCopyWith<$Res> {
  _$CassaveModelCopyWithImpl(this._value, this._then);

  final CassaveModel _value;
  // ignore: unused_field
  final $Res Function(CassaveModel) _then;

  @override
  $Res call({
    Object? nitrogen = freezed,
    Object? phosphorous = freezed,
    Object? potassium = freezed,
    Object? ph = freezed,
  }) {
    return _then(_value.copyWith(
      nitrogen: nitrogen == freezed
          ? _value.nitrogen
          : nitrogen // ignore: cast_nullable_to_non_nullable
              as double,
      phosphorous: phosphorous == freezed
          ? _value.phosphorous
          : phosphorous // ignore: cast_nullable_to_non_nullable
              as double,
      potassium: potassium == freezed
          ? _value.potassium
          : potassium // ignore: cast_nullable_to_non_nullable
              as double,
      ph: ph == freezed
          ? _value.ph
          : ph // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$$_CassaveModelCopyWith<$Res>
    implements $CassaveModelCopyWith<$Res> {
  factory _$$_CassaveModelCopyWith(
          _$_CassaveModel value, $Res Function(_$_CassaveModel) then) =
      __$$_CassaveModelCopyWithImpl<$Res>;
  @override
  $Res call({double nitrogen, double phosphorous, double potassium, double ph});
}

/// @nodoc
class __$$_CassaveModelCopyWithImpl<$Res>
    extends _$CassaveModelCopyWithImpl<$Res>
    implements _$$_CassaveModelCopyWith<$Res> {
  __$$_CassaveModelCopyWithImpl(
      _$_CassaveModel _value, $Res Function(_$_CassaveModel) _then)
      : super(_value, (v) => _then(v as _$_CassaveModel));

  @override
  _$_CassaveModel get _value => super._value as _$_CassaveModel;

  @override
  $Res call({
    Object? nitrogen = freezed,
    Object? phosphorous = freezed,
    Object? potassium = freezed,
    Object? ph = freezed,
  }) {
    return _then(_$_CassaveModel(
      nitrogen: nitrogen == freezed
          ? _value.nitrogen
          : nitrogen // ignore: cast_nullable_to_non_nullable
              as double,
      phosphorous: phosphorous == freezed
          ? _value.phosphorous
          : phosphorous // ignore: cast_nullable_to_non_nullable
              as double,
      potassium: potassium == freezed
          ? _value.potassium
          : potassium // ignore: cast_nullable_to_non_nullable
              as double,
      ph: ph == freezed
          ? _value.ph
          : ph // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$_CassaveModel extends _CassaveModel {
  _$_CassaveModel(
      {required this.nitrogen,
      required this.phosphorous,
      required this.potassium,
      required this.ph})
      : super._();

  @override
  final double nitrogen;
  @override
  final double phosphorous;
  @override
  final double potassium;
  @override
  final double ph;

  @override
  String toString() {
    return 'CassaveModel(nitrogen: $nitrogen, phosphorous: $phosphorous, potassium: $potassium, ph: $ph)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CassaveModel &&
            const DeepCollectionEquality().equals(other.nitrogen, nitrogen) &&
            const DeepCollectionEquality()
                .equals(other.phosphorous, phosphorous) &&
            const DeepCollectionEquality().equals(other.potassium, potassium) &&
            const DeepCollectionEquality().equals(other.ph, ph));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(nitrogen),
      const DeepCollectionEquality().hash(phosphorous),
      const DeepCollectionEquality().hash(potassium),
      const DeepCollectionEquality().hash(ph));

  @JsonKey(ignore: true)
  @override
  _$$_CassaveModelCopyWith<_$_CassaveModel> get copyWith =>
      __$$_CassaveModelCopyWithImpl<_$_CassaveModel>(this, _$identity);
}

abstract class _CassaveModel extends CassaveModel {
  factory _CassaveModel(
      {required final double nitrogen,
      required final double phosphorous,
      required final double potassium,
      required final double ph}) = _$_CassaveModel;
  _CassaveModel._() : super._();

  @override
  double get nitrogen;
  @override
  double get phosphorous;
  @override
  double get potassium;
  @override
  double get ph;
  @override
  @JsonKey(ignore: true)
  _$$_CassaveModelCopyWith<_$_CassaveModel> get copyWith =>
      throw _privateConstructorUsedError;
}