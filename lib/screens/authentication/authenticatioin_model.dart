import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:sync_tasks/services/platform/biometric_service/ibiometric_service.dart';
part 'authenticatioin_model.g.dart';

class AuthenticationModel = _AuthenticationModelBase with _$AuthenticationModel;

abstract class _AuthenticationModelBase with Store {
  
  IBiometricService biometricService = GetIt.I.get<IBiometricService>();

}