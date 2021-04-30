import 'package:firebase_core/firebase_core.dart' as firebase;
import 'package:firebase_database/firebase_database.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Firebase {
  Future<void> initFirebase() async {
    await firebase.Firebase.initializeApp();
  }

  DatabaseReference database() {
    initFirebase();
    return FirebaseDatabase().reference().child('test');
  }
}

final count = StateProvider((ref) => 0);
