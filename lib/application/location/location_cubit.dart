import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clean_flutter/application/permission/permission_cubit.dart';
import 'package:clean_flutter/domain/location/i_location_service.dart';
import 'package:clean_flutter/domain/location/location_model.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

part 'location_state.dart';
part 'location_cubit.freezed.dart';

@injectable
class LocationCubit extends Cubit<LocationState> {
  final ILocationService _locationService;
  final PermissionCubit _permissionCubit;
  late StreamSubscription<LocationModel> _userPositionSubscription;
  late StreamSubscription<List<PermissionState>>
      _permissionStatePairSubscription;

  LocationCubit(this._locationService, this._permissionCubit)
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
  }

  void _emitUserPosition(List<PermissionState> pair){
    final previous = pair.first;
      final current = pair.last;

      if (previous.isLocationPermissionGrantedAndServicesEnabled !=
              current.isLocationPermissionGrantedAndServicesEnabled &&
          current.isLocationPermissionGrantedAndServicesEnabled) {
        _userPositionSubscription =
            _locationService.positionStream.listen(_userPositionListener);
      } else if (previous.isLocationPermissionGrantedAndServicesEnabled !=
              current.isLocationPermissionGrantedAndServicesEnabled &&
          !current.isLocationPermissionGrantedAndServicesEnabled) {
        _userPositionSubscription.cancel();
      }
  }

  void _userPositionListener(LocationModel location) {
    emit(state.copyWith(userLocation: location));
  }

  @override
  Future<void> close() {
    _userPositionSubscription.cancel();
    _permissionStatePairSubscription.cancel();
    return super.close();
  }
}
