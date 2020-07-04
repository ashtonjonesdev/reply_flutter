

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reply_flutter/core/data/model/MessageCard.dart';
import 'package:reply_flutter/core/data/viewmodel/PersonalMessagesViewModel.dart';
import 'package:reply_flutter/core/services/AuthService.dart';
import 'package:reply_flutter/core/utils/MessageCardArguments.dart';
import 'package:reply_flutter/styles/colors.dart';

class EditMessage extends StatefulWidget {

  static final String routeName = 'editmessage';

  @override
  _EditMessageState createState() => _EditMessageState();
}

class _EditMessageState extends State<EditMessage> {

  @override
  void initState() {
    super.initState();

  }

  final GlobalKey<ScaffoldState> _scaffoldKeyEditMessage = GlobalKey<ScaffoldState>();



  final cardMessageTitleTextController = TextEditingController();
  final cardMessageMessageTextController = TextEditingController();

  String _oldMessageCardTitle;
  String _oldMessageCardMessage;

  MessageCard _oldMessageCard;

  String _newMessageCardTitle;
  String _newMessageCardMessage;

  MessageCard _newMessageCard;

  @override
  Widget build(BuildContext context) {

    // Get the arguments passed from the selectedMessage
    final MessageCardArguments args = ModalRoute.of(context).settings.arguments;

    // Set the text fields using the selected message data
    cardMessageTitleTextController.text = args.title;
    cardMessageMessageTextController.text = args.message;

    // Set the oldMessageCardData
    _oldMessageCardTitle = args.title;
    _oldMessageCardMessage = args.message;

    _oldMessageCard = MessageCard(title: _oldMessageCardTitle, message: _oldMessageCardMessage);

    // Initialize the newMessageCardData in case one or both of the fields are not changed
    _newMessageCardTitle = args.title;
    _newMessageCardMessage = args.message;

    _newMessageCard = MessageCard(title: _newMessageCardTitle, message: _newMessageCardMessage);


    return Scaffold(
      key: _scaffoldKeyEditMessage,
      appBar: AppBar(
        title: Text('Edit message'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 32, 8, 0),
            child: TextField(
              onChanged: (text) {
                _newMessageCardTitle = text;
              },
              controller: cardMessageTitleTextController,
              style: Theme.of(context).textTheme.bodyText2,
              decoration: InputDecoration(
                labelText: 'Enter a new card title',
                icon: Icon(Icons.collections),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: TextField(
              controller: cardMessageMessageTextController,
              onChanged: (text) {
                _newMessageCardMessage = text;
              },
              style: Theme.of(context).textTheme.bodyText2,
              decoration: InputDecoration(
                labelText: 'Enter a new card message',
                icon: Icon(Icons.mail),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColorLight,
        child: Icon(Icons.save),
        onPressed: () {

          editPersonalMessage();

        },
      ),
    );
  }

  void editPersonalMessage() async {

    if(cardMessageTitleTextController.text.isEmpty || cardMessageMessageTextController.text.isEmpty) {
      print('User did not enter a title or a message');
      final SnackBar snackBar = SnackBar(content: Text('Please enter a title and a message'
      ),);
      _scaffoldKeyEditMessage.currentState.showSnackBar(snackBar);
    }

    else {

      FirebaseUser firebaseUser = await Provider.of<AuthService>(context, listen: false).getUser();

      _newMessageCard = MessageCard(title: _newMessageCardTitle, message: _newMessageCardMessage);

      Provider.of<PersonalMessagesViewModel>(context, listen: false).editPersonalMessage(firebaseUser, _oldMessageCard, _newMessageCard);

      Navigator.pop(context);

    }

  }



}

