import 'package:local_auth/local_auth.dart';
import 'package:sync_tasks/services/platform/biometric_service/ibiometric_service.dart';
import 'package:sync_tasks/util/extensions.dart';

class BiometricService extends IBiometricService {
  final LocalAuthentication _auth = LocalAuthentication();

  /// Checks if the device has biometric hardware available.
  @override
  Future<bool> canCheckBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } catch (ex) {
      print('Error checking biometrics: $ex');
      ex.logError();
      return false;
    }
  }

  /// Checks if biometric authentication is available and enrolled.
  @override
  Future<List<BiometricType>> availableBiometric() async {
    try {
      return await _auth.getAvailableBiometrics();
    } catch (ex) {
      print('Error getting available biometrics: $ex');
      ex.logError();
      return [];
    }
  }

  /// Authenticates the user using biometrics.
  @override
  Future<bool> authenticate() async {
    try {
      return await _auth.authenticate(
        localizedReason: 'Please authenticate to proceed',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );
    } catch (ex) {
      print('Error during authentication: $ex');
      ex.logError();
      return false;
    }
  }
}
