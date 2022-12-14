import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clean_flutter/application/application_life_cycle/application_life_cycle_cubit.dart';
import 'package:clean_flutter/application/permission/permission_cubit.dart';
import 'package:clean_flutter/domain/location/i_location_service.dart';
import 'package:clean_flutter/domain/location/location_model.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

part 'location_state.dart';
part 'location_cubit.freezed.dart';

///Annotating LocationCubit with @injectable means whenever you access it,
///it's going to return a new instance everytime.
@injectable
class LocationCubit extends Cubit<LocationState> {
  final ILocationService _locationService;
  final PermissionCubit _permissionCubit;
  final ApplicationLifeCycleCubit _applicationLifeCycleCubit;
  StreamSubscription<LocationModel>? _userPositionSubscription;
  StreamSubscription<List<PermissionState>>?
      _permissionStatePairSubscription;
  StreamSubscription<List<ApplicationLifeCycleState>>?
      _appLifecycleStatePairSubscription;

  LocationCubit(this._locationService, this._permissionCubit,
      this._applicationLifeCycleCubit)
      : super(LocationState.initial()) {
    if (_permissionCubit.state.isLocationPermissionGrantedAndServicesEnabled) {
      _userPositionSubscription =
          _locationService.positionStream.listen(_userPositionListener);
    }

    ///pairwise is used to check the changes in streams and it returns a
    ///list of streams u can use
    _permissionStatePairSubscription = _permissionCubit.stream
        .startWith(_permissionCubit.state)
        .pairwise()
        .listen(_emitUserPosition);

    _appLifecycleStatePairSubscription = _applicationLifeCycleCubit.stream
        .startWith(_applicationLifeCycleCubit.state)
        .pairwise()
        .listen(_checkIfUserIsInBackground);
  }

  Future<void> _checkIfUserIsInBackground(List<ApplicationLifeCycleState> pair) async {
      final previous = pair.first;
      final current = pair.last;
      final isLocationPermissionGrantedAndServicesEnabled =
          _permissionCubit.state.isLocationPermissionGrantedAndServicesEnabled;

      if (previous.isResumed != current.isResumed &&
          current.isResumed &&
          isLocationPermissionGrantedAndServicesEnabled) {
        await _userPositionSubscription?.cancel();
        _userPositionSubscription =
            _locationService.positionStream.listen(_userPositionListener);
      } else if (previous.isResumed != current.isResumed &&
          !current.isResumed) {
        await _userPositionSubscription?.cancel();
      }
    }

  Future<void> _emitUserPosition(List<PermissionState> pair) async {
    final previous = pair.first;
    final current = pair.last;

    if (previous.isLocationPermissionGrantedAndServicesEnabled !=
            current.isLocationPermissionGrantedAndServicesEnabled &&
        current.isLocationPermissionGrantedAndServicesEnabled) {
      await _userPositionSubscription?.cancel();
      _userPositionSubscription =
          _locationService.positionStream.listen(_userPositionListener);
    } else if (previous.isLocationPermissionGrantedAndServicesEnabled !=
            current.isLocationPermissionGrantedAndServicesEnabled &&
        !current.isLocationPermissionGrantedAndServicesEnabled) {
      _userPositionSubscription?.cancel();
    }
  }

  void _userPositionListener(LocationModel location) {
    emit(state.copyWith(userLocation: location));
  }

  @override
  Future<void> close() {
    _userPositionSubscription?.cancel();
    _permissionStatePairSubscription?.cancel();
    _appLifecycleStatePairSubscription?.cancel();
    return super.close();
  }
}
