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
              onTap: () => selectPersonalMessagesGridViewItem(index, personalMessagesViewModel),
              child: Card(
                color: index != selectedItemIndex
                    ? kSurfaceColor
                    : kPrimaryColor200,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      '${personalMessagesViewModel.personalMessagesList[index].title}',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  /// This works for single selection (Unable to deselect the currently selected one by clicking on it, but that's ok because the previous one is deselected when a new one is selected
  void selectPersonalMessagesGridViewItem(
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
    /// Had to add load method here as well to reload the data so an added message shows up immediately
    ///
    Provider.of<SocialMessagesViewModel>(context, listen: false)
        .loadSocialMessagesList(widget.firebaseUser);

    return Consumer<SocialMessagesViewModel>(
      builder: (context, socialMessagesViewModel, child) => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 35, mainAxisSpacing: 40),
          itemCount: socialMessagesViewModel.socialMessagesList.length,
          padding: EdgeInsets.all(24),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => selectSocialMessagesGridViewItem(index, socialMessagesViewModel),
              child: Card(
                color: index != selectedItemIndex
                    ? kSurfaceColor
                    : kPrimaryColor200,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      '${socialMessagesViewModel.socialMessagesList[index].title}',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  /// This works for single selection (Unable to deselect the currently selected one by clicking on it, but that's ok because the previous one is deselected when a new one is selected
  void selectSocialMessagesGridViewItem(
      int index, SocialMessagesViewModel socialMessagesViewModel) {
    print('Tapped item: $index');
    setState(() {
      selectedItemIndex = index;
      // Set the selected message
      selectedMessage = socialMessagesViewModel.socialMessagesList[index];
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

  Widget generateBusinessMessagesGridView() {
    /// Had to add load method here as well to reload the data so an added message shows up immediately
    ///
    Provider.of<BusinessMessagesViewModel>(context, listen: false)
        .loadBusinessMessagesList(widget.firebaseUser);

    return Consumer<BusinessMessagesViewModel>(
      builder: (context, businessMessagesViewModel, child) => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 35, mainAxisSpacing: 40),
          itemCount: businessMessagesViewModel.businessMessagesList.length,
          padding: EdgeInsets.all(24),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => selectBusinessMessagesGridViewItem(index, businessMessagesViewModel),
              child: Card(
                color: index != selectedItemIndex
                    ? kSurfaceColor
                    : kPrimaryColor200,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      '${businessMessagesViewModel.businessMessagesList[index].title}',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  /// This works for single selection (Unable to deselect the currently selected one by clicking on it, but that's ok because the previous one is deselected when a new one is selected
  void selectBusinessMessagesGridViewItem(
      int index, BusinessMessagesViewModel businessMessagesViewModel) {
    print('Tapped item: $index');
    setState(() {
      selectedItemIndex = index;
      // Set the selected message
      selectedMessage = businessMessagesViewModel.businessMessagesList[index];
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

  Widget generateFirstAdditionalMessagesGridView() {
    /// Had to add load method here as well to reload the data so an added message shows up immediately
    ///
    Provider.of<FirstAdditionalMessagesViewModel>(context, listen: false)
        .loadFirstAdditionalMessagesList(widget.firebaseUser);

    return Consumer<FirstAdditionalMessagesViewModel>(
      builder: (context, firstAdditionalMessagesViewModel, child) => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 35, mainAxisSpacing: 40),
          itemCount: firstAdditionalMessagesViewModel.firstAdditionalMessagesList.length,
          padding: EdgeInsets.all(24),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => selectFirstAdditionalMessagesGridViewItem(index, firstAdditionalMessagesViewModel),
              child: Card(
                color: index != selectedItemIndex
                    ? kSurfaceColor
                    : kPrimaryColor200,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      '${firstAdditionalMessagesViewModel.firstAdditionalMessagesList[index].title}',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  /// This works for single selection (Unable to deselect the currently selected one by clicking on it, but that's ok because the previous one is deselected when a new one is selected
  void selectFirstAdditionalMessagesGridViewItem(
      int index, FirstAdditionalMessagesViewModel firstAdditionalMessagesViewModel) {
    print('Tapped item: $index');
    setState(() {
      selectedItemIndex = index;
      // Set the selected message
      selectedMessage = firstAdditionalMessagesViewModel.firstAdditionalMessagesList[index];
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

  Widget generateSecondAdditionalMessagesGridView() {
    /// Had to add load method here as well to reload the data so an added message shows up immediately
    ///
    Provider.of<SecondAdditionalMessagesViewModel>(context, listen: false)
        .loadSecondAdditionalMessagesList(widget.firebaseUser);

    return Consumer<SecondAdditionalMessagesViewModel>(
      builder: (context, secondAdditionalMessagesViewModel, child) => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 35, mainAxisSpacing: 40),
          itemCount: secondAdditionalMessagesViewModel.secondAdditionalMessagesList.length,
          padding: EdgeInsets.all(24),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => selectSecondAdditionalMessagesGridViewItem(index, secondAdditionalMessagesViewModel),
              child: Card(
                color: index != selectedItemIndex
                    ? kSurfaceColor
                    : kPrimaryColor200,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      '${secondAdditionalMessagesViewModel.secondAdditionalMessagesList[index].title}',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  /// This works for single selection (Unable to deselect the currently selected one by clicking on it, but that's ok because the previous one is deselected when a new one is selected
  void selectSecondAdditionalMessagesGridViewItem(
      int index, SecondAdditionalMessagesViewModel secondAdditionalMessagesViewModel) {
    print('Tapped item: $index');
    setState(() {
      selectedItemIndex = index;
      // Set the selected message
      selectedMessage = secondAdditionalMessagesViewModel.secondAdditionalMessagesList[index];
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

              MessageCategory selectedMessageCategory;

              // Get the MessageCategory of the Message to edit
              switch(_currentTabIndex) {
                case 0:
                  selectedMessageCategory = MessageCategory.Personal;
                  break;
                case 1:
                  selectedMessageCategory = MessageCategory.Social;
                  break;
                case 2:
                  selectedMessageCategory = MessageCategory.Business;
                  break;
                case 3:
                  selectedMessageCategory = MessageCategory.FirstAdditional;
                  break;
                case 4:
                  selectedMessageCategory = MessageCategory.SecondAdditional;
                  break;
                default:
                  print('Error in retrieving selected message MessageCategory');
                  break;
              }
              Navigator.pushNamed(context, EditMessage.routeName,
                      arguments: MessageCardArguments(
                          title: selectedMessage.title,
                          message: selectedMessage.message,
                          messageCategory: selectedMessageCategory))
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
              switch(_currentTabIndex) {
                case 0:
                  deletePersonalMessage(widget.firebaseUser, selectedMessage);
                  break;
                case 1:
                  deleteSocialMessage(widget.firebaseUser, selectedMessage);
                  break;
                case 2:
                  deleteBusinessMessage(widget.firebaseUser, selectedMessage);
                  break;
                case 3:
                  deleteFirstAdditionalMessage(widget.firebaseUser, selectedMessage);
                  break;
                case 4:
                  deleteSecondAdditionalMessage(widget.firebaseUser, selectedMessage);
                  break;
                default:
                  print('Error in deleting message');
                  break;


              }
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

  void deleteSocialMessage(
      FirebaseUser firebaseUser, MessageCard messageCardToDelete) async {
    Provider.of<SocialMessagesViewModel>(context, listen: false)
        .deleteSocialMessage(firebaseUser, messageCardToDelete);

    // Had to add it here to have the message removed from UI immediately upon deletion
    Provider.of<SocialMessagesViewModel>(context, listen: false)
        .loadSocialMessagesList(widget.firebaseUser);

    setState(() {
      // Set selectedItemIndex back to -1 to signify a card isn't selected (change the color back to unselected)
      selectedItemIndex = -1;
      // Set selectedMessage back to null after message has been deleted
      selectedMessage = null;
    });
  }

  void deleteBusinessMessage(
      FirebaseUser firebaseUser, MessageCard messageCardToDelete) async {
    Provider.of<BusinessMessagesViewModel>(context, listen: false)
        .deleteBusinessMessage(firebaseUser, messageCardToDelete);

    // Had to add it here to have the message removed from UI immediately upon deletion
    Provider.of<BusinessMessagesViewModel>(context, listen: false)
        .loadBusinessMessagesList(widget.firebaseUser);

    setState(() {
      // Set selectedItemIndex back to -1 to signify a card isn't selected (change the color back to unselected)
      selectedItemIndex = -1;
      // Set selectedMessage back to null after message has been deleted
      selectedMessage = null;
    });
  }

  void deleteFirstAdditionalMessage(
      FirebaseUser firebaseUser, MessageCard messageCardToDelete) async {
    Provider.of<FirstAdditionalMessagesViewModel>(context, listen: false)
        .deleteFirstAdditionalMessage(firebaseUser, messageCardToDelete);

    // Had to add it here to have the message removed from UI immediately upon deletion
    Provider.of<FirstAdditionalMessagesViewModel>(context, listen: false)
        .loadFirstAdditionalMessagesList(widget.firebaseUser);

    setState(() {
      // Set selectedItemIndex back to -1 to signify a card isn't selected (change the color back to unselected)
      selectedItemIndex = -1;
      // Set selectedMessage back to null after message has been deleted
      selectedMessage = null;
    });
  }

  void deleteSecondAdditionalMessage(
      FirebaseUser firebaseUser, MessageCard messageCardToDelete) async {
    Provider.of<SecondAdditionalMessagesViewModel>(context, listen: false)
        .deleteSecondAdditionalMessage(firebaseUser, messageCardToDelete);

    // Had to add it here to have the message removed from UI immediately upon deletion
    Provider.of<SecondAdditionalMessagesViewModel>(context, listen: false)
        .loadSecondAdditionalMessagesList(widget.firebaseUser);

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
