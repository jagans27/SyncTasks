import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:sync_tasks/services/platform/shared_preferences_service/ishared_preferences_service.dart';
part 'splash_model.g.dart';

class SplashModel = _SplashModelBase with _$SplashModel;

abstract class _SplashModelBase with Store {
  ISharedPreferencesService sharedPreferencesService = GetIt.I.get<ISharedPreferencesService>();
}
