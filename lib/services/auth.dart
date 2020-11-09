import 'package:firebase_app1/models/user.dart';
import 'package:firebase_app1/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TheUser _userFromFireBaseUser(User user) {
    return user != null ? TheUser(uid: user.uid) : null;
  }

// Auth Change Stream
  Stream<TheUser> get user {
    return _auth.authStateChanges().map(_userFromFireBaseUser);
  }

  //signin anonymous
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;

      // Create a new Document for the user

      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // signin with email and pwd
  Future signInWithEmailandPwd(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
    }
  }

  // register with email n pwd
  Future registerWthEmandPwd(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await DatabaseServive(uid: user.uid)
          .updateUserData('0', 'new member', 500);
      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
    }
  }

  //signout
  Future SignOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
