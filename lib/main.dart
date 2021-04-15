import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:location/location.dart';
import 'package:sprout_partner/utils/Location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(UseStateExample());

class UseStateExample extends HookWidget {
  static final CameraPosition camera = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    final index = useState(0);
    final Location _location = Location();
    GoogleMapController _controller;

    useEffect(() {
      _location.onLocationChanged.listen((newLocalData) {
        if (_controller != null) {
          _controller.animateCamera(CameraUpdate.newCameraPosition(
              new CameraPosition(
                  bearing: 192.8334901395799,
                  target: LatLng(newLocalData.latitude, newLocalData.longitude),
                  tilt: 0,
                  zoom: 18.00)));
        }
      });
      return;
    }, const []);

    void _onItemTapped(int myIndex) {
      print(myIndex);
      index.value = myIndex;
    }

    return MaterialApp(
        home: SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: camera,
              buildingsEnabled: false,
              trafficEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
              },
              onCameraMove: (position) => print(position),
            ),
            Align(
              alignment: Alignment.center,
              child: Icon(Icons.person_pin_circle, size: 40.0),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb_outline_rounded),
              label: 'Discover',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              label: 'Wallet',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.money),
              label: 'Earnings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit),
              label: 'Profile',
            ),
          ],
          currentIndex: index.value,
          onTap: _onItemTapped,
          selectedItemColor: Colors.green[500],
          unselectedItemColor: Colors.green[200],
          showSelectedLabels: true,
          showUnselectedLabels: true,
        ),
      ),
    ));
  }
}
