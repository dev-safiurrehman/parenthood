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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCnPg37QJ6B_4JvKmb6U-IMjlMNn-MTuwE',
    appId: '1:365702523398:web:4c0364756e356ff5923187',
    messagingSenderId: '365702523398',
    projectId: 'parenthoodapp-flutter-db',
    authDomain: 'parenthoodapp-flutter-db.firebaseapp.com',
    storageBucket: 'parenthoodapp-flutter-db.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC00GHKFc_ersBvHpAxKlST_oebPrtyeI0',
    appId: '1:365702523398:android:ae3fb71fe967d303923187',
    messagingSenderId: '365702523398',
    projectId: 'parenthoodapp-flutter-db',
    storageBucket: 'parenthoodapp-flutter-db.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCWvLeu81rJe2CKg-MXqSHMs0lFZqk1Hyc',
    appId: '1:365702523398:ios:43e695a0359ab1d5923187',
    messagingSenderId: '365702523398',
    projectId: 'parenthoodapp-flutter-db',
    storageBucket: 'parenthoodapp-flutter-db.appspot.com',
    iosClientId: '365702523398-4tmrv6fm6tatti1jvotip9j9nce5f577.apps.googleusercontent.com',
    iosBundleId: 'com.example.parenthood',
  );
}
