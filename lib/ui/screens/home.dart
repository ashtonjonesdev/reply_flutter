import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:reply_flutter/core/data/model/MessageCard.dart';
import 'package:reply_flutter/core/data/viewmodel/BusinessMessagesViewModel.dart';
import 'package:reply_flutter/core/data/viewmodel/FirstAdditionalMessagesViewModel.dart';
import 'package:reply_flutter/core/data/viewmodel/PersonalMessagesViewModel.dart';
import 'package:reply_flutter/core/data/viewmodel/SecondAdditionalMessagesViewModel.dart';
import 'package:reply_flutter/core/data/viewmodel/SocialMessagesViewModel.dart';
import 'package:reply_flutter/core/services/AuthService.dart';
import 'package:reply_flutter/styles/colors.dart';
import 'package:reply_flutter/ui/screens/about_developer.dart';
import 'package:reply_flutter/ui/screens/add_new_message.dart';
import 'package:reply_flutter/ui/screens/edit_message.dart';
import 'package:reply_flutter/ui/screens/introduction.dart';
import 'package:reply_flutter/ui/screens/reply_later.dart';
import 'package:reply_flutter/ui/screens/welcome.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  static final String routeName = 'home';

  final FirebaseUser firebaseUser;

  Home({this.firebaseUser});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    print('initState');

    _tabController = TabController(length: _tabs.length, vsync: this);

    _tabController.addListener(_onTabChanged);

    _currentTabIndex = 0;
  }

  PersonalMessagesViewModel personalMessagesViewModel =
      PersonalMessagesViewModel();
  SocialMessagesViewModel socialMessagesViewModel = SocialMessagesViewModel();
  BusinessMessagesViewModel businessMessagesViewModel =
      BusinessMessagesViewModel();
  FirstAdditionalMessagesViewModel firstAdditionalMessagesViewModel =
      FirstAdditionalMessagesViewModel();
  SecondAdditionalMessagesViewModel secondAdditionalMessagesViewModel =
      SecondAdditionalMessagesViewModel();

  List<String> appBarTitles = [
    'Personal Messages',
    'Social Messages',
    'Business Messages',
    '+1 Messages',
    '+2 Messages',
  ];

  List<MessageCard> placeholderMessageCards = [
    new MessageCard(title: 'Title', message: 'Message'),
    new MessageCard(title: 'Title', message: 'Message'),
    new MessageCard(title: 'Title', message: 'Message'),
    new MessageCard(title: 'Title', message: 'Message'),
  ];

  Color cardBackgroundColor = kBackgroundColor;

  String appBarTitle = 'Personal Messages';

  TabController _tabController;

  int _currentTabIndex = 0;

  final List<Tab> _tabs = <Tab>[
    Tab(
      icon: Icon(Icons.person),
    ),
    Tab(
      icon: Icon(Icons.group),
    ),
    Tab(
      icon: Icon(Icons.business_center),
    ),
    Tab(
      icon: Icon(Icons.exposure_plus_1),
    ),
    Tab(
      icon: Icon(Icons.exposure_plus_2),
    ),
  ];

  Widget generatePersonalMessagesGridView() {
    return Consumer<PersonalMessagesViewModel>(
      builder: (context, personalMessagesViewModel, child) => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 40, mainAxisSpacing: 40),
          itemCount: personalMessagesViewModel.personalMessages.length,
          padding: EdgeInsets.all(24),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: kPrimaryColorLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(personalMessagesViewModel
                      .personalMessages[index].title),
                  Text(personalMessagesViewModel
                      .personalMessages[index].message)
                ],
              ),
            );
          }),
    );
  }

  Widget generateSocialMessagesGridView() {
    return Consumer<SocialMessagesViewModel>(
      builder: (context, socialMessagesViewModel, child) => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 40, mainAxisSpacing: 40),
          itemCount: socialMessagesViewModel.socialMessages.length,
          padding: EdgeInsets.all(24),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: kPrimaryColorLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(socialMessagesViewModel.socialMessages[index].title),
                  Text(
                      socialMessagesViewModel.socialMessages[index].message)
                ],
              ),
            );
          }),
    );
  }

  Widget generateBusinessMessagesGridView() {
    return Consumer<BusinessMessagesViewModel>(
      builder: (context, businessMessagesViewModel, child) => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 40, mainAxisSpacing: 40),
          itemCount: businessMessagesViewModel.businessMessages.length,
          padding: EdgeInsets.all(24),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: kPrimaryColorLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(businessMessagesViewModel
                      .businessMessages[index].title),
                  Text(businessMessagesViewModel
                      .businessMessages[index].message)
                ],
              ),
            );
          }),
    );
  }

  Widget generateFirstAdditionalMessagesGridView() {
    return Consumer<FirstAdditionalMessagesViewModel>(
      builder: (context, firstAdditionalMessagesViewModel, child) =>
          GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 40, mainAxisSpacing: 40),
              itemCount: firstAdditionalMessagesViewModel
                  .firstAdditionalMessages.length,
              padding: EdgeInsets.all(24),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: kPrimaryColorLight,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(firstAdditionalMessagesViewModel
                          .firstAdditionalMessages[index].title),
                      Text(firstAdditionalMessagesViewModel
                          .firstAdditionalMessages[index].message)
                    ],
                  ),
                );
              }),
    );
  }

  Widget generateSecondAdditionalMessagesGridView() {
    return Consumer<SecondAdditionalMessagesViewModel>(
      builder: (context, secondAdditionalMessagesViewModel, child) =>
          GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 40, mainAxisSpacing: 40),
              itemCount: secondAdditionalMessagesViewModel
                  .secondAdditionalMessages.length,
              padding: EdgeInsets.all(24),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: kPrimaryColorLight,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(secondAdditionalMessagesViewModel
                          .secondAdditionalMessages[index].title),
                      Text(secondAdditionalMessagesViewModel
                          .secondAdditionalMessages[index].message)
                    ],
                  ),
                );
              }),
    );
  }

  @override
  Widget build(BuildContext context) {
    var personalMessagesModel = Provider.of<PersonalMessagesViewModel>(context);

    return Scaffold(
      appBar: AppBar(
          title: Text(appBarTitle),
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'Introduction', 'Tips', 'About Developer', 'Sign Out'}
                    .map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(
                      choice,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList();
              },
            ),
          ],
          bottom: TabBar(
            tabs: _tabs,
            controller: _tabController,
            indicatorColor: kPrimaryColor,
          )),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          generatePersonalMessagesGridView(),
          generateSocialMessagesGridView(),
          generateBusinessMessagesGridView(),
          generateFirstAdditionalMessagesGridView(),
          generateSecondAdditionalMessagesGridView(),
        ],
      ),
      floatingActionButton: SpeedDial(
        backgroundColor: kPrimaryColorLight,
        animatedIcon: AnimatedIcons.menu_arrow,
        children: [
          SpeedDialChild(
            backgroundColor: kPrimaryColorLight,
            onTap: () {
              Share.share("My test message");
              print('Tapped Send');
            },
            child: Icon(Icons.email),
          ),
          SpeedDialChild(
            backgroundColor: kPrimaryColorLight,
            onTap: () {
              print('Tapped Preview');
              _previewMessageDialog();
            },
            child: Icon(Icons.visibility),
          ),
          SpeedDialChild(
            backgroundColor: kPrimaryColorLight,
            onTap: () {
              print('Tapped Add');
//              personalMessagesModel.addPersonalMessage(MessageCard(cardTitle: 'New Message!', cardMessage: 'New Message!'));
              Navigator.pushNamed(context, AddNewMessage.routeName);
            },
            child: Icon(Icons.add),
          ),
          SpeedDialChild(
            backgroundColor: kPrimaryColorLight,
            onTap: () {
              print('Tapped Edit');
              Navigator.pushNamed(context, EditMessage.routeName);
            },
            child: Icon(Icons.edit),
          ),
          SpeedDialChild(
            backgroundColor: kPrimaryColorLight,
            onTap: () {
              print('Tapped Delete');
            },
            child: Icon(Icons.delete),
          ),
          SpeedDialChild(
            backgroundColor: kPrimaryColorLight,
            onTap: () {
              print('Tapped Timer');
              Navigator.pushNamed(context, ReplyLater.routeName);
            },
            child: Icon(Icons.timer),
          ),
        ],
      ),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'Introduction':
        print('Tapped Introduction');
        Navigator.pushNamed(context, Introduction.routeName);
        break;
      case 'Tips':
        print('Tapped Tips');
        _openMediumArticle();
        break;
      case 'About Developer':
        print('Tapped About Developer');
        Navigator.pushNamed(context, AboutDeveloper.routeName);
        break;
      case 'Sign Out':
        print('Tapped Sign Out');
        _signOut();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => Welcome()),
            (Route<dynamic> route) => false);
        break;
    }
  }

  void _onTabChanged() {
    /// Only manually set the index if it is changing from a swipe, not a tab selection (indexIsChanging is only true when selecting a tab, and tab index is automatically changed) to avoid setting the index twice when a tab is selected
    if (!_tabController.indexIsChanging)
      setState(() {
        print('Changing to Tab: ${_tabController.index}');
        _currentTabIndex = _tabController.index;
        appBarTitle = appBarTitles[_tabController.index];
      });
  }

  _openMediumArticle() async {
    const url = 'https://medium.com/@TJgrapes/introducing-reply-3d0b57ec6744';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _previewMessageDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: Theme.of(context).dialogTheme.shape,
          title: Text(
            'Your Message:',
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'This is a preview of your message. hehe It is very long indeed lol',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Got it',
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _signOut() async {
    await Provider.of<AuthService>(context, listen: false).signout();
    if (await Provider.of<AuthService>(context, listen: false).getUser() == null
    ) {
      print('Successfully signed out user');
    }
    else {
      print('Failed to sign out user!');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
