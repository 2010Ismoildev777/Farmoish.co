import 'dart:async';

import 'package:farmoish/features/auth/data/datasource/firebase/auth/signout/sign_out.dart';
import 'package:farmoish/features/auth/presentation/screens/home/customer/profile/profile_page.dart';
import 'package:farmoish/features/auth/presentation/screens/register/registration/registration_role_selection.dart';
import 'package:farmoish/map/data/models/app_lat_long.dart';
import 'package:farmoish/map/data/service/app_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapPage extends ConsumerStatefulWidget {
  final Widget userIconWidget;
  const MapPage({super.key, required this.userIconWidget});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  @override
  void initState() {
    super.initState();
    _moveToDushanbe();
    _initPermission().ignore();
  }

  final mapController = Completer<YandexMapController>();
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          YandexMap(
            mapType: MapType.vector,
            onMapCreated: (controller) async {
              mapController.complete(controller);
              await controller.toggleUserLayer(visible: true);
            },
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 5,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Image.asset(
                      'images/image/google.png',
                      width: 20,
                    ),
                    hintText: 'Поиск',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.blueGrey,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => ProfilePage(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: widget.userIconWidget,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            bottom: 16,
            child: IconButton(
              onPressed: () async {
                await ref.read(signOutProvider.notifier).signOut();
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => RegistrationRoleSelection(),
                  ),
                );
              },
              icon: Icon(Icons.exit_to_app, size: 30, color: Colors.red),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _fetchCurrentLocation();
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.location_searching, color: Colors.white),
      ),
    );
  }

  Future<void> _initPermission() async {
    if (!await LocationService().checkPermission()) {
      await LocationService().requestPermission();
    }
  }

  Future<void> _fetchCurrentLocation() async {
    AppLatLong location;
    const defLocation = DushanbeLocation();
    try {
      location = await LocationService().getCurrentLocation();
    } catch (_) {
      location = defLocation;
    }
    _moveToCurrentLocation(location);
  }

  Future<void> _moveToCurrentLocation(AppLatLong appLatLong) async {
    (await mapController.future).moveCamera(
      animation: const MapAnimation(type: MapAnimationType.smooth, duration: 1),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(latitude: appLatLong.lat, longitude: appLatLong.long),
          zoom: 17,
          tilt: 50,
        ),
      ),
    );
  }

  Future<void> _moveToDushanbe() async {
    (await mapController.future).moveCamera(
      animation: const MapAnimation(type: MapAnimationType.smooth, duration: 1),
      CameraUpdate.newCameraPosition(
        const CameraPosition(
          target: Point(latitude: 38.5598, longitude: 68.7870),
          zoom: 12.3,
        ),
      ),
    );
  }
}
