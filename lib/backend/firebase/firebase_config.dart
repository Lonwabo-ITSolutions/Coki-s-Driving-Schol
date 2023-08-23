import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDWrrssLgt04MYAHKCStaSUfmWRrwY_mBI",
            authDomain: "flutterflowquizapp.firebaseapp.com",
            projectId: "flutterflowquizapp",
            storageBucket: "flutterflowquizapp.appspot.com",
            messagingSenderId: "152168156906",
            appId: "1:152168156906:web:4a265593d32118524ad193",
            measurementId: "G-1TWLPR9CW2"));
  } else {
    await Firebase.initializeApp();
  }
}
