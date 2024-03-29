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
    apiKey: 'AIzaSyBIYG32xq9aWqF_FF6sZIilCuS7quLNj80',
    appId: '1:413910966493:web:5c504625acf8ca7deefb34',
    messagingSenderId: '413910966493',
    projectId: 'football-app-tfg',
    authDomain: 'football-app-tfg.firebaseapp.com',
    storageBucket: 'football-app-tfg.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBOgXG9P2axo1GauMLRoGTE431oic6gg2Y',
    appId: '1:413910966493:android:8efedd1f281624c6eefb34',
    messagingSenderId: '413910966493',
    projectId: 'football-app-tfg',
    storageBucket: 'football-app-tfg.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDLXHqNIi7VzEPNYsAt2sFNhY34MDNiXak',
    appId: '1:413910966493:ios:667c43200c4048cfeefb34',
    messagingSenderId: '413910966493',
    projectId: 'football-app-tfg',
    storageBucket: 'football-app-tfg.appspot.com',
    iosClientId: '413910966493-fbo2glhlbrbk0mmennpjq3ghjf4n1ntj.apps.googleusercontent.com',
    iosBundleId: 'com.example.footballClubApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDLXHqNIi7VzEPNYsAt2sFNhY34MDNiXak',
    appId: '1:413910966493:ios:667c43200c4048cfeefb34',
    messagingSenderId: '413910966493',
    projectId: 'football-app-tfg',
    storageBucket: 'football-app-tfg.appspot.com',
    iosClientId: '413910966493-fbo2glhlbrbk0mmennpjq3ghjf4n1ntj.apps.googleusercontent.com',
    iosBundleId: 'com.example.footballClubApp',
  );
}
