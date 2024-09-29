import 'package:google_sign_in/google_sign_in.dart';
import 'package:sync_tasks/services/firebase_authentication_service/ifirebase_authentication_service.dart';
import 'package:sync_tasks/util/extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthenticationService extends IFirebaseAuthenticationService {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  FirebaseAuthenticationService(
      {required this.firebaseAuth, required this.googleSignIn});

  @override
  Future<User?> signInWithGoogle() async {
    try {
       GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential =
            await firebaseAuth.signInWithCredential(credential);

        return userCredential.user;
      }
      return null;
    } catch (ex) {
      ex.logError();
      return null;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await firebaseAuth.signOut();
      await googleSignIn.signOut();
      return true;
    } catch (ex) {
      ex.logError();
      return false;
    }
  }

  @override
  Future<bool> deleteAccount() async {
    try {
      User? user = firebaseAuth.currentUser;

      if (user != null) {
        bool reauthenticated = await reauthenticate();
        if (reauthenticated) {
          await user.delete();
          await signOut();
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (ex) {
      ex.logError();
      return false;
    }
  }

  Future<bool> reauthenticate() async {
    try {
      User? user = firebaseAuth.currentUser;
      if (user == null) {
        return false;
      }

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await user.reauthenticateWithCredential(credential);
        return true;
      }
      return false;
    } catch (ex) {
      ex.logError();
      return false;
    }
  }
}
