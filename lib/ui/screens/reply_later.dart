import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:reply_flutter/core/data/model/MessageCard.dart';
import 'package:reply_flutter/core/data/repository/firebase_repository.dart';
import 'package:reply_flutter/core/data/viewmodel/PersonalMessagesViewModel.dart';
import 'package:reply_flutter/core/services/AuthService.dart';
import 'package:reply_flutter/core/utils/MessageCardArguments.dart';
import 'package:reply_flutter/styles/colors.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share/share.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}

FirebaseRepository _firebaseRepository = FirebaseRepository();

class ReplyLater extends StatefulWidget {
  static final String routeName = 'replylater';

  @override
  _ReplyLaterState createState() => _ReplyLaterState();
}

class _ReplyLaterState extends State<ReplyLater> {
  int hoursValue = 1;
  String hour = 'hour';
  String hours = 'hours';

  String replyLaterMessageCardTitle;
  String replyLaterMessageCardMessage;

  MessageCard replyLaterMessageCard;

  double _sliderValue = 1;

  Timer timer;

  final GlobalKey<ScaffoldState> _scaffoldKeyReplyLater =
      GlobalKey<ScaffoldState>();

  Future<void> initializeFlutterLocalNotifications() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
        onDidReceiveLocalNotification:
            (int id, String title, String body, String payload) async {
          didReceiveLocalNotificationSubject.add(ReceivedNotification(
              id: id, title: title, body: body, payload: payload));
        });
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      if (payload != null) {
        debugPrint('notification payload: ' + payload);
        // Cancel the notification
        await flutterLocalNotificationsPlugin.cancelAll();
        /// Send the ReplyLatermessage, using the payload (Reply later message)
        Share.share(payload);

      }
    });


  }


  Future<void> _showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'primary_notification_channel',
        'Notifications',
        'General notifications',
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'ticker',
        onlyAlertOnce: true);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    // Get the ReplyLater message
    FirebaseUser firebaseUser =
        await Provider.of<AuthService>(context, listen: false).getUser();
    MessageCard replyLaterMessageCard =
        await Provider.of<PersonalMessagesViewModel>(context, listen: false)
            .getReplyLaterMessage(firebaseUser);

    // Send the reply later message upon tapping the notification

    String replyLaterMessage;

    if (replyLaterMessageCard != null &&
        replyLaterMessageCard.message != null &&
        replyLaterMessageCard.message.length > 0) {
      replyLaterMessage = replyLaterMessageCard.message;
    }

    await flutterLocalNotificationsPlugin.show(0, 'Time to Reply!',
        'Tap to send your message', platformChannelSpecifics,
        payload: replyLaterMessage);
  }

  @override
  void initState() {
    super.initState();

    initializeFlutterLocalNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final MessageCardArguments args = ModalRoute.of(context).settings.arguments;

    replyLaterMessageCardTitle = args.title;
    replyLaterMessageCardMessage = args.message;
    replyLaterMessageCard = MessageCard(
        title: replyLaterMessageCardTitle,
        message: replyLaterMessageCardMessage);

    return Scaffold(
      key: _scaffoldKeyReplyLater,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Reply Later',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'Reply in',
            style: Theme.of(context).textTheme.headline4.copyWith(
                color: kPrimaryColorLight, fontWeight: FontWeight.w900),
            textAlign: TextAlign.center,
          ),
          _sliderValue == 1
              ? Text('${_sliderValue.toInt()} hour',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center)
              : Text('${_sliderValue.toInt()} hours',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
          SliderTheme(
            data: SliderThemeData(
                activeTrackColor: kPrimaryColorDark,
                inactiveTrackColor: kPrimaryColor100,
                thumbColor: kPrimaryColorDark,
                valueIndicatorColor: kPrimaryColor),
            child: Slider(
              min: 0.0,
              max: 24.0,
              label: '${_sliderValue.toInt()}',
              divisions: 24,
              value: _sliderValue,
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                  print(value);
                });
              },
            ),
          ),
          Text(
            'with your message',
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${replyLaterMessageCard.title}:',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              replyLaterMessageCard.message,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          MaterialButton(
            color: kPrimaryColor700,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            textColor: Colors.white,
            child: Text('SET TIMER'),
            onPressed: () {
              print('Pressed set timer button');
              // Show feedback to the user
              showUserFeedback();
              // Save reply later message to Firebase
              addReplyLaterMessage();
              // start the timer (which will launch the notification once the time is up)
              startTimer();
            },
          )
        ],
      ),
    );
  }

  void addReplyLaterMessage() async {
    FirebaseUser firebaseUser =
        await Provider.of<AuthService>(context, listen: false).getUser();

    Provider.of<PersonalMessagesViewModel>(context, listen: false)
        .addReplyLaterMessage(firebaseUser, replyLaterMessageCard);

    MessageCard messageCard =
        await Provider.of<PersonalMessagesViewModel>(context, listen: false)
            .getReplyLaterMessage(firebaseUser);

    print('Received reply later message: $messageCard');
  }

  dynamic startTimer() {
    // 1 hour: 3,600,000 milliseconds (1000 * 60 * 60)
//    Duration timerDuration = Duration(milliseconds: 1000* 60 * 60 * _sliderValue.toInt());

    // test duration TODO: Remove
    Duration duration = Duration(milliseconds: 3000);

    print('Setting timer');

    return new Timer(duration, sendNotification);
  }

  void sendNotification() {
    print('Timer expired!');
    // Send notification
    _showNotification();
  }

  void showUserFeedback() {
    _sliderValue == 1
        ? _scaffoldKeyReplyLater.currentState.showSnackBar(SnackBar(
            content: Text(
              'You will be reminded in ${_sliderValue.toInt()} hour!',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white),
            ),
            backgroundColor: kPrimaryColor700,
            elevation: 8,
            duration: Duration(milliseconds: 5000),
        action: SnackBarAction(
          textColor: Colors.white,
          label: 'OK',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
          ),)
        : _scaffoldKeyReplyLater.currentState.showSnackBar(SnackBar(
            content: Text(
              'You will be reminded in ${_sliderValue.toInt()} hours!',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white),
            ),
            backgroundColor: kPrimaryColor700,
            elevation: 8,
            duration: Duration(milliseconds: 3000),
            action: SnackBarAction(
              textColor: Colors.white,
              label: 'OK',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),);


  }
}
