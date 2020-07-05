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
import 'package:reply_flutter/core/utils/MessageCardArguments.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKeyHome = GlobalKey<ScaffoldState>();

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

  Color cardBackgroundColor = kBackgroundColor;

  int selectedItemIndex = -1;

  bool isItemSelected = false;

  bool selectedNewItem = true;

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

  MessageCard selectedMessage;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _tabs.length, vsync: this);

    _tabController.addListener(_onTabChanged);

    _currentTabIndex = 0;

  }


  Widget generatePersonalMessagesGridView() {
    /// Had to add load method here as well to reload the data so an added message shows up immediately
    ///
    Provider.of<PersonalMessagesViewModel>(context, listen: false)
        .loadPersonalMessagesList(widget.firebaseUser);

    return Consumer<PersonalMessagesViewModel>(
      builder: (context, personalMessagesViewModel, child) => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 35, mainAxisSpacing: 40),
          itemCount: personalMessagesViewModel.personalMessagesList.length,
          padding: EdgeInsets.all(24),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => selectGridViewItem(index, personalMessagesViewModel),
              child: Card(
                color: index != selectedItemIndex
                    ? kSurfaceColor
                    : kPrimaryColor200,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '${personalMessagesViewModel.personalMessagesList[index].title} | ${personalMessagesViewModel.personalMessagesList[index].message}',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  /// This works for single selection (Unable to deselect the currently selected one by clicking on it, but that's ok because the previous one is deselected when a new one is selected
  void selectGridViewItem(
      int index, PersonalMessagesViewModel personalMessagesViewModel) {
    print('Tapped item: $index');
    setState(() {
      selectedItemIndex = index;
      // Set the selected message
      selectedMessage = personalMessagesViewModel.personalMessagesList[index];
      print('Selected message: $selectedMessage');
      // Show a snackbar of the selected message
      _scaffoldKeyHome.currentState.showSnackBar(SnackBar(
        content: Text(
          selectedMessage.message,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.white),
        ),
        backgroundColor: kPrimaryColor700,
        elevation: 8,
        duration: Duration(milliseconds: 2000),
      ));
    });
    print('Selected Item: $index');
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
                  Text(socialMessagesViewModel.socialMessages[index].message)
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
                  Text(businessMessagesViewModel.businessMessages[index].title),
                  Text(
                      businessMessagesViewModel.businessMessages[index].message)
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
    return Scaffold(
      key: _scaffoldKeyHome,
      backgroundColor: kBackgroundColor,
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
            indicatorColor: kSurfaceColor,
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
              print('Tapped Send');
              if (selectedMessage == null) {
                _scaffoldKeyHome.currentState.showSnackBar(SnackBar(
                  content: Text(
                    'No message selected',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.white),
                  ),
                  backgroundColor: kPrimaryColor700,
                  elevation: 8,
                  duration: Duration(milliseconds: 5000),
                ));
                return;
              }
              Share.share(selectedMessage.message);
            },
            child: Icon(Icons.email),
          ),
          SpeedDialChild(
            backgroundColor: kPrimaryColorLight,
            onTap: () {
              print('Tapped Preview');
              if (selectedMessage == null) {
                _scaffoldKeyHome.currentState.showSnackBar(SnackBar(
                  content: Text(
                    'No message selected',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.white),
                  ),
                  backgroundColor: kPrimaryColor700,
                  elevation: 8,
                  duration: Duration(milliseconds: 5000),
                ));
                return;
              }
              _previewMessageDialog(selectedMessage.message);
            },
            child: Icon(Icons.visibility),
          ),
          SpeedDialChild(
            backgroundColor: kPrimaryColorLight,
            onTap: () {
              print('Tapped Add');
              Navigator.pushNamed(context, AddNewMessage.routeName);
            },
            child: Icon(Icons.add),
          ),
          SpeedDialChild(
            backgroundColor: kPrimaryColorLight,
            onTap: () async {
              print('Tapped Edit');
              if (selectedMessage == null) {
                _scaffoldKeyHome.currentState.showSnackBar(SnackBar(
                  content: Text(
                    'No message selected',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.white),
                  ),
                  backgroundColor: kPrimaryColor700,
                  elevation: 8,
                  duration: Duration(milliseconds: 5000),
                ));
                return;
              }

              // TODO: Need to figure out how to reload data to show new edit card immediately after editing
              Navigator.pushNamed(context, EditMessage.routeName,
                      arguments: MessageCardArguments(
                          title: selectedMessage.title,
                          message: selectedMessage.message))
                  .whenComplete(() {
                reloadData();
              });
            },
            child: Icon(Icons.edit),
          ),
          SpeedDialChild(
            backgroundColor: kPrimaryColorLight,
            onTap: () {
              print('Tapped Delete');
              if (selectedMessage == null) {
                _scaffoldKeyHome.currentState.showSnackBar(SnackBar(
                  content: Text(
                    'No message selected',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.white),
                  ),
                  backgroundColor: kPrimaryColor700,
                  elevation: 8,
                  duration: Duration(milliseconds: 5000),
                ));
                return;
              }
              deletePersonalMessage(widget.firebaseUser, selectedMessage);
              _scaffoldKeyHome.currentState.showSnackBar(SnackBar(
                content: Text(
                  'Message Deleted!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.white),
                ),
                backgroundColor: kPrimaryColor700,
                elevation: 8,
                duration: Duration(milliseconds: 2000),
              ));
            },
            child: Icon(Icons.delete),
          ),
          SpeedDialChild(
            backgroundColor: kPrimaryColorLight,
            onTap: () {
              print('Tapped Reply Later');
              if (selectedMessage == null) {
                _scaffoldKeyHome.currentState.showSnackBar(SnackBar(
                  content: Text(
                    'No message selected',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.white),
                  ),
                  backgroundColor: kPrimaryColor700,
                  elevation: 8,
                  duration: Duration(milliseconds: 5000),
                ));
                return;
              }
              Navigator.pushNamed(context, ReplyLater.routeName,
                  arguments: MessageCardArguments(
                      title: selectedMessage.title,
                      message: selectedMessage.message));
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

  Future<void> _previewMessageDialog(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            'Your Message:',
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  selectedMessage.message,
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Got it',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: kPrimaryColorDark),
              ),
              onPressed: () {
                setState(() {
                  // Set selectedItemIndex back to -1 to signify a card isn't selected (change the color back to unselected)
                  selectedItemIndex = -1;
                  // Set selectedMessage back to null after dialog is done showing
                  selectedMessage = null;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void deletePersonalMessage(
      FirebaseUser firebaseUser, MessageCard messageCardToDelete) async {
    Provider.of<PersonalMessagesViewModel>(context, listen: false)
        .deletePersonalMessage(firebaseUser, messageCardToDelete);

    // Had to add it here to have the message removed from UI immediately upon deletion
    Provider.of<PersonalMessagesViewModel>(context, listen: false)
        .loadPersonalMessagesList(widget.firebaseUser);

    setState(() {
      // Set selectedItemIndex back to -1 to signify a card isn't selected (change the color back to unselected)
      selectedItemIndex = -1;
      // Set selectedMessage back to null after message has been deleted
      selectedMessage = null;
    });
  }

  void reloadData() {
    // Had to add it here to have edited message show up in UI immediately upon editing
    Provider.of<PersonalMessagesViewModel>(context, listen: false)
        .loadPersonalMessagesList(widget.firebaseUser);
    setState(() {
      // Set selectedItemIndex back to -1 to signify a card isn't selected (change the color back to unselected)
      selectedItemIndex = -1;
      // Set selectedMessage back to null after dialog is done showing
      selectedMessage = null;
    });
  }

  void _signOut() async {
    await Provider.of<AuthService>(context, listen: false).signout();
    if (await Provider.of<AuthService>(context, listen: false).getUser() ==
        null) {
      print('Successfully signed out user');
    } else {
      print('Failed to sign out user!');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
    super.dispose();
  }


}
