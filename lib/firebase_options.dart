import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'API_KEY',
    appId: '1:653391736394:android:b0928826e0287d44da00b3',
    messagingSenderId: '653391736394',
    projectId: 'synctasks-1e850',
    storageBucket: 'synctasks-1e850.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'API_KEY',
    appId: '1:653391736394:ios:e54ed29005d63a40da00b3',
    messagingSenderId: '653391736394',
    projectId: 'synctasks-1e850',
    storageBucket: 'synctasks-1e850.appspot.com',
    iosBundleId: 'com.todo.synctasks',
  );
}
