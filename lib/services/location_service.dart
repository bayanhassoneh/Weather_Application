import 'package:geolocator/geolocator.dart';

class locationService {
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception('location services are disabled. ');
    }
    LocationPermission permession = await Geolocator.checkPermission();
    if (permession == LocationPermission.denied) {
      permession = await Geolocator.requestPermission();
    }
    if (permession == LocationPermission.denied) {
      throw Exception('location permession denied');
    }
    if (permession == LocationPermission.deniedForever) {
      throw Exception('location permession permanently denied');
    }
    return await Geolocator.getCurrentPosition();
  }
}
