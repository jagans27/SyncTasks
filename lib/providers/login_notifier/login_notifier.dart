import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sync_tasks/bos/user_data_bo/user_data_bo.dart';
import 'package:sync_tasks/services/firebase_authentication_service/ifirebase_authentication_service.dart';
import 'package:sync_tasks/services/platform/hive_service/ihive_service.dart';
import 'package:sync_tasks/util/constants.dart';
import 'package:sync_tasks/util/extensions.dart';
import 'package:sync_tasks/util/snackbar_helper.dart';

class LoginNotifier extends ChangeNotifier {
  final IHiveService hiveService;
  final IFirebaseAuthenticationService firebaseAuthService;

  LoginNotifier({
    required this.hiveService,
    required this.firebaseAuthService,
  });

  Future<bool> signInWithGoogle() async {
    try {
      User? user = await firebaseAuthService.signInWithGoogle();

      if (user != null) {
        if (user.email == null) {
          SnackkBarHelper.showMessge(message: ErrorMessage.emailNotFoundError);
          return false;
        }

        UserDataBO userData = UserDataBO(
            name: user.displayName,
            email: user.email!,
            profileUrl: user.photoURL);

        await hiveService.addItem<UserDataBO>(
            HiveBoxes.userBox.name, HiveKey.userData.name, userData);

        return true;
      }
      return false;
    } catch (ex) {
      ex.logError();
      return false;
    }
  }
}
