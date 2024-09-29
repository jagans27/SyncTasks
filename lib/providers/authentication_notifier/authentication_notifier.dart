import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sync_tasks/services/platform/biometric_service/ibiometric_service.dart';
import 'package:sync_tasks/util/extensions.dart';
import 'package:sync_tasks/util/snackbar_helper.dart';

class AuthenticationNotifier extends ChangeNotifier {
  IBiometricService biometricService;

  AuthenticationNotifier({required this.biometricService});

  Future<bool> authenticate() async {
    try {
      List<BiometricType> availableServices =
          await biometricService.availableBiometric();
      bool canCheck = await biometricService.canCheckBiometrics();

      if (availableServices.isNotEmpty && canCheck) {
        final isAuthenticated = await biometricService.authenticate();
        if (isAuthenticated) {
          return true;
        } else {
          SnackkBarHelper.showMessge(
              message: "Please reauthenticate your self");
          return false;
        }
      } else {
        SnackkBarHelper.showMessge(message: "Some thing went wrong!");
        return false;
      }
    } catch (ex) {
      ex.logError();
      return false;
    }
  }
}
