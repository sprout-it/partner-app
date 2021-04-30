import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
          ListTile(
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
