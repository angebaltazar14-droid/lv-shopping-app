import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Generated manually for LV App
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
        return ios;

      case TargetPlatform.windows:
        return web;

      case TargetPlatform.linux:
        return web;

      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // WEB
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "PASTE_YOUR_API_KEY",
    authDomain: "lv-app-807ab.firebaseapp.com",
    projectId: "lv-app-807ab",
    storageBucket: "lv-app-807ab.appspot.com",
    messagingSenderId: "PASTE_YOUR_SENDER_ID",
    appId: "PASTE_YOUR_WEB_APP_ID",
    measurementId: "PASTE_YOUR_MEASUREMENT_ID",
  );

  // ANDROID
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "PASTE_YOUR_API_KEY",
    appId: "PASTE_YOUR_ANDROID_APP_ID",
    messagingSenderId: "PASTE_YOUR_SENDER_ID",
    projectId: "lv-app-807ab",
    storageBucket: "lv-app-807ab.appspot.com",
  );

  // IOS
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "PASTE_YOUR_API_KEY",
    appId: "PASTE_YOUR_IOS_APP_ID",
    messagingSenderId: "PASTE_YOUR_SENDER_ID",
    projectId: "lv-app-807ab",
    storageBucket: "lv-app-807ab.appspot.com",
    iosBundleId: "com.example.lv",
  );
}