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
    apiKey: 'AIzaSyDb8V-nxkP9PlgthObnPY88xan0Xagb3KE',
    appId: '1:481654966123:web:e40ce98ac78f1584816e2e',
    messagingSenderId: '481654966123',
    projectId: 'applicationmobile-3a448',
    authDomain: 'applicationmobile-3a448.firebaseapp.com',
    storageBucket: 'applicationmobile-3a448.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBUE8DdWV2u6GwqyzFMT9yVe0u889j60yI',
    appId: '1:481654966123:android:420c0c0279adb052816e2e',
    messagingSenderId: '481654966123',
    projectId: 'applicationmobile-3a448',
    storageBucket: 'applicationmobile-3a448.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC5UcxsjHJtbnShgJHM0Y1tnBp-xTrLsJs',
    appId: '1:481654966123:ios:ceb4377daebb5630816e2e',
    messagingSenderId: '481654966123',
    projectId: 'applicationmobile-3a448',
    storageBucket: 'applicationmobile-3a448.appspot.com',
    iosBundleId: 'com.example.testfirebaseprojet',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC5UcxsjHJtbnShgJHM0Y1tnBp-xTrLsJs',
    appId: '1:481654966123:ios:ca079ab4d36b10a5816e2e',
    messagingSenderId: '481654966123',
    projectId: 'applicationmobile-3a448',
    storageBucket: 'applicationmobile-3a448.appspot.com',
    iosBundleId: 'com.example.testfirebaseprojet.RunnerTests',
  );
}