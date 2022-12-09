// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'permission_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PermissionStateTearOff {
  const _$PermissionStateTearOff();

  _PermissionState call(
      {required bool isLocationPermissionGranted,
      required bool isLocationServicesEnabled}) {
    return _PermissionState(
      isLocationPermissionGranted: isLocationPermissionGranted,
      isLocationServicesEnabled: isLocationServicesEnabled,
    );
  }
}

/// @nodoc
const $PermissionState = _$PermissionStateTearOff();

/// @nodoc
mixin _$PermissionState {
  bool get isLocationPermissionGranted => throw _privateConstructorUsedError;
  bool get isLocationServicesEnabled => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PermissionStateCopyWith<PermissionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PermissionStateCopyWith<$Res> {
  factory $PermissionStateCopyWith(
          PermissionState value, $Res Function(PermissionState) then) =
      _$PermissionStateCopyWithImpl<$Res>;
  $Res call({bool isLocationPermissionGranted, bool isLocationServicesEnabled});
}

/// @nodoc
class _$PermissionStateCopyWithImpl<$Res>
    implements $PermissionStateCopyWith<$Res> {
  _$PermissionStateCopyWithImpl(this._value, this._then);

  final PermissionState _value;
  // ignore: unused_field
  final $Res Function(PermissionState) _then;

  @override
  $Res call({
    Object? isLocationPermissionGranted = freezed,
    Object? isLocationServicesEnabled = freezed,
  }) {
    return _then(_value.copyWith(
      isLocationPermissionGranted: isLocationPermissionGranted == freezed
          ? _value.isLocationPermissionGranted
          : isLocationPermissionGranted // ignore: cast_nullable_to_non_nullable
              as bool,
      isLocationServicesEnabled: isLocationServicesEnabled == freezed
          ? _value.isLocationServicesEnabled
          : isLocationServicesEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$PermissionStateCopyWith<$Res>
    implements $PermissionStateCopyWith<$Res> {
  factory _$PermissionStateCopyWith(
          _PermissionState value, $Res Function(_PermissionState) then) =
      __$PermissionStateCopyWithImpl<$Res>;
  @override
  $Res call({bool isLocationPermissionGranted, bool isLocationServicesEnabled});
}

/// @nodoc
class __$PermissionStateCopyWithImpl<$Res>
    extends _$PermissionStateCopyWithImpl<$Res>
    implements _$PermissionStateCopyWith<$Res> {
  __$PermissionStateCopyWithImpl(
      _PermissionState _value, $Res Function(_PermissionState) _then)
      : super(_value, (v) => _then(v as _PermissionState));

  @override
  _PermissionState get _value => super._value as _PermissionState;

  @override
  $Res call({
    Object? isLocationPermissionGranted = freezed,
    Object? isLocationServicesEnabled = freezed,
  }) {
    return _then(_PermissionState(
      isLocationPermissionGranted: isLocationPermissionGranted == freezed
          ? _value.isLocationPermissionGranted
          : isLocationPermissionGranted // ignore: cast_nullable_to_non_nullable
              as bool,
      isLocationServicesEnabled: isLocationServicesEnabled == freezed
          ? _value.isLocationServicesEnabled
          : isLocationServicesEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_PermissionState extends _PermissionState {
  const _$_PermissionState(
      {required this.isLocationPermissionGranted,
      required this.isLocationServicesEnabled})
      : super._();

  @override
  final bool isLocationPermissionGranted;
  @override
  final bool isLocationServicesEnabled;

  @override
  String toString() {
    return 'PermissionState(isLocationPermissionGranted: $isLocationPermissionGranted, isLocationServicesEnabled: $isLocationServicesEnabled)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PermissionState &&
            const DeepCollectionEquality().equals(
                other.isLocationPermissionGranted,
                isLocationPermissionGranted) &&
            const DeepCollectionEquality().equals(
                other.isLocationServicesEnabled, isLocationServicesEnabled));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLocationPermissionGranted),
      const DeepCollectionEquality().hash(isLocationServicesEnabled));

  @JsonKey(ignore: true)
  @override
  _$PermissionStateCopyWith<_PermissionState> get copyWith =>
      __$PermissionStateCopyWithImpl<_PermissionState>(this, _$identity);
}

abstract class _PermissionState extends PermissionState {
  const factory _PermissionState(
      {required bool isLocationPermissionGranted,
      required bool isLocationServicesEnabled}) = _$_PermissionState;
  const _PermissionState._() : super._();

  @override
  bool get isLocationPermissionGranted;
  @override
  bool get isLocationServicesEnabled;
  @override
  @JsonKey(ignore: true)
  _$PermissionStateCopyWith<_PermissionState> get copyWith =>
      throw _privateConstructorUsedError;
}
