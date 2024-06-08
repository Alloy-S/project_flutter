// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCnEx6k_LriXxJMPa8APliHo8lsNqVDMPI',
    appId: '1:672092911403:web:bc9d634514d8e29707776e',
    messagingSenderId: '672092911403',
    projectId: 'emart-flutter-8f9fa',
    authDomain: 'emart-flutter-8f9fa.firebaseapp.com',
    storageBucket: 'emart-flutter-8f9fa.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyASP48M7JnrlhMpSdmYINZST10r5837VjU',
    appId: '1:672092911403:android:cb436c81c5cbe21507776e',
    messagingSenderId: '672092911403',
    projectId: 'emart-flutter-8f9fa',
    storageBucket: 'emart-flutter-8f9fa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBRgXnm86mZoXXkQeU46g2ucuy2PyjISdw',
    appId: '1:672092911403:ios:c5943bcd58760dae07776e',
    messagingSenderId: '672092911403',
    projectId: 'emart-flutter-8f9fa',
    storageBucket: 'emart-flutter-8f9fa.appspot.com',
    iosBundleId: 'com.example.admins',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBRgXnm86mZoXXkQeU46g2ucuy2PyjISdw',
    appId: '1:672092911403:ios:c5943bcd58760dae07776e',
    messagingSenderId: '672092911403',
    projectId: 'emart-flutter-8f9fa',
    storageBucket: 'emart-flutter-8f9fa.appspot.com',
    iosBundleId: 'com.example.admins',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCnEx6k_LriXxJMPa8APliHo8lsNqVDMPI',
    appId: '1:672092911403:web:0fec619d6c0afe2d07776e',
    messagingSenderId: '672092911403',
    projectId: 'emart-flutter-8f9fa',
    authDomain: 'emart-flutter-8f9fa.firebaseapp.com',
    storageBucket: 'emart-flutter-8f9fa.appspot.com',
  );
}