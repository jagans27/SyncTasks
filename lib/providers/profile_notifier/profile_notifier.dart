import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sync_tasks/bos/ai_statement_bo/ai_statement_bo.dart';
import 'package:sync_tasks/bos/user_data_bo/user_data_bo.dart';
import 'package:sync_tasks/services/device/local_push_notification_service/ilocal_push_notification_service.dart';
import 'package:sync_tasks/services/firebase_authentication_service/ifirebase_authentication_service.dart';
import 'package:sync_tasks/services/gemini_ai_service/igemini_ai_service.dart';
import 'package:sync_tasks/services/platform/biometric_service/ibiometric_service.dart';
import 'package:sync_tasks/services/platform/hive_service/ihive_service.dart';
import 'package:sync_tasks/services/platform/internet_connectivity_service/iinternet_connectivity_service.dart';
import 'package:sync_tasks/services/platform/shared_preferences_service/ishared_preferences_service.dart';
import 'package:sync_tasks/util/constants.dart';
import 'package:sync_tasks/util/extensions.dart';
import 'package:sync_tasks/util/snackbar_helper.dart';

class ProfileNotifier extends ChangeNotifier {
  final IBiometricService biometricService;
  final ISharedPreferencesService sharedPreferencesService;
  final IInternetConnectivityService internetConnectivityService;
  final IGeminiAIService geminiAIService;
  final IHiveService hiveService;
  final IFirebaseAuthenticationService firebaseAuthenticationService;
  final ILocalPushNotificationService localPushNotificationService;
  bool isBiometricEnabled = false;
  String? workScore;
  UserDataBO? userData;
  bool networkConnectionError = false;

  ProfileNotifier(
      {required this.internetConnectivityService,
      required this.geminiAIService,
      required this.sharedPreferencesService,
      required this.biometricService,
      required this.hiveService,
      required this.firebaseAuthenticationService,
      required this.localPushNotificationService}) {
    loadUserData();
  }

  Future<void> updateBiometricStatus() async {
    try {
      bool canCheckBiometric = await biometricService.canCheckBiometrics();
      List<BiometricType> availableBiometric =
          await biometricService.availableBiometric();

      if (canCheckBiometric && availableBiometric.isNotEmpty) {
        bool isAuthenticated = await biometricService.authenticate();

        if (isAuthenticated) {
          setBiometricStatus();
        }
      } else {
        SnackkBarHelper.showMessge(message: "No Authentication available.");
      }
    } catch (ex) {
      ex.logError();
    }
  }

  Future<void> retrieveBiometricStatus() async {
    try {
      bool? biometricStatus = await sharedPreferencesService
          .getBool(SharedPreferenceKeys.isBiometricEnabled.name);

      isBiometricEnabled = biometricStatus ?? false;
      notifyListeners();
    } catch (ex) {
      ex.logError();
    }
  }

  Future<void> loadUserData() async {
    try {
      userData = await hiveService.loadItem<UserDataBO>(
          HiveBoxes.userBox.name, HiveKey.userData.name);

      notifyListeners();
    } catch (ex) {
      ex.logError();
    }
  }

  Future<void> setBiometricStatus() async {
    try {
      bool? biometricStatus = await sharedPreferencesService.setBool(
          SharedPreferenceKeys.isBiometricEnabled.name, !isBiometricEnabled);

      if (biometricStatus) {
        isBiometricEnabled = !isBiometricEnabled;
        notifyListeners();
      } else {
        SnackkBarHelper.showMessge(message: "Something went wrong.");
      }
    } catch (ex) {
      ex.logError();
    }
  }

  Future<void> getWorkScore() async {
    AIStatementBO? aiStatement = await hiveService.loadItem<AIStatementBO>(
        HiveBoxes.aiBox.name, HiveKey.aiData.name);

    String now = DateFormat("yyyy-MM-dd").format(DateTime.now());

    if (aiStatement == null || aiStatement.date != now) {
      getAIMotivationalStatement(date: now);
    } else {
      workScore = aiStatement.statement;
      notifyListeners();
    }
  }

  Future<void> getAIMotivationalStatement({required String date}) async {
    try {
      networkConnectionError = false;
      notifyListeners();
      
      bool connectivityStatus =
          await internetConnectivityService.getNetworkConnectivityStatus();

      if (connectivityStatus) {
        workScore = await geminiAIService.getWorkScore();

        if (workScore != null && workScore!.isNotEmpty) {
          await hiveService.addItem<AIStatementBO>(
              HiveBoxes.aiBox.name,
              HiveKey.aiData.name,
              AIStatementBO(date: date, statement: workScore!));

          workScore = workScore;
          notifyListeners();
        }
      } else {
        SnackkBarHelper.showMessge(message: ErrorMessage.connectInternetError);
        networkConnectionError = true;
        notifyListeners();
      }
    } catch (ex) {
      ex.logError();
      networkConnectionError = true;
      notifyListeners();
    }
  }

  Future<bool> signOutFromGoogle() async {
    try {
      bool isSignOutSuccess = await firebaseAuthenticationService.signOut();
      if (isSignOutSuccess) {
        List<String> boxNames =
            HiveBoxes.values.map((names) => names.name).toList();
        hiveService.deleteBox(boxNames);
        localPushNotificationService.deleteAllNotification();
        SnackkBarHelper.showMessge(
            message: SuccessMessage.logoutSuccessMessage);
        return true;
      } else {
        SnackkBarHelper.showMessge(message: ErrorMessage.signOutFailureError);
        return false;
      }
    } catch (ex) {
      ex.logError();
      return false;
    }
  }

  Future<bool> deleteAccount() async {
    try {
      bool isDeleteAccountSuccess =
          await firebaseAuthenticationService.deleteAccount();
      if (isDeleteAccountSuccess) {
        List<String> boxNames =
            HiveBoxes.values.map((names) => names.name).toList();
        hiveService.deleteBox(boxNames);
        sharedPreferencesService.setBool(
            SharedPreferenceKeys.isBiometricEnabled.name, false);
        localPushNotificationService.deleteAllNotification();
        SnackkBarHelper.showMessge(
            message: SuccessMessage.deleteSuccessMessage);
        return true;
      } else {
        SnackkBarHelper.showMessge(
            message: ErrorMessage.deleteAccountFailureError);
        return false;
      }
    } catch (ex) {
      ex.logError();
      return false;
    }
  }

  void resetData() {
    try {
      workScore = null;
      userData = null;
    } catch (ex) {
      ex.logError();
    }
  }
}
