import 'package:attandace_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationServices {
  Location location = Location();

  late LocationData locationData;

  Future<Map<String, double?>?> initialize(BuildContext context) async {
    PermissionStatus permissionGranted;
    bool serviceEnabled;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        Utils.showSnackBar(context, 'please enable location service');
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        Utils.showSnackBar(context, 'please allow location permission');
        return null;

      }
    }

    locationData = await location.getLocation();
    return {
      'latitude': locationData.latitude,
      'longitude': locationData.longitude,
    };
  }
}
