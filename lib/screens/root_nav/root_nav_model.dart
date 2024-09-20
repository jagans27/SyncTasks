import 'package:mobx/mobx.dart';
part 'root_nav_model.g.dart';

class RootNavModel = _RootNavModelBase with _$RootNavModel;

abstract class _RootNavModelBase with Store {
  @observable
  int currentIndex = 0;

  @action
  setCurrentIndex({required int currentIndex}) {
    this.currentIndex = currentIndex;
  }
}