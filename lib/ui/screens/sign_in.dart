import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reply_flutter/styles/colors.dart';

class SignIn extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn(s);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          RaisedButton(
            elevation: 16,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            onPressed: () {
              _handleSignIn()
                  .then((FirebaseUser firebaseUser) => print(
                      '${firebaseUser.displayName} signed in with Google'))
                  .catchError((e) => print(e));
              Navigator.popAndPushNamed(context, '/');
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    'images/google_logo.png',
                    height: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Sign in with Google',
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  'Created by',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Image.asset(
                'images/associate_android_developer_badge_small.png',
                width: 96,
                height: 96,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text('Ashton Jones',
                    style: Theme.of(context).textTheme.bodyText1),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<FirebaseUser> _handleSignIn() async {
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
    print('Name: ' + user.displayName + 'uID: ' + user.uid);
    return user;
  }


}
