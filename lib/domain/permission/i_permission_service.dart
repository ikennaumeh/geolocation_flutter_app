import 'location_permission_status.dart';

abstract class IPermissionService {
  //if the user is granted location permission at that time
  Future<bool> isLocationPermissionGranted();
  //The changes in location permission state
  //If the user enabled location permission at that time
  Future<bool> isLocationServicesEnabled();
  //The changes in location service status
  Stream<bool> get locationServicesStatusStream;
  //Request location permission
  Future<LocationPermissionStatus> requestLocationPermission();
  //Open location settings
  Future<void> openLocationSettings();
  //Open app settings
  Future<void> openAppSettings();
}
