import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clean_flutter/domain/permission/location_permission_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../domain/permission/i_permission_service.dart';

part 'permission_state.dart';

part 'permission_cubit.freezed.dart';

@LazySingleton()
class PermissionCubit extends Cubit<PermissionState> {
  final IPermissionService _permissionService;
  late StreamSubscription _locationServicesStatusSubscription;

  PermissionCubit(this._permissionService) : super(PermissionState.initial()) {
    _permissionService.isLocationPermissionGranted().then((isLocationPermissionGranted) {
      emit(state.copyWith(isLocationPermissionGranted: isLocationPermissionGranted));
    });

    _permissionService.isLocationServicesEnabled().then((isLocationServicesEnabled) {
      emit(state.copyWith(isLocationServicesEnabled: isLocationServicesEnabled));
    });

    _locationServicesStatusSubscription =
        _permissionService.locationServicesStatusStream.listen((isLocationServicesEnabled) {
          emit(state.copyWith(isLocationServicesEnabled: isLocationServicesEnabled));
        });
  }

  void requestLocationPermission() async {
    final status = await _permissionService.requestLocationPermission();
    bool isGranted = status == LocationPermissionStatus.granted;
    emit(state.copyWith(isLocationPermissionGranted: isGranted));
  }

  @override
  Future<void> close() async {
    await _locationServicesStatusSubscription.cancel();
    return super.close();
  }
}
