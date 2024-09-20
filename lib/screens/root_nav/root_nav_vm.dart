import 'package:sync_tasks/screens/root_nav/root_nav_model.dart';
import 'package:sync_tasks/util/extensions.dart';

class RootNavVM extends RootNavModel {
  RootNavVM() {
    try {
    
    } catch (ex) {
      ex.logError();
    }
  }
  void updateCurrentIndex({required int index}) {
    try {
      setCurrentIndex(currentIndex: index);
    } catch (ex) {
      ex.logError();
    }
  }
}
