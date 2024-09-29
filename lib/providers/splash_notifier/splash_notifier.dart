import 'package:flutter/foundation.dart';
import 'package:sync_tasks/bos/user_data_bo/user_data_bo.dart';
import 'package:sync_tasks/services/platform/hive_service/ihive_service.dart';
import 'package:sync_tasks/services/platform/shared_preferences_service/ishared_preferences_service.dart';
import 'package:sync_tasks/util/constants.dart';
import 'package:sync_tasks/util/extensions.dart';

class SplashNotifier extends ChangeNotifier {
  final ISharedPreferencesService sharedPreferencesService;
  final IHiveService hiveService;

  SplashNotifier(
      {required this.sharedPreferencesService, required this.hiveService});

  Future<bool> getUserLoginStatus() async {
    try {
      UserDataBO? userData = await hiveService.loadItem(
          HiveBoxes.userBox.name, HiveKey.userData.name);

      await Future.delayed(const Duration(seconds: 1));

      return userData != null;
    } catch (ex) {
      ex.logError();
      return false;
    }
  }

  Future<bool> navigateUser() async {
    try {
      bool? isBiometricEnabled = await sharedPreferencesService
          .getBool(SharedPreferenceKeys.isBiometricEnabled.name);

      await Future.delayed(const Duration(seconds: 1));

      return isBiometricEnabled ?? false;
    } catch (ex) {
      ex.logError();
      return false;
    }
  }
}
