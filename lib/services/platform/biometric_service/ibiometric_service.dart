import 'package:local_auth/local_auth.dart';

abstract class IBiometricService {
  Future<bool> canCheckBiometrics();
  Future<List<BiometricType>> availableBiometric();
  Future<bool> authenticate();
}
