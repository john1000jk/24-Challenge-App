// Generated from android/app/google-services.json and
// ios/Runner/GoogleService-Info.plist (Firebase project challenge-5bdda).
// Equivalent to the output of `flutterfire configure`; re-run that command
// to regenerate this file if the Firebase apps change.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError('Firebase is not configured for web.');
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'Firebase is not configured for $defaultTargetPlatform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCLfbgj-1QDCmlRWI_c4nNMDJbzgK1Lf5k',
    appId: '1:865780213768:android:1c8508fc33346c5bb949bd',
    messagingSenderId: '865780213768',
    projectId: 'challenge-5bdda',
    databaseURL: 'https://challenge-5bdda.firebaseio.com',
    storageBucket: 'challenge-5bdda.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA7c-MoLSaIm4-bMNcStzuJupFoddsA3og',
    appId: '1:865780213768:ios:3a47dd18d87b8680b949bd',
    messagingSenderId: '865780213768',
    projectId: 'challenge-5bdda',
    databaseURL: 'https://challenge-5bdda.firebaseio.com',
    storageBucket: 'challenge-5bdda.firebasestorage.app',
    iosClientId: '865780213768-g0ecqhhuqbknjetpkev15ns1psro111u.apps.googleusercontent.com',
    iosBundleId: 'com.example.twentyFourGame',
  );
}
