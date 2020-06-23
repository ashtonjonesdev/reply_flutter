import 'package:flutter/material.dart';

class ReplyLater extends StatefulWidget {
  @override
  _ReplyLaterState createState() => _ReplyLaterState();
}

class _ReplyLaterState extends State<ReplyLater> {

  int hoursValue = 1;
  String hour = 'hour';
  String hours = 'hours';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Reply Later', style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: <Widget>[
          Text('Reply in', style: Theme.of(context).textTheme.headline3),
        ],
      ),
    );
  }
}
