import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:reply_flutter/core/data/repository/firebase_repository.dart';
import 'package:reply_flutter/core/services/AuthService.dart';
import 'package:reply_flutter/styles/colors.dart';
import 'package:reply_flutter/ui/screens/home.dart';
import 'package:reply_flutter/ui/screens/register.dart';
import 'package:reply_flutter/ui/screens/signin.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:url_launcher/url_launcher.dart';

class Welcome extends StatelessWidget {

  static final String routeName = 'welcome';

  final bool isAndroid = Platform.isAndroid;

  final FirebaseRepository firebaseRepository = FirebaseRepository();

  @override
  Widget build(BuildContext context) {

    return isAndroid ? Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'Reply',
            style: Theme.of(context)
                .textTheme
                .headline3
                .copyWith(color: kPrimaryColor),
          ),
          Image.asset('images/icons8_comments_48.png'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                child: Material(
                  color: kPrimaryColorLight,
                  borderRadius: BorderRadius.circular(30.0),
                  elevation: 5.0,
                  child: MaterialButton(
                    minWidth: 400,
                    elevation: 16,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, SignIn.routeName);
                    },
                    child: Text(
                      'Sign in',
                      style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                child: Material(
                  color: kPrimaryColor100,
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    minWidth: 400,
                    child: Text(
                      'Register',
                      style: Theme.of(context).textTheme.button,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, Register.routeName);
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.0), // <= NEW
              Text(
                'OR',
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Material(
                  child: MaterialButton(
                    color: Colors.grey.shade100,
                    minWidth: 400,
                    splashColor: Colors.grey,
                    onPressed: () async {
                      await Provider.of<AuthService>(context, listen: false).signInWithGoogle()
                          .then((FirebaseUser firebaseUser) async {
                            // If it is a new user (signing in for the first time), create a user in the database
                          if(firebaseUser.metadata.creationTime == firebaseUser.metadata.lastSignInTime) {
                            firebaseRepository.createUserInDatabaseWithGoogleProvider(firebaseUser);
                          }
                      }).whenComplete(() =>
                          Navigator.popAndPushNamed(context, Home.routeName))
                          .catchError((e) => print(e));
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    highlightElevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                              image: AssetImage("images/google_logo.png"),
                              height: 30.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Sign in with Google',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Created by',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Image.asset(
                  'images/associate_android_developer_badge_small.png',
                  width: 96,
                  height: 96,
                ),
                GestureDetector(
                  onTap: _openPersonalWebsite,
                  child: Text('Ashton Jones',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.blue, decoration: TextDecoration.underline)),
                ),
              ],
            ),
          ),
        ],
      ),
    ) : Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'Reply',
            style: Theme.of(context)
                .textTheme
                .headline3
                .copyWith(color: kPrimaryColor),
          ),
          Image.asset('images/icons8_comments_48.png'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                child: Material(
                  color: kPrimaryColorLight,
                  borderRadius: BorderRadius.circular(30.0),
                  elevation: 5.0,
                  child: MaterialButton(
                    minWidth: 400,
                    elevation: 16,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, SignIn.routeName);
                    },
                    child: Text(
                      'Sign in',
                      style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                child: Material(
                  color: kPrimaryColor100,
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    minWidth: 400,
                    child: Text(
                      'Register',
                      style: Theme.of(context).textTheme.button,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, Register.routeName);
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.0), // <= NEW
              Text(
                'OR',
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SignInWithAppleButton(
                  // TODO: Implement SigninwithApple

                onPressed: () async {
                    final credential = await SignInWithApple.getAppleIDCredential(
                      scopes: [
                        AppleIDAuthorizationScopes.email,
                        AppleIDAuthorizationScopes.fullName,
                      ],
                    );
                    print(credential);
                    // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
                    // after they have been validated with Apple (see `Integration` section for more information on how to do this)
                  },
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Created by',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Image.asset(
                  'images/associate_android_developer_badge_small.png',
                  width: 96,
                  height: 96,
                ),
                GestureDetector(
                  onTap: _openPersonalWebsite,
                  child: Text('Ashton Jones',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.blue, decoration: TextDecoration.underline)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _openPersonalWebsite() async {
    const url = 'https://ashtonjones.dev/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
