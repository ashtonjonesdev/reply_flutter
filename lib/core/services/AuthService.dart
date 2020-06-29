import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///
  /// return the Future with firebase user object FirebaseUser if one exists
  ///
  Future<FirebaseUser> getUser() async {
    try {
      final user = await _auth.currentUser();
      if(user != null) {
        print('User signed in: ${user.email}');
      }
      else {
        print('No user signed in');
      }
      notifyListeners();
      return user;
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  // wrapping the firebase calls
  Future signout() async {
    var result = await FirebaseAuth.instance.signOut();
    print('Signing out user');
    notifyListeners();
    return result;
  }

  // wrapping the firebase calls
  Future<FirebaseUser> createUserWithEmailAndPassword(
      {String firstName,
        String lastName,
        String email,
        String password}) async {
    var authResult = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    // FirebaseUser
    var newUser = authResult.user;

    /// Add the first and last name to the FirebaseUser
    UserUpdateInfo info = UserUpdateInfo();
    info.displayName = '$firstName $lastName';
    newUser.updateProfile(info);
    // Return FirebaseUser with updated information (setting the display name using their first and last name)
    return newUser;
  }

  ///
  /// wrapping the firebase call to signInWithEmailAndPassword
  /// `email` String
  /// `password` String
  ///
  Future<FirebaseUser> signInUserWithEmailAndPassword({String email, String password}) async {
    try {
      var result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // since something changed, let's notify the listeners...
      notifyListeners();
      return result.user;
    }  catch (e) {
      throw new AuthException(e.code, e.message);
    }
  }

//  Future<FirebaseUser> _handleSignIn() async {
//    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//    final GoogleSignInAuthentication googleAuth =
//    await googleUser.authentication;
//
//    final AuthCredential credential = GoogleAuthProvider.getCredential(
//      accessToken: googleAuth.accessToken,
//      idToken: googleAuth.idToken,
//    );
//
//    final FirebaseUser user =
//        (await _auth.signInWithCredential(credential)).user;
//    print('Successfully signed in user with Google Provider');
//    print('Name: ' + user.displayName + 'uID: ' + user.uid);
//    return user;
//  }
}