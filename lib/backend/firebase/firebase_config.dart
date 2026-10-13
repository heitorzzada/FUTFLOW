import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDArIi9E5Y0frinVAT5JCvLsSkcBDd5XK4",
            authDomain: "topicos-5f00d.firebaseapp.com",
            projectId: "topicos-5f00d",
            storageBucket: "topicos-5f00d.firebasestorage.app",
            messagingSenderId: "666873446268",
            appId: "1:666873446268:web:31b55e9002722efe7eeef9",
            measurementId: "G-D4HPZ61FQZ"));
  } else {
    await Firebase.initializeApp();
  }
}
