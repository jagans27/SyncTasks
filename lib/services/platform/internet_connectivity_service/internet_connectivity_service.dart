import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sync_tasks/util/extensions.dart';
import 'package:sync_tasks/services/platform/internet_connectivity_service/iinternet_connectivity_service.dart';

class InternetConnectivityService extends IInternetConnectivityService {
  @override
  Future<bool> getNetworkConnectivityStatus() async {
    try {
            final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      return
          !connectivityResult.contains(ConnectivityResult.none);
    } catch (ex) {
      ex.logError();
      return false;
    }
  }
}
