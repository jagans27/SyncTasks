import 'package:firebase_auth/firebase_auth.dart';

abstract class IFirebaseAuthenticationService {
  Future<User?> signInWithGoogle();
  Future<bool> signOut();
  Future<bool> deleteAccount();
}
