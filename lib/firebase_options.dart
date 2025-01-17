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
    apiKey: 'AIzaSyCciSe4HfOQdTWAytg_6wHxr7XjO_ukXdg',
    appId: '1:306362069181:web:7162da77804077151dc7d4',
    messagingSenderId: '306362069181',
    projectId: 'e-commerce-app-4e115',
    authDomain: 'e-commerce-app-4e115.firebaseapp.com',
    storageBucket: 'e-commerce-app-4e115.appspot.com',
    measurementId: 'G-5DVKR5SF71',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDbdZ1zj4rXfvHSW8mYa5prW69lXVTzSbs',
    appId: '1:306362069181:android:9cf0490ba627fe4d1dc7d4',
    messagingSenderId: '306362069181',
    projectId: 'e-commerce-app-4e115',
    storageBucket: 'e-commerce-app-4e115.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB2vxyYBZoxY-7wxliGUqEokedZrW3Qnig',
    appId: '1:306362069181:ios:ab688f7977fb03241dc7d4',
    messagingSenderId: '306362069181',
    projectId: 'e-commerce-app-4e115',
    storageBucket: 'e-commerce-app-4e115.appspot.com',
    iosBundleId: 'com.example.ecomeranceApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB2vxyYBZoxY-7wxliGUqEokedZrW3Qnig',
    appId: '1:306362069181:ios:ab688f7977fb03241dc7d4',
    messagingSenderId: '306362069181',
    projectId: 'e-commerce-app-4e115',
    storageBucket: 'e-commerce-app-4e115.appspot.com',
    iosBundleId: 'com.example.ecomeranceApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCciSe4HfOQdTWAytg_6wHxr7XjO_ukXdg',
    appId: '1:306362069181:web:fad361b53fbc2bdb1dc7d4',
    messagingSenderId: '306362069181',
    projectId: 'e-commerce-app-4e115',
    authDomain: 'e-commerce-app-4e115.firebaseapp.com',
    storageBucket: 'e-commerce-app-4e115.appspot.com',
    measurementId: 'G-XZFYDNT67E',
  );
}
