import 'package:compound/app/locator.dart';
import 'package:compound/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:compound/services/firestore_service.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = locator<FirestoreService>();

  User _currentUser;
  User get currentUser => _currentUser;

  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _populateCurrentUser(authResult.user);
      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future signUpWithEmail({
    @required User user,
    @required String password,
  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );

      // create a new user profile on firestore
      _currentUser = user;

      await _firestoreService.createUser(_currentUser);

      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future<bool> isUserLoggedIn() async {
    var user = await _firebaseAuth.currentUser();
    await _populateCurrentUser(user);
    return user != null;
  }

  Future _populateCurrentUser(FirebaseUser user) async {
    if (user != null) {
      print(user.toString());

      try {
        _currentUser = await _firestoreService.getUser(user.uid);
      } catch (e) {
        await signOut();
      }
    }
  }
}
