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
    apiKey: 'AIzaSyA1UgZNjH4owbKGN075RelYNApShdm1nPE',
    appId: '1:595016246866:android:168b7169b858911f1ea18b',
    messagingSenderId: '595016246866',
    projectId: 'split-rex',
    storageBucket: 'split-rex.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCFEmSbV0YPk_xN3U7jJp1qeNUOBFN0fao',
    appId: '1:595016246866:ios:f3d3daf13f5039c31ea18b',
    messagingSenderId: '595016246866',
    projectId: 'split-rex',
    storageBucket: 'split-rex.appspot.com',
    androidClientId: '595016246866-aapa0bp38d5fh5t23fh4n14tghf4hu6a.apps.googleusercontent.com',
    iosClientId: '595016246866-a3orpcq78h8l315698tm0e4bqji9fosj.apps.googleusercontent.com',
    iosBundleId: 'com.example.splitRex',
  );
}
