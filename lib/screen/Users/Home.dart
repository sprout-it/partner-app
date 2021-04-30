import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../utils/GlobalState.dart' as state;
import 'package:url_launcher/url_launcher.dart';

class Users extends HookWidget {
  @override
  Widget build(BuildContext context) {
    const _url = 'https://www.google.co.th/maps/place/41.40338, 2.17403';
    void _launchURL() async => await canLaunch(_url)
        ? await launch(_url)
        : throw 'Could not launch $_url';
    final math = 0.0;
    final count = useProvider(state.count);

    return Scaffold(
      appBar: AppBar(
        title: Text('$math'),
      ),
      body: Column(
        children: [
          Center(
              child: ElevatedButton(
            child: Text('Back'),
            onPressed: () => Navigator.pop(context),
          )),
          Center(
              child: ElevatedButton(
            child: Text('Launch Url'),
            onPressed: () {
              _launchURL();
            },
          )),
          Text(count.state.toString())
        ],
      ),
    );
  }
}
