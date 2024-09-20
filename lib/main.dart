import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sync_tasks/app.dart';
import 'package:sync_tasks/services/device/camera_service.dart';
import 'package:sync_tasks/services/device/icamera_service.dart';
import 'package:sync_tasks/services/platform/biometric_service/biometric_service.dart';
import 'package:sync_tasks/services/platform/biometric_service/ibiometric_service.dart';
import 'package:sync_tasks/services/platform/shared_preferences_service/ishared_preferences_service.dart';
import 'package:sync_tasks/services/platform/shared_preferences_service/shared_preferences_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Set potrate only for app
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // initialize singleton instance
  GetIt.instance.registerSingleton<IBiometricService>(BiometricService());
  GetIt.instance.registerSingleton<ISharedPreferencesService>(
      SharedPreferencesService(await SharedPreferences.getInstance()));
  GetIt.instance
      .registerSingleton<ICameraService>(CameraService(ImagePicker()));

  // Testing
  // ISharedPreferencesService testingSharedPreferencesService =
  //     GetIt.I.get<ISharedPreferencesService>();
  // testingSharedPreferencesService.setBool(
  //     SharedPreferenceKeys.isBiometricEnabled.name, false);

  runApp(const App());
}
