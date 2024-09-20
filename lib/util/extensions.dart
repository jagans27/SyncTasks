import 'package:sync_tasks/util/constants.dart';
import 'package:sync_tasks/util/snackbar_helper.dart';

extension ExceptionLogger on Object {
  void logError() {
    SnackkBarHelper.showMessge(message: "Some thing went wrong!");
    print(("-__-EXCEPTION OCCURED-__-"));
    print(toString());
    print(("----_____----"));
  }
}

extension TaskColorNameExtension on TaskColor {
  int get color {
    switch (this) {
      case TaskColor.bubblegumBlush:
        return 0xffFDEAEB;
      case TaskColor.lavenderMist:
        return 0xffF4EFFE;
      case TaskColor.mintCream:
        return 0xffEFFDEA;
      case TaskColor.cherryBlossom:
        return 0xffFDEAF9;
      case TaskColor.aquaHaze:
        return 0xffE5FFFC;
    }
  }
}
