import 'dart:async';

import 'package:geolocator/geolocator.dart';

//By default Geolocator will use FusedLocationProviderClient on Android when Google Play Services are available.
// It will fall back to LocationManager when it is not available.
// You can override the behaviour by setting forceAndroidLocationManager
final Geolocator geoLocator = Geolocator();
//  ..forceAndroidLocationManager = true;

//To check if location services are enabled
Future<GeolocationStatus> get geolocationStatus =>
    geoLocator.checkGeolocationPermissionStatus();

//To get the current position coordinates
Future<Position> get currentPosition => geoLocator.getCurrentPosition();

//To get the last known position coordinates
Future<Position> get lastKnowPosition => geoLocator.getLastKnownPosition();

//To get the current placeMark object
Future<Placemark> get currentPlaceMark async =>
    getPlaceMark(await currentPosition);

//To get the placeMark object from the given position coordinates
Future<Placemark> getPlaceMark(Position position) async {
  List<Placemark> placeMarkList = await geoLocator.placemarkFromCoordinates(
      position.latitude, position.longitude);

  for (Placemark place in placeMarkList) {
    print(''' PlaceMark(
          name: ${place.name},
          isoCountryCode: ${place.isoCountryCode},
          country: ${place.country},
          postalCode: ${place.postalCode},
          administrativeArea: ${place.administrativeArea},
          subAdministrativeArea: ${place.subAdministrativeArea},
          locality: ${place.locality},
          subLocality: ${place.subLocality},
          thoroughfare: ${place.thoroughfare},
          subThoroughfare: ${place.subThoroughfare},
          positio: ${place.position},
        )''');
  }

  return placeMarkList[0];
}

String placeMarkDataToString(Placemark place) {
  return ''' PlaceMark(
          name: ${place.name},
          isoCountryCode: ${place.isoCountryCode},
          country: ${place.country},
          postalCode: ${place.postalCode},
          administrativeArea: ${place.administrativeArea},
          subAdministrativeArea: ${place.subAdministrativeArea},
          locality: ${place.locality},
          subLocality: ${place.subLocality},
          thoroughfare: ${place.thoroughfare},
          subThoroughfare: ${place.subThoroughfare},
          positio: ${place.position},
        )''';
}

LocationOptions locationOptions =
    LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

//To listen for location changes
StreamSubscription<Position> positionStream =
    geoLocator.getPositionStream(locationOptions).listen((Position position) {
  print(position == null
      ? 'Unknown'
      : position.latitude.toString() + ', ' + position.longitude.toString());
});
