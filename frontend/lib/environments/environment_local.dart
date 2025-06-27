import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commandos/environments/environment.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LocalEnvironment extends Environment {
  @override
  String get name => 'local';

  @override
  Future configure() async {
    await FirebaseAuth.instance.useAuthEmulator(Environment.get.host, 9099);
    FirebaseFirestore.instance.useFirestoreEmulator(Environment.get.host, 8080);
  }
}
