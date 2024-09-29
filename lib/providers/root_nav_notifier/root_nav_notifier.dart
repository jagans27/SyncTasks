import 'package:flutter/foundation.dart';
import 'package:sync_tasks/util/extensions.dart';

class RootNavNotifier extends ChangeNotifier {
  int currentIndex = 0;

  void updateCurrentIndex({required int index}) {
    try {
      currentIndex = index;
      notifyListeners();
    } catch (ex) {
      ex.logError();
    }
  }

  void resetCurrentIndex() {
    try {
      currentIndex = 0;
    } catch (ex) {
      ex.logError();
    }
  }
}
