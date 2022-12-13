import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:clean_flutter/application/application_life_cycle/application_life_cycle_cubit.dart';
import 'package:clean_flutter/domain/permission/location_permission_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import '../../domain/permission/i_permission_service.dart';
part 'permission_state.dart';
part 'permission_cubit.freezed.dart';

@lazySingleton
class PermissionCubit extends Cubit<PermissionState> {
  final IPermissionService _permissionService;
  late StreamSubscription _locationServicesStatusSubscription;
  final ApplicationLifeCycleCubit _applicationLifeCycleCubit;
  late StreamSubscription<Iterable<ApplicationLifeCycleState>>
      _appLifecyleSubscription;

  PermissionCubit(this._permissionService, this._applicationLifeCycleCubit)
      : super(PermissionState.initial()) {
    _permissionService
        .isLocationPermissionGranted()
        .then((isLocationPermissionGranted) {
      emit(state.copyWith(
          isLocationPermissionGranted: isLocationPermissionGranted));
    });

    _permissionService
        .isLocationServicesEnabled()
        .then((isLocationServicesEnabled) {
      emit(
          state.copyWith(isLocationServicesEnabled: isLocationServicesEnabled));
    });

    _locationServicesStatusSubscription = _permissionService
        .locationServicesStatusStream
        .listen((isLocationServicesEnabled) {
      emit(
          state.copyWith(isLocationServicesEnabled: isLocationServicesEnabled));
    });

    _appLifecyleSubscription = _applicationLifeCycleCubit.stream
        .startWith(_applicationLifeCycleCubit.state)
        .pairwise()
        .listen(emitPermission);
  }

  void emitPermission(List<ApplicationLifeCycleState> pair) async {
    final previous = pair.first;
    final current = pair.last;

    if (previous.isResumed != current.isResumed && current.isResumed) {
      bool isGranted = await _permissionService.isLocationPermissionGranted();
      emit(state.copyWith(isLocationPermissionGranted: isGranted));
    }
  }

  void requestLocationPermission() async {
    final status = await _permissionService.requestLocationPermission();
    bool isGranted = status == LocationPermissionStatus.granted;
    emit(state.copyWith(isLocationPermissionGranted: isGranted));
  }

  @override
  Future<void> close() async {
    await _locationServicesStatusSubscription.cancel();
    await _appLifecyleSubscription.cancel();
    return super.close();
  }
}
