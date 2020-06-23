
import 'package:flutter/material.dart';
import 'package:reply_flutter/styles/colors.dart';

class SignIn extends StatelessWidget {
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
          Text('Reply', style: Theme.of(context).textTheme.headline3.copyWith(color: kPrimaryColor),),
          Image.asset('images/icons8_comments_48.png'),
          RaisedButton(
            elevation: 16,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            onPressed: () {Navigator.of(context).pushNamed('/');},
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset('images/google_logo.png', height: 35,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text('Sign in with Google', style: Theme.of(context).textTheme.button,),
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
                child: Text('Created by', style: Theme.of(context).textTheme.bodyText1,),
              ),
              Image.asset('images/associate_android_developer_badge_small.png', width: 96, height: 96,),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text('Ashton Jones' , style: Theme.of(context).textTheme.bodyText1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
