import 'package:local_auth/local_auth.dart';
import 'package:sync_tasks/screens/profile/profile_model.dart';
import 'package:sync_tasks/util/constants.dart';
import 'package:sync_tasks/util/extensions.dart';
import 'package:sync_tasks/util/snackbar_helper.dart';

class ProfileVM extends ProfileModel {
  ProfileVM() {
    try {
      retrieveBiometricStatus();
    } catch (ex) {
      ex.logError();
    }
  }

  Future<void> updateBiometricStatus() async {
    try {
      bool canCheckBiometric = await biometricService.canCheckBiometrics();
      List<BiometricType> availableBiometric =
          await biometricService.availableBiometric();

      if (canCheckBiometric && availableBiometric.isNotEmpty) {
        bool isAuthenticated = await biometricService.authenticate();

        if (isAuthenticated) {
          setBiometricStatus();
        }
      } else {
        SnackkBarHelper.showMessge(message: "No Authentication available.");
      }
    } catch (ex) {
      ex.logError();
    }
  }

  Future<void> retrieveBiometricStatus() async {
    try {
      bool? biometricStatus = await sharedPreferencesService
          .getBool(SharedPreferenceKeys.isBiometricEnabled.name);

      setIsBiometricEnabled(isBiometricEnabled: biometricStatus ?? false);
    } catch (ex) {
      ex.logError();
    }
  }

  Future<void> setBiometricStatus() async {
    try {
      bool? biometricStatus = await sharedPreferencesService.setBool(
          SharedPreferenceKeys.isBiometricEnabled.name, !isBiometricEnabled);

      if (biometricStatus) {
        setIsBiometricEnabled(isBiometricEnabled: !isBiometricEnabled);
      } else {
        SnackkBarHelper.showMessge(message: "Some thing went wrong.");
      }
    } catch (ex) {
      ex.logError();
    }
  }
}
