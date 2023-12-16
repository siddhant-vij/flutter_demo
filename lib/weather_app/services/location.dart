import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

class Location {
  double? latitude;
  double? longitude;

  var logger = Logger();

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
      logger.i('Location fetched: ($latitude, $longitude)');
    } catch (e) {
      logger.e('Failed to get location', error: e);
    }
  }
}
