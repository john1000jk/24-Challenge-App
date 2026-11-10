import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:twenty_four_game/services/database.dart';

import '../models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create app user object based on Firebase User
  AppUser? _userFromFirebaseUser(User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  // authentication change user stream
  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // sign in with email and password
  Future<AppUser?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebaseUser(result.user);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // register with email and password
  Future<AppUser?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = result.user!;
      // create a new document for the user with the given uid
      await DatabaseService(uid: user.uid)
          .updateUserData(user.uid, 'New Member', 0);
      return _userFromFirebaseUser(user);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
