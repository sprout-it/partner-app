import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:location/location.dart';
import 'package:sprout_partner/utils/Location.dart';

void main() => runApp(UseStateExample());

class UseStateExample extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final index = useState(0);

    // useEffect(() {
    //   index.value = 2;
    //   return;
    // }, const []);

    void _onItemTapped(int myIndex) {
      print(myIndex);
      index.value = myIndex;
    }

    return MaterialApp(
        home: SafeArea(
      child: Scaffold(
        body: Center(child: LocationService()),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => index.value++,
        //   child: const Icon(Icons.add),
        // ),
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
