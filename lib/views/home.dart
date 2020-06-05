import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../styles/colors.dart';
import 'introduction.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

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

  List<String> appBarTitles = [
    'Personal Messages',
    'Social Messages',
    'Business Messages',
    '+1 Messages',
    '+2 Messages',
  ];

  int _currentTabIndex;

  String appBarTitle = 'Personal Messages';

  TabController _tabController;

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

  @override
  Widget build(BuildContext context) {
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
          GridView.count(
            crossAxisCount: 2,
            scrollDirection: Axis.vertical,
            children: List.generate(100, (index) {
              return GestureDetector(
                onTap: () {print('Clicked item $index');},
                child: Center(
                  child: Text(
                    'Item $index',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              );
            }),
          ),
          Center(
            child: Text('Tab 2'),
          ),
          Center(
            child: Text('Tab 3'),
          ),
          Center(
            child: Text('Tab 4'),
          ),
          Center(
            child: Text('Tab 5'),
          ),
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
              Navigator.pushNamed(context, '/addnewmessage');
            },
            child: Icon(Icons.add),
          ),
          SpeedDialChild(
            backgroundColor: kPrimaryColorLight,
            onTap: () {
              print('Tapped Edit');
              Navigator.pushNamed(context, '/editmessage');

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
        Navigator.pushNamed(context, '/introduction');
        break;
      case 'Tips':
        print('Tapped Tips');
        _openMediumArticle();
        break;
      case 'About Developer':
        print('Tapped About Developer');
        Navigator.pushNamed(context, '/aboutdeveloper');
        break;
      case 'Sign Out':
        print('Tapped Sign Out');
        Navigator.pushNamed(context, '/signin');
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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
