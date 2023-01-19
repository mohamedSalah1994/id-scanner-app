import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  Position? currentPosition;
  bool isServiceEnabled = false;
  static LocationPermission? permission;

  Future<Position?> getCurrentLocation() async {
    // check if location service (GPS) is enabled, if not, try to enable it
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      try {
        // try to open location service
        await Geolocator.getCurrentPosition();
        isServiceEnabled = true;
      } catch (e) {
        // if user didn't enable the location service
        return null;
      }
    }
    // when location service is enabled & permission isn't denied, get the current location

    currentPosition = await Geolocator.getCurrentPosition();

    update();
    return currentPosition;
  }

  Future<void> getLocationPermission() async {
    // check if the user gives the permission to the device to access location
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
  }

  Future<String?> getCurrentAddress() async {
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(
        currentPosition!.latitude,
        currentPosition!.longitude,
        localeIdentifier: 'ar-EG',
      );

      //الحلمية
      // List<Placemark> placeMarks = await placemarkFromCoordinates(
      //   30.500936778698915,
      //   31.652379225069065,
      //   localeIdentifier: 'ar-EG',
      // );

      // عزبة الحكر - كفر أباظة
      // List<Placemark> placeMarks = await placemarkFromCoordinates(
      //   30.49721415430686,
      //   31.58256411212792,
      //   localeIdentifier: 'ar-EG',
      // );

      // print(placeMarks.last.street);
      // print(' ${placeMarks.last.locality} '
      //     '،${placeMarks.last.subAdministrativeArea} '
      //     '،${placeMarks.last.administrativeArea}');
      // for (var placeMark in placeMarks) {
      //   print(placeMark);
      //   print('==============================================');
      // }
      return placeMarks.last.street;
    } catch (e) {
      return null;
    }
  }
}
