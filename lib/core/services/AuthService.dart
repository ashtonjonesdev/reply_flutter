import 'dart:async';
import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:apple_sign_in/scope.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reply_flutter/core/data/repository/firebase_repository.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final FirebaseRepository firebaseRepository = FirebaseRepository();

  Future<FirebaseUser> getUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        print('User signed in: ${user.email}');
      } else {
        print('No user signed in');
      }
      notifyListeners();
      return user;
    } catch (e) {
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

    notifyListeners();

    // Return FirebaseUser with updated information (setting the display name using their first and last name)
    return updatedUser;
  }

  Future<FirebaseUser> signInUserWithEmailAndPassword(
      {String email, String password}) async {
    try {
      var result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // since something changed, let's notify the listeners...
      notifyListeners();
      return result.user;
    } catch (e) {
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

    notifyListeners();

    // Return the current user, which should now be signed in with Google
    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();

    return firebaseUser;
  }

  Future<FirebaseUser> signInWithApple() async {
    // Sign In with Apple is only supported on iOS 13+
    if (await AppleSignIn.isAvailable()) {
      try {
        final AuthorizationResult result = await AppleSignIn.performRequests([
          AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
        ]);

        switch (result.status) {
          case AuthorizationStatus.authorized:
            try {
              print('Apple credentials authorized');
              final AppleIdCredential appleIdCredential = result.credential;

              // Store Apple Credetial uID
              // Store user ID
              await FlutterSecureStorage()
                  .write(key: "appleCredentialUid", value: result.credential.user);

              // Create Apple AuthCredential to sign into Firebase using Apple credentials
              OAuthProvider oAuthProvider =
                  new OAuthProvider(providerId: 'apple.com');
              final AuthCredential credential = oAuthProvider.getCredential(
                idToken: String.fromCharCodes(appleIdCredential.identityToken),
                accessToken:
                    String.fromCharCodes(appleIdCredential.authorizationCode),
              );

              // Sign into Firebase using Apple credentials

              final FirebaseAuth _auth = FirebaseAuth.instance;
              final AuthResult authResult =
                  await _auth.signInWithCredential(credential);
              final FirebaseUser firebaseUser = authResult.user;
              print(
                  '${firebaseUser.uid} successfully signed in user with Apple Provider');

              print('FBUser creation time: ${firebaseUser.metadata.creationTime} FBUser lastSignInTime: ${firebaseUser.metadata.lastSignInTime}');


              // Check if it is a new user

              print(firebaseUser.metadata.creationTime.difference(firebaseUser.metadata.lastSignInTime).inSeconds.abs());
              print(Duration(seconds: 1).inSeconds);
              if(firebaseUser.metadata.creationTime.difference(firebaseUser.metadata.lastSignInTime).inSeconds.abs() < Duration(seconds: 1).inSeconds) {

                // Update the UserInfo with Apple profile information on the first sign in
                UserUpdateInfo updateUserInfo = UserUpdateInfo();
                updateUserInfo.displayName =
                '${appleIdCredential.fullName.givenName} ${appleIdCredential.fullName.familyName}';
                await firebaseUser
                    .updateProfile(updateUserInfo)
                    .catchError((error) => print(error));

                // Refresh data
                await firebaseUser.reload();

                FirebaseUser updatedUser = await FirebaseAuth.instance.currentUser();

                print('Updated UserProfile info | Name: ${updatedUser.displayName}');

                print('Creating new user in Database');

                firebaseRepository.createUserInDatabaseWithAppleProvider(updatedUser);

              }

              FirebaseUser updatedUser = await FirebaseAuth.instance.currentUser();


              notifyListeners();

              // Return the updated user
              return updatedUser;


            } catch (e) {
              print('error');
            }
            break;
          case AuthorizationStatus.error:
            print("Sign in failed: ${result.error.localizedDescription}");
            break;

          case AuthorizationStatus.cancelled:
            print('User cancelled');
            break;
        }
      } catch (error) {
        print('error with apple sign in');
      }
    } else {
      print('Apple SignIn is not available for your device');


    }

    // If there is an error, return null for FirebaseUser
    return null;
  }
}
