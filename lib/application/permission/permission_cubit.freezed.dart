// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'permission_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
      _$PermissionStateCopyWithImpl<$Res, PermissionState>;
  @useResult
  $Res call({bool isLocationPermissionGranted, bool isLocationServicesEnabled});
}

/// @nodoc
class _$PermissionStateCopyWithImpl<$Res, $Val extends PermissionState>
    implements $PermissionStateCopyWith<$Res> {
  _$PermissionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLocationPermissionGranted = null,
    Object? isLocationServicesEnabled = null,
  }) {
    return _then(_value.copyWith(
      isLocationPermissionGranted: null == isLocationPermissionGranted
          ? _value.isLocationPermissionGranted
          : isLocationPermissionGranted // ignore: cast_nullable_to_non_nullable
              as bool,
      isLocationServicesEnabled: null == isLocationServicesEnabled
          ? _value.isLocationServicesEnabled
          : isLocationServicesEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PermissionStateCopyWith<$Res>
    implements $PermissionStateCopyWith<$Res> {
  factory _$$_PermissionStateCopyWith(
          _$_PermissionState value, $Res Function(_$_PermissionState) then) =
      __$$_PermissionStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLocationPermissionGranted, bool isLocationServicesEnabled});
}

/// @nodoc
class __$$_PermissionStateCopyWithImpl<$Res>
    extends _$PermissionStateCopyWithImpl<$Res, _$_PermissionState>
    implements _$$_PermissionStateCopyWith<$Res> {
  __$$_PermissionStateCopyWithImpl(
      _$_PermissionState _value, $Res Function(_$_PermissionState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLocationPermissionGranted = null,
    Object? isLocationServicesEnabled = null,
  }) {
    return _then(_$_PermissionState(
      isLocationPermissionGranted: null == isLocationPermissionGranted
          ? _value.isLocationPermissionGranted
          : isLocationPermissionGranted // ignore: cast_nullable_to_non_nullable
              as bool,
      isLocationServicesEnabled: null == isLocationServicesEnabled
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
            other is _$_PermissionState &&
            (identical(other.isLocationPermissionGranted,
                    isLocationPermissionGranted) ||
                other.isLocationPermissionGranted ==
                    isLocationPermissionGranted) &&
            (identical(other.isLocationServicesEnabled,
                    isLocationServicesEnabled) ||
                other.isLocationServicesEnabled == isLocationServicesEnabled));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isLocationPermissionGranted, isLocationServicesEnabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PermissionStateCopyWith<_$_PermissionState> get copyWith =>
      __$$_PermissionStateCopyWithImpl<_$_PermissionState>(this, _$identity);
}

abstract class _PermissionState extends PermissionState {
  const factory _PermissionState(
      {required final bool isLocationPermissionGranted,
      required final bool isLocationServicesEnabled}) = _$_PermissionState;
  const _PermissionState._() : super._();

  @override
  bool get isLocationPermissionGranted;
  @override
  bool get isLocationServicesEnabled;
  @override
  @JsonKey(ignore: true)
  _$$_PermissionStateCopyWith<_$_PermissionState> get copyWith =>
      throw _privateConstructorUsedError;
}
