import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:sync_tasks/services/platform/biometric_service/ibiometric_service.dart';
import 'package:sync_tasks/services/platform/shared_preferences_service/ishared_preferences_service.dart';
part 'profile_model.g.dart';

class ProfileModel = _ProfileModelBase with _$ProfileModel;

abstract class _ProfileModelBase with Store {

  ISharedPreferencesService sharedPreferencesService = GetIt.I.get<ISharedPreferencesService>();
  IBiometricService biometricService = GetIt.I.get<IBiometricService>();
  
  @observable
  bool isBiometricEnabled = false;

  @action
  void setIsBiometricEnabled({required bool isBiometricEnabled}){
    this.isBiometricEnabled = isBiometricEnabled;
  }

}