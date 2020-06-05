import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:reply_flutter/styles/colors.dart';
import 'package:reply_flutter/styles/theme.dart';
import 'package:reply_flutter/views/about_developer.dart';
import 'package:reply_flutter/views/add_new_message.dart';
import 'package:reply_flutter/views/edit_message.dart';
import 'package:reply_flutter/views/home.dart';
import 'package:reply_flutter/views/introduction.dart';
import 'package:reply_flutter/views/sign_in.dart';
import 'package:share/share.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reply',
      theme: AppTheme.appThemeData,
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/introduction': (context) => Introduction(),
        '/aboutdeveloper': (context) => AboutDeveloper(),
        '/signin': (context) => SignIn(),
        '/addnewmessage' : (context) => AddNewMessage(),
        '/editmessage' : (context) => EditMessage(),
      },
    );
  }
}
