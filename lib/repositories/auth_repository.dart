import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> userSignUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<void> userSignIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<void> userSignOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
