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
    apiKey: 'AIzaSyB4nxq3ZOlFZvP-yu_w-WaU7Q2mAFcNZKc',
    appId: '1:857824543481:web:2ce6928ae372a94f255828',
    messagingSenderId: '857824543481',
    projectId: 'auvnet-app',
    authDomain: 'auvnet-app.firebaseapp.com',
    storageBucket: 'auvnet-app.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDyBQnKni-XzOWhfW4540ktR3l3cs8ECdc',
    appId: '1:857824543481:android:f9be2a52a6be7b10255828',
    messagingSenderId: '857824543481',
    projectId: 'auvnet-app',
    storageBucket: 'auvnet-app.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB-2EqXZreEul1_i7pQgQCBjxAWg_Xzyew',
    appId: '1:857824543481:ios:d6d5fd6b6e48694d255828',
    messagingSenderId: '857824543481',
    projectId: 'auvnet-app',
    storageBucket: 'auvnet-app.firebasestorage.app',
    iosBundleId: 'com.example.auvnetApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB-2EqXZreEul1_i7pQgQCBjxAWg_Xzyew',
    appId: '1:857824543481:ios:d6d5fd6b6e48694d255828',
    messagingSenderId: '857824543481',
    projectId: 'auvnet-app',
    storageBucket: 'auvnet-app.firebasestorage.app',
    iosBundleId: 'com.example.auvnetApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB4nxq3ZOlFZvP-yu_w-WaU7Q2mAFcNZKc',
    appId: '1:857824543481:web:9defca73f2e59867255828',
    messagingSenderId: '857824543481',
    projectId: 'auvnet-app',
    authDomain: 'auvnet-app.firebaseapp.com',
    storageBucket: 'auvnet-app.firebasestorage.app',
  );
}
