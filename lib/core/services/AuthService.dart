import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reply_flutter/core/data/repository/firebase_repository.dart';

class AuthService with ChangeNotifier {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();


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

  Future signout() async {
    var result = await FirebaseAuth.instance.signOut();
    print('Signing out user');
    notifyListeners();
    return result;
  }

  Future<FirebaseUser> registerUserWithEmailAndPassword(
      {String firstName,
        String lastName,
        String email,
        String password}) async {
    var authResult = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    // FirebaseUser
    var newUser = authResult.user;

    /// Add the first and last name to the FirebaseUser

    String newDisplayName = '$firstName $lastName';
    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName = newDisplayName;

    await newUser.updateProfile(updateInfo).catchError((error) => print(error));

    // Refresh data
    await newUser.reload();

    // Need to make this call to get the updated display name; or else display name will be null
    FirebaseUser updatedUser = await FirebaseAuth.instance.currentUser();

    print('new display name: ${updatedUser.displayName}');

    // Return FirebaseUser with updated information (setting the display name using their first and last name)
    return updatedUser;
  }


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

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    print('Successfully signed in user with Google Provider');
    print('Name: ${user.displayName} | uID: ${user.uid}');

    return user;
  }
}