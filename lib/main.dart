import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(UseStateExample());

class UseStateExample extends HookWidget {
  static final CameraPosition camera = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    final index = useState(0);
    final getOrder = useState(false);
    final Location _location = Location();
    final radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    final boxNav = SvgPicture.asset(
      'assets/images/remove.svg',
      color: Colors.grey[400],
      semanticsLabel: 'A red up arrow',
      height: 50,
    );

    GoogleMapController _controller;

    useEffect(() {
      _location.onLocationChanged.listen((localData) {
        var newLocalData = localData;

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
      index.value = myIndex;
    }

    return MaterialApp(
        home: SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[500],
          actions: [
            Row(
              children: [
                Text('รับงาน'),
                Switch(
                    value: getOrder.value,
                    onChanged: (bool newVal) {
                      getOrder.value = newVal;
                    })
              ],
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('User'),
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
              ),
              ListTile(
                title: Text('History'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Sprout Wallet'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Notification'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: SlidingUpPanel(
            borderRadius: radius,
            backdropEnabled: true,
            collapsed: Container(
              decoration: BoxDecoration(borderRadius: radius),
              child: Column(
                children: [
                  boxNav,
                ],
              ),
            ),
            panel: Center(
              child: Column(
                children: [
                  boxNav,
                  Column(
                    children: [
                      Row(
                        children: [Text('Credit')],
                      ),
                      ElevatedButton(
                        child: Text('รับงาน'),
                        onPressed: () => {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
                ),
                Align(
                  alignment: Alignment.center,
                  child: Icon(Icons.person_pin_circle, size: 40.0),
                ),
              ],
            )),
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
