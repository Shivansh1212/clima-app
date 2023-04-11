// ignore_for_file: avoid_print
import 'package:geolocator/geolocator.dart';

class Location {
  double longitude = 1;
  double lattitude = 1;

  Future<void> getcurrentlocation() async {
    try {
      // ignore: unused_local_variable
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      lattitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
