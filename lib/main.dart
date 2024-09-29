import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sync_tasks/app.dart';
import 'package:sync_tasks/bos/ai_statement_bo/ai_statement_bo.dart';
import 'package:sync_tasks/bos/task_bo/task_bo.dart';
import 'package:sync_tasks/bos/user_data_bo/user_data_bo.dart';
import 'package:sync_tasks/providers/authentication_notifier/authentication_notifier.dart';
import 'package:sync_tasks/providers/login_notifier/login_notifier.dart';
import 'package:sync_tasks/providers/profile_notifier/profile_notifier.dart';
import 'package:sync_tasks/providers/root_nav_notifier/root_nav_notifier.dart';
import 'package:sync_tasks/providers/splash_notifier/splash_notifier.dart';
import 'package:sync_tasks/providers/task_notifier/task_notifier.dart';
import 'package:sync_tasks/services/device/camera_service/camera_service.dart';
import 'package:sync_tasks/services/device/camera_service/icamera_service.dart';
import 'package:sync_tasks/services/device/local_push_notification_service/ilocal_push_notification_service.dart';
import 'package:sync_tasks/services/device/local_push_notification_service/local_push_notification_service.dart';
import 'package:sync_tasks/services/firebase_authentication_service/firebase_authentication_service.dart';
import 'package:sync_tasks/services/firebase_authentication_service/ifirebase_authentication_service.dart';
import 'package:sync_tasks/services/gemini_ai_service/gemini_ai_service.dart';
import 'package:sync_tasks/services/gemini_ai_service/igemini_ai_service.dart';
import 'package:sync_tasks/services/platform/biometric_service/biometric_service.dart';
import 'package:sync_tasks/services/platform/biometric_service/ibiometric_service.dart';
import 'package:sync_tasks/services/platform/hive_service/hive_service.dart';
import 'package:sync_tasks/services/platform/hive_service/ihive_service.dart';
import 'package:sync_tasks/services/platform/internet_connectivity_service/iinternet_connectivity_service.dart';
import 'package:sync_tasks/services/platform/internet_connectivity_service/internet_connectivity_service.dart';
import 'package:sync_tasks/services/platform/shared_preferences_service/ishared_preferences_service.dart';
import 'package:sync_tasks/services/platform/shared_preferences_service/shared_preferences_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // Ensure that the Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Set potrate only for app
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // initialize firebase options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Hive
  final Directory appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);

  // Register your adapters
  Hive.registerAdapter(TaskItemAdapter());
  Hive.registerAdapter(TaskBOAdapter());
  Hive.registerAdapter(AIStatementBOAdapter());
  Hive.registerAdapter(UserDataBOAdapter());

  // initialize singleton instance
  GetIt.instance.registerSingleton<IBiometricService>(BiometricService());
  GetIt.instance.registerSingleton<ISharedPreferencesService>(
      SharedPreferencesService(await SharedPreferences.getInstance()));
  GetIt.instance
      .registerSingleton<ICameraService>(CameraService(ImagePicker()));
  GetIt.instance.registerSingleton<IHiveService>(HiveService());
  GetIt.instance.registerSingleton<IInternetConnectivityService>(
      InternetConnectivityService());
  GetIt.instance.registerSingleton<IGeminiAIService>(GeminiAIService());
  GetIt.instance.registerSingleton<ILocalPushNotificationService>(
      LocalPushNotificationService(
          flutterLocalNotificationsPlugin: FlutterLocalNotificationsPlugin()));
  GetIt.instance.registerSingleton<IFirebaseAuthenticationService>(
      FirebaseAuthenticationService(
          firebaseAuth: FirebaseAuth.instance, googleSignIn: GoogleSignIn(scopes: ['profile', 'email'])));

  // Invoke run app with multiple provider
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
        create: (context) => AuthenticationNotifier(
            biometricService: GetIt.I<IBiometricService>())),
    ChangeNotifierProvider(
        create: (context) => ProfileNotifier(
            sharedPreferencesService: GetIt.I<ISharedPreferencesService>(),
            biometricService: GetIt.I<IBiometricService>(),
            internetConnectivityService:
                GetIt.I<IInternetConnectivityService>(),
            geminiAIService: GetIt.I<IGeminiAIService>(),
            hiveService: GetIt.I<IHiveService>(),
            firebaseAuthenticationService:
                GetIt.I<IFirebaseAuthenticationService>(),
            localPushNotificationService:
                GetIt.I<ILocalPushNotificationService>())),
    ChangeNotifierProvider(create: (context) => RootNavNotifier()),
    ChangeNotifierProvider(
        create: (context) => SplashNotifier(
            sharedPreferencesService: GetIt.I<ISharedPreferencesService>(),
            hiveService: GetIt.I<IHiveService>())),
    ChangeNotifierProvider(
        create: (context) => TaskNotifier(
              cameraService: GetIt.I<ICameraService>(),
              hiveService: GetIt.I<IHiveService>(),
              localPushNotificationService:
                  GetIt.I<ILocalPushNotificationService>(),
            )),
    ChangeNotifierProvider(
        create: (context) => LoginNotifier(
            hiveService: GetIt.I<IHiveService>(),
            firebaseAuthService: GetIt.I<IFirebaseAuthenticationService>()))
  ], child: const App()));
}
