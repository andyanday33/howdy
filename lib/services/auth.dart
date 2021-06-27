import 'package:firebase_auth/firebase_auth.dart';
import 'package:howdy/models/customuser.dart';

class AuthenticationMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CustomUser? _customUserfromUser(User? user) {
    return user != null ? new CustomUser(userId: user.uid) : null;
  }

  Future? signInWithEmailandPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = result.user;
      return _customUserfromUser(firebaseUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future? signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = result.user;
      return _customUserfromUser(firebaseUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future? resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future? signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
