import 'package:clean_flutter/application/location/location_cubit.dart';
import 'package:clean_flutter/application/permission/permission_cubit.dart';
import 'package:clean_flutter/domain/location/location_model.dart';
import 'package:clean_flutter/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LocationCubit>(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<PermissionCubit, PermissionState>(
            listenWhen: (previous, current) {
              return previous.isLocationPermissionGrantedAndServicesEnabled !=
                      current.isLocationPermissionGrantedAndServicesEnabled &&
                  current.isLocationPermissionGrantedAndServicesEnabled;
            },
            listener: (context, state) {
              Navigator.pop(context);
            },
          ),
          BlocListener<PermissionCubit, PermissionState>(listenWhen: (p, c) {
            return p.displayOpenAppSettingsDialog !=
                    c.displayOpenAppSettingsDialog &&
                c.displayOpenAppSettingsDialog;
          }, listener: (context, state) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: AppSettingsDialog(
                    openAppSettings: () {
                      debugPrint("Open app settings button pressed");
                      context.read<PermissionCubit>().openAppSettings();
                    },
                    cancelDialog: () {
                      debugPrint("Cancel button pressed");
                      context
                          .read<PermissionCubit>()
                          .hideOpenAppSettingsDialog();
                    },
                  ),
                );
              },
            );
          }),
          BlocListener<PermissionCubit, PermissionState>(listenWhen: (p, c) {
            return p.displayOpenAppSettingsDialog !=
                    c.displayOpenAppSettingsDialog &&
                !c.displayOpenAppSettingsDialog;
          }, listener: (context, state) {
            Navigator.pop(context);
          }),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Map Tutorial"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocSelector<PermissionCubit, PermissionState, bool>(
                  selector: (state) {
                    return state.isLocationPermissionGranted;
                  },
                  builder: (context, isLocationPermissionGranted) {
                    return Text(
                        "Location Permission: ${isLocationPermissionGranted ? "Enabled" : "Disabled"}");
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocSelector<PermissionCubit, PermissionState, bool>(
                  selector: (state) {
                    return state.isLocationServicesEnabled;
                  },
                  builder: (context, isLocationServicesEnabled) {
                    return Text(
                        "Location Services: ${isLocationServicesEnabled ? "Enabled" : "Disabled"}");
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                OutlinedButton(
                  onPressed: () {
                    debugPrint("Location services button pressed");

                    showDialog(
                      context: context,
                      builder: (context) {
                        final isLocationPermissionGranted = context.select(
                            (PermissionCubit element) =>
                                element.state.isLocationPermissionGranted);
                        final isLocationServicesEnabled = context.select(
                          (PermissionCubit element) =>
                              element.state.isLocationServicesEnabled,
                        );
                        return AlertDialog(
                          content: PermissionDialog(
                            isLocationPermissionGranted:
                                isLocationPermissionGranted,
                            isLocationServicesEnabled:
                                isLocationServicesEnabled,
                          ),
                        );
                      },
                    );
                  },
                  child: const Text("Request Location Permission"),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocSelector<LocationCubit, LocationState, LocationModel>(
                  selector: (state) {
                    return state.userLocation;
                  },
                  builder: (context, userLocation) {
                    return Text(
                        "Latitude: ${userLocation.latitude}, Longitude: ${userLocation.longitude}");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PermissionDialog extends StatelessWidget {
  final bool isLocationPermissionGranted, isLocationServicesEnabled;
  const PermissionDialog(
      {super.key,
      required this.isLocationPermissionGranted,
      required this.isLocationServicesEnabled});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Please allow location permission and services to view your location",
            style: TextStyle(fontSize: 13),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Location Permission: "),
              TextButton(
                onPressed: isLocationPermissionGranted
                    ? null
                    : () {
                        debugPrint("Location permission button pressed");
                        context
                            .read<PermissionCubit>()
                            .requestLocationPermission();
                      },
                child: Text(isLocationPermissionGranted ? "Allowed" : "Allow"),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Location Services: "),
              TextButton(
                onPressed: isLocationServicesEnabled
                    ? null
                    : () {
                        debugPrint("Location service button pressed");
                        context.read<PermissionCubit>().openLocationSettings();
                      },
                child: Text(
                  isLocationServicesEnabled ? "Allowed" : "Allow",
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

class AppSettingsDialog extends StatelessWidget {
  final VoidCallback openAppSettings;
  final VoidCallback cancelDialog;
  const AppSettingsDialog(
      {super.key, required this.openAppSettings, required this.cancelDialog});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "You need to open app settings to grant location permission",
            style: TextStyle(fontSize: 13),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: openAppSettings,
                child: const Text(
                  "Open App Settings",
                ),
              ),
              TextButton(
                onPressed: cancelDialog,
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
