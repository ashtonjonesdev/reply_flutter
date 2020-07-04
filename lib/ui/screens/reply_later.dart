import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:reply_flutter/core/data/model/MessageCard.dart';
import 'package:reply_flutter/core/data/viewmodel/PersonalMessagesViewModel.dart';
import 'package:reply_flutter/core/services/AuthService.dart';
import 'package:reply_flutter/core/utils/MessageCardArguments.dart';
import 'package:reply_flutter/styles/colors.dart';

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


  @override
  Widget build(BuildContext context) {

    final MessageCardArguments args = ModalRoute.of(context).settings.arguments;

    replyLaterMessageCardTitle = args.title;
    replyLaterMessageCardMessage = args.message;
    replyLaterMessageCard = MessageCard(title: replyLaterMessageCardTitle, message: replyLaterMessageCardMessage);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Reply Later', style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.bottomCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Reply in', style: Theme.of(context).textTheme.headline4.copyWith(color: kPrimaryColorLight, fontWeight: FontWeight.w900),textAlign: TextAlign.center,),
              _sliderValue == 1 ? Text('${_sliderValue.toInt()} hour', style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center) : Text('${_sliderValue.toInt()} hours', style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              SliderTheme(
                data: SliderThemeData(activeTrackColor: kPrimaryColorDark, inactiveTrackColor: kPrimaryColor100, thumbColor: kPrimaryColorDark, valueIndicatorColor: kPrimaryColor),
                child: Slider(
                  min: 0.0,
                  max: 24.0,
                  label:'${_sliderValue.toInt()}',
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
              Text('with your message', style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 16), textAlign: TextAlign.center,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${replyLaterMessageCard.title}:', style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 20, fontWeight: FontWeight.w700), textAlign: TextAlign.center,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(replyLaterMessageCard.message, style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14), textAlign: TextAlign.center,),
              ),
              MaterialButton(
                color: kPrimaryColor700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
                ),
                textColor: Colors.white,
                child: Text('SET TIMER'),
                onPressed: () {
                  print('Pressed set timer button');
                  // Save reply later message to Firebase
                  addReplyLaterMessage();
                  // start the timer
                  startTimer();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void addReplyLaterMessage() async {

    FirebaseUser firebaseUser = await Provider.of<AuthService>(context, listen: false).getUser();

    Provider.of<PersonalMessagesViewModel>(context, listen: false).addReplyLaterMessage(firebaseUser, replyLaterMessageCard);

    MessageCard messageCard = await Provider.of<PersonalMessagesViewModel>(context, listen: false).getReplyLaterMessage(firebaseUser);

    print('Received reply later message: $messageCard');



  }

  startTimer() {

//    Duration timerDuration = Duration(milliseconds: 60 * 60 * _sliderValue.toInt());

    // test duration
    Duration duration = Duration(milliseconds: 3000);

    print('Setting timer');

    return new Timer(duration, sendNotification);

  }

  sendNotification() {

    print('Timer expired!');
    // Send notification


    // Cancel the timer


  }

}
