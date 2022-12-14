// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCv5CgXZk9Cdrr2pt30IPALSv-cYSZUoiY',
    appId: '1:852534332911:web:4609e2790f41f19a483a1a',
    messagingSenderId: '852534332911',
    projectId: 'smart-mess-db',
    authDomain: 'smart-mess-db.firebaseapp.com',
    databaseURL: 'https://smart-mess-db-default-rtdb.firebaseio.com',
    storageBucket: 'smart-mess-db.appspot.com',
    measurementId: 'G-YFFNFHBF28',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDSrkJWhkNA9FpFzjR28KDArSjHzXfE1Xc',
    appId: '1:852534332911:android:f4a6df52c4478921483a1a',
    messagingSenderId: '852534332911',
    projectId: 'smart-mess-db',
    databaseURL: 'https://smart-mess-db-default-rtdb.firebaseio.com',
    storageBucket: 'smart-mess-db.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAMcTE6sPcvqIq-TssspmKQk-j7oKTYsT0',
    appId: '1:852534332911:ios:405e1334729e29b5483a1a',
    messagingSenderId: '852534332911',
    projectId: 'smart-mess-db',
    databaseURL: 'https://smart-mess-db-default-rtdb.firebaseio.com',
    storageBucket: 'smart-mess-db.appspot.com',
    iosClientId: '852534332911-hcmqlglqbebah28qhkuera08ceprk9gb.apps.googleusercontent.com',
    iosBundleId: 'com.example.smartmess',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAMcTE6sPcvqIq-TssspmKQk-j7oKTYsT0',
    appId: '1:852534332911:ios:405e1334729e29b5483a1a',
    messagingSenderId: '852534332911',
    projectId: 'smart-mess-db',
    databaseURL: 'https://smart-mess-db-default-rtdb.firebaseio.com',
    storageBucket: 'smart-mess-db.appspot.com',
    iosClientId: '852534332911-hcmqlglqbebah28qhkuera08ceprk9gb.apps.googleusercontent.com',
    iosBundleId: 'com.example.smartmess',
  );
}
