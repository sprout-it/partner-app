import 'package:flutter/material.dart';
import 'package:sprout_partner/screen/Root.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  settings();
  FirebaseMessaging.onBackgroundMessage(backgroundMessage);
  runApp(ProviderScope(child: Route()));
}

FirebaseMessaging messaging = FirebaseMessaging.instance;

Future<void> foregroundMessage(RemoteMessage message) async {
  print(message);
}

Future<void> backgroundMessage(RemoteMessage message) async {
  print('message ==> ' + message.data.toString());
}

Future<void> settings() async {
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print(settings.authorizationStatus);
}

class Route extends HookWidget {
  @override
  Widget build(BuildContext context) {
    useEffect(() {
      settings();
      messaging.getInitialMessage();
      FirebaseMessaging.onMessage.listen((event) {
        print(event.data);
      });
      messaging.getToken().then((value) => print(value.toString()));
      return;
    }, []);

    return MaterialApp(home: Root());
  }
}
