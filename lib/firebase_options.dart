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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyApqIwYGVRfpS1gg-nHuIeo4oZtZnCURVs',
    appId: '1:341585042809:android:418dbfc1373e1d4dd663a8',
    messagingSenderId: '341585042809',
    projectId: 'flu5-7573d',
    databaseURL: 'https://flu5-7573d-default-rtdb.firebaseio.com',
    storageBucket: 'flu5-7573d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDSGe7DUntkLLUpj9pw9ZV4ZkvkeHUTLSQ',
    appId: '1:341585042809:ios:5091c5e24f9d0029d663a8',
    messagingSenderId: '341585042809',
    projectId: 'flu5-7573d',
    databaseURL: 'https://flu5-7573d-default-rtdb.firebaseio.com',
    storageBucket: 'flu5-7573d.appspot.com',
    iosClientId: '341585042809-praqg8o5qpvro0kctcedas265pthigq0.apps.googleusercontent.com',
    iosBundleId: 'com.example.chat',
  );
}
