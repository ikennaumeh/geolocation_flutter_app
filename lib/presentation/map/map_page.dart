import 'package:clean_flutter/application/location/location_cubit.dart';
import 'package:clean_flutter/application/permission/permission_cubit.dart';
import 'package:clean_flutter/domain/location/location_model.dart';
import 'package:clean_flutter/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
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
          body: Stack(
            children: [
              Center(
                child: BlocBuilder<LocationCubit, LocationState>(
                  buildWhen: (p, c) {
                    return p.userLocation != c.userLocation;
                  },
                  builder: (context, state) {
                    return FlutterMap(
                      options: MapOptions(
                        center: LatLng(51.509, -0.128),
                        zoom: 3.5,
                      ),
                      layers: [
                        TileLayerOptions(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.map_tutorial',
                        ),
                        MarkerLayerOptions(markers: [
                          Marker(
                              point: LatLng(state.userLocation.latitude,
                                  state.userLocation.longitude),
                              height: 60,
                              width: 60,
                              builder: (context) {
                                return const UserMarker();
                              }),
                        ]),
                      ],
                    );
                  },
                ),
              ),
              BlocSelector<PermissionCubit, PermissionState, bool>(
                selector: (state) {
                  return state.isLocationPermissionGrantedAndServicesEnabled;
                },
                builder:
                    (context, isLocationPermissionGrantedAndServicesEnabled) {
                  return isLocationPermissionGrantedAndServicesEnabled
                      ? const SizedBox.shrink()
                      : const Positioned(
                          right: 30,
                          bottom: 50,
                          child: LocationButton(),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserMarker extends StatefulWidget {
  const UserMarker({super.key});

  @override
  State<UserMarker> createState() => _UserMarkerState();
}

class _UserMarkerState extends State<UserMarker>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> sizeAnimation;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    sizeAnimation =
        Tween<double>(begin: 45, end: 60).animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));
    animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: sizeAnimation,
      builder: (context, child) {
        return Center(
          child: Container(
              height: sizeAnimation.value,
              width: sizeAnimation.value,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: child),
        );
      },
      child: const Icon(
        Icons.person_pin,
        color: Colors.white,
        size: 40,
      ),
    );
  }
}

class LocationButton extends StatelessWidget {
  const LocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (states) => Colors.black)),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              final bool isLocationPermissionGranted = context.select(
                  (PermissionCubit element) =>
                      element.state.isLocationPermissionGranted);
              final bool isLocationPermissionEnabled = context.select(
                  (PermissionCubit element) =>
                      element.state.isLocationServicesEnabled);
              return AlertDialog(
                content: PermissionDialog(
                  isLocationPermissionGranted: isLocationPermissionGranted,
                  isLocationServicesEnabled: isLocationPermissionEnabled,
                ),
              );
            });
      },
      child: const Text("Request Location Button"),
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
