import 'package:sync_tasks/screens/splash/splash_model.dart';
import 'package:sync_tasks/util/constants.dart';
import 'package:sync_tasks/util/extensions.dart';

class SplashVM extends SplashModel {
  Future<bool?> navigateUser() async {
    try {
      bool? isBiometricEnabled =
          await sharedPreferencesService.getBool(SharedPreferenceKeys.isBiometricEnabled.name);

      await Future.delayed(const Duration(seconds: 3));

      if (isBiometricEnabled ?? false) {
        return true;
      } else {
        return false;
      }
    } catch (ex) {
      ex.logError();
      return null;
    }
  }
}
