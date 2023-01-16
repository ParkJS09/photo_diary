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
    apiKey: 'AIzaSyBZwOiMCnATT-4oVyeC6j-C4CxsF_g2ZbM',
    appId: '1:323930363976:web:9f296bac65f3678c37e07d',
    messagingSenderId: '323930363976',
    projectId: 'pdiary',
    authDomain: 'pdiary.firebaseapp.com',
    storageBucket: 'pdiary.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBI-vI0-gMGPoLNZp3VrlQLSxkPHT-q_JE',
    appId: '1:323930363976:android:fb25c022cbabc5b137e07d',
    messagingSenderId: '323930363976',
    projectId: 'pdiary',
    storageBucket: 'pdiary.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAKm6Ccni_ljT0hL6cMF7Qii17UezgTYdc',
    appId: '1:323930363976:ios:f8ad32a7072af50137e07d',
    messagingSenderId: '323930363976',
    projectId: 'pdiary',
    storageBucket: 'pdiary.appspot.com',
    iosClientId: '323930363976-aarve2q5dmlopfk946je9upls99rii6d.apps.googleusercontent.com',
    iosBundleId: 'com.jscompany.today',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAKm6Ccni_ljT0hL6cMF7Qii17UezgTYdc',
    appId: '1:323930363976:ios:f8ad32a7072af50137e07d',
    messagingSenderId: '323930363976',
    projectId: 'pdiary',
    storageBucket: 'pdiary.appspot.com',
    iosClientId: '323930363976-aarve2q5dmlopfk946je9upls99rii6d.apps.googleusercontent.com',
    iosBundleId: 'com.jscompany.today',
  );
}