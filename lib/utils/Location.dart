import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UserLocation {
  final double latitude;
  final double longitude;
  UserLocation({this.latitude, this.longitude});
}

class LocationService extends HookWidget {
  Widget build(BuildContext context) {
    final lat = useState(0.0);
    final lng = useState(0.0);
    var location = Location();
    UserLocation userLocation = UserLocation();

    useEffect(() {
      location.enableBackgroundMode(enable: true);
      location.requestPermission().then((granted) {
        if (granted != null) {
          location.onLocationChanged.listen((locationData) {
            if (locationData != null) {
              lat.value = locationData.latitude;
              lng.value = locationData.longitude;
            }
          });
        }
      });
      return;
    }, const []);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('LocationTest'),
      ),
      body: Text('lat: ${lat.value} lng: ${lng.value}'),
    ));
  }
  // UserLocation _currentLocation;
  // var location = Location();

  // LocationService() {
  //   // Request permission to use location
  //   location.requestPermission().then((granted) {
  //     if (granted != null) {
  //       // If granted listen to the onLocationChanged stream and emit over our controller
  //       location.onLocationChanged.listen((locationData) {
  //         if (locationData != null) {
  //           _locationController.add(UserLocation(
  //             latitude: locationData.latitude,
  //             longitude: locationData.longitude,
  //           ));
  //         }
  //       });
  //     }
  //   });

  // }

  // Future<UserLocation> getLocation() async {
  //   try {
  //     var userLocation = await location.getLocation();
  //     _currentLocation = UserLocation(
  //       latitude: userLocation.latitude,
  //       longitude: userLocation.longitude,
  //     );
  //   } on Exception catch (e) {
  //     print('Could not get location: ${e.toString()}');
  //   }
  //   return _currentLocation;
  // }
}
