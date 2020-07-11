import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:reply_flutter/core/data/viewmodel/BusinessMessagesViewModel.dart';
import 'package:reply_flutter/core/data/viewmodel/FirstAdditionalMessagesViewModel.dart';
import 'package:reply_flutter/core/data/viewmodel/PersonalMessagesViewModel.dart';
import 'package:reply_flutter/core/data/viewmodel/SecondAdditionalMessagesViewModel.dart';
import 'package:reply_flutter/core/data/viewmodel/SocialMessagesViewModel.dart';
import 'package:reply_flutter/core/services/AuthService.dart';
import 'package:reply_flutter/styles/colors.dart';
import 'package:reply_flutter/styles/theme.dart';
import 'package:reply_flutter/ui/screens/about_developer.dart';
import 'package:reply_flutter/ui/screens/add_new_message.dart';
import 'package:reply_flutter/ui/screens/edit_message.dart';
import 'package:reply_flutter/ui/screens/home.dart';
import 'package:reply_flutter/ui/screens/introduction.dart';
import 'package:reply_flutter/ui/screens/register.dart';
import 'package:reply_flutter/ui/screens/reply_later.dart';
import 'package:reply_flutter/ui/screens/signin.dart';
import 'package:reply_flutter/ui/screens/welcome.dart';
import 'package:reply_flutter/ui/screens/welcome.dart';


void main() async {
  runApp(
    ChangeNotifierProvider<AuthService>(
      create: (context) => AuthService(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

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
        debugShowCheckedModeBanner: false,
        title: 'Reply',
        theme: AppTheme.appThemeData,
        home: FutureBuilder(
            future: Provider.of<AuthService>(context, listen: false).getUser(),
            builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.error != null) {
                  print("error");
                  return Text(snapshot.error.toString());
                }
                return snapshot.hasData ? Home(firebaseUser: snapshot.data) : Welcome();
              } else {
                return LoadingCircle();
              }
            }),
        routes: {
          Home.routeName: (context) => Home(),
          Introduction.routeName: (context) => Introduction(),
          AboutDeveloper.routeName: (context) => AboutDeveloper(),
          SignIn.routeName: (context) => SignIn(),
          Register.routeName: (context) => Register(),
          AddNewMessage.routeName: (context) => AddNewMessage(),
          EditMessage.routeName: (context) => EditMessage(),
          ReplyLater.routeName: (context) => ReplyLater(),
          'welcome': (context) => Welcome(),
        },
      ),
    );
  }
}

class LoadingCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CircularProgressIndicator(
          backgroundColor: kPrimaryColorLight,
        ),
        alignment: Alignment(0.0, 0.0),
      ),
    );
  }
}
