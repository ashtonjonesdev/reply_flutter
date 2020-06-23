import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reply_flutter/core/data/viewmodel/BusinessMessagesViewModel.dart';
import 'package:reply_flutter/core/data/viewmodel/FirstAdditionalMessagesViewModel.dart';
import 'package:reply_flutter/core/data/viewmodel/PersonalMessagesViewModel.dart';
import 'package:reply_flutter/core/data/viewmodel/SecondAdditionalMessagesViewModel.dart';
import 'package:reply_flutter/core/data/viewmodel/SocialMessagesViewModel.dart';
import 'package:reply_flutter/styles/theme.dart';
import 'package:reply_flutter/ui/screens/about_developer.dart';
import 'package:reply_flutter/ui/screens/add_new_message.dart';
import 'package:reply_flutter/ui/screens/edit_message.dart';
import 'package:reply_flutter/ui/screens/home.dart';
import 'package:reply_flutter/ui/screens/introduction.dart';
import 'package:reply_flutter/ui/screens/reply_later.dart';
import 'package:reply_flutter/ui/screens/sign_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PersonalMessagesViewModel>(
          create: (context) => PersonalMessagesViewModel(),
        ),
        ChangeNotifierProvider<SocialMessagesViewModel>(
          create: (context) => SocialMessagesViewModel(),
        ),
        ChangeNotifierProvider<BusinessMessagesViewModel>(
          create: (context) => BusinessMessagesViewModel(),
        ),
        ChangeNotifierProvider<FirstAdditionalMessagesViewModel>(
          create: (context) => FirstAdditionalMessagesViewModel(),
        ),
        ChangeNotifierProvider<SecondAdditionalMessagesViewModel>(
          create: (context) => SecondAdditionalMessagesViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Reply',
        theme: AppTheme.appThemeData,
        initialRoute: '/',
        routes: {
          '/': (context) => Home(),
          '/introduction': (context) => Introduction(),
          '/aboutdeveloper': (context) => AboutDeveloper(),
          '/signin': (context) => SignIn(),
          '/addnewmessage': (context) => AddNewMessage(),
          '/editmessage': (context) => EditMessage(),
          '/replylater': (context) => ReplyLater(),
        },
      ),
    );
  }

}

