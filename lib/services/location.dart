import 'package:geolocator/geolocator.dart';

//Object class for location data

class Location {
  double? latitude;
  double? longitude;

  //Get location of the device using the geoLocator plugin
  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

      latitude = position.latitude;
      longitude = position.longitude;

      print ("your position is:$position");

      //Geo locator works!

    } catch (e) {
      print(e);
    }
  }
}
