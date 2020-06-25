import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reply_flutter/core/data/model/MessageCard.dart';
import 'package:reply_flutter/core/data/viewmodel/BusinessMessagesViewModel.dart';
import 'package:reply_flutter/core/data/viewmodel/FirstAdditionalMessagesViewModel.dart';
import 'package:reply_flutter/core/data/viewmodel/PersonalMessagesViewModel.dart';
import 'package:reply_flutter/core/data/viewmodel/SecondAdditionalMessagesViewModel.dart';
import 'package:reply_flutter/core/data/viewmodel/SocialMessagesViewModel.dart';
import 'package:reply_flutter/styles/colors.dart';

enum MessageCategory {
  Personal,
  Social,
  Business,
  FirstAdditional,
  SecondAdditional
}

class AddNewMessage extends StatefulWidget {

  static final String routeName = 'addnewmessage';

  @override
  _AddNewMessageState createState() => _AddNewMessageState();
}

class _AddNewMessageState extends State<AddNewMessage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  MessageCategory selectedValue;

  final cardMessageTitleTextController = TextEditingController();

  final cardMessageMessageTextController = TextEditingController();

  String cardMessage;

  String cardTitle;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Add new message'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 72, 8, 0),
            child: TextField(
              style: Theme.of(context).textTheme.bodyText2,
              decoration: InputDecoration(
                icon: Icon(Icons.collections),
                hintText: 'Enter a title',
              ),
              controller: cardMessageTitleTextController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: TextField(
              style: Theme.of(context).textTheme.bodyText2,
              decoration: InputDecoration(
                icon: Icon(Icons.email),
                hintText: 'Enter a message',
              ),
              controller: cardMessageMessageTextController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 96, bottom: 16),
            child: Text('Choose a category: ', style: Theme.of(context).textTheme.bodyText1,),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 48),
            child: Column(
              children: <Widget>[
                RadioListTile(
                  secondary: Icon(Icons.person),
                  title: Text('Personal', style: Theme.of(context).textTheme.bodyText1),
                  value: MessageCategory.Personal,
                  groupValue: selectedValue,
                  onChanged: (MessageCategory value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                ),
                RadioListTile(
                  secondary: Icon(Icons.group),
                  title: Text('Social', style: Theme.of(context).textTheme.bodyText1),
                  value: MessageCategory.Social,
                  groupValue: selectedValue,
                  onChanged: (MessageCategory value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                ),
                RadioListTile(
                  secondary: Icon(Icons.business_center),
                  title: Text('Business', style: Theme.of(context).textTheme.bodyText1),
                  value: MessageCategory.Business,
                  groupValue: selectedValue,
                  onChanged: (MessageCategory value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                ),
                RadioListTile(
                  secondary: Icon(Icons.plus_one),
                  title: Text('First Additional', style: Theme.of(context).textTheme.bodyText1),
                  value: MessageCategory.FirstAdditional,
                  groupValue: selectedValue,
                  onChanged: (MessageCategory value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                ),
                RadioListTile(
                  secondary: Icon(Icons.exposure_plus_2),
                  title: Text('Second Additional', style: Theme.of(context).textTheme.bodyText1),
                  value: MessageCategory.SecondAdditional,
                  groupValue: selectedValue,
                  onChanged: (MessageCategory value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColorLight,
        onPressed: saveNewMessage,
        child: Icon(Icons.save),
      ),
    );
  }

  void saveNewMessage() {

    if (cardMessageTitleTextController.text.isEmpty || cardMessageMessageTextController.text.isEmpty) {
      print('User did not enter a title or a message');
      final SnackBar snackBar = SnackBar(content: Text('Please enter a title and a message'
      ),);
      _scaffoldKey.currentState.showSnackBar(snackBar);
      return;
    }

    else {

      cardTitle = cardMessageTitleTextController.text;
      cardMessage = cardMessageMessageTextController.text;

      switch (selectedValue) {
        case MessageCategory.Personal:
          print('Saving Message to Personal Category..');
          Provider.of<PersonalMessagesViewModel>(context, listen: false)
              .addPersonalMessage(
              MessageCard(cardTitle: cardTitle, cardMessage: cardMessage));
          break;

        case MessageCategory.Social:
          print('Saving Message to Social Category..');
          Provider.of<SocialMessagesViewModel>(context, listen: false)
              .addSocialMessage(
              MessageCard(cardTitle: cardTitle, cardMessage: cardMessage));
          break;

        case MessageCategory.Business:
          print('Saving Message to Business Category..');
          Provider.of<BusinessMessagesViewModel>(context, listen: false)
              .addBusinessMessage(
              MessageCard(cardTitle: cardTitle, cardMessage: cardMessage));
          break;

        case MessageCategory.FirstAdditional:
          print('Saving Message to First Additional Category..');
          Provider.of<FirstAdditionalMessagesViewModel>(context, listen: false)
              .addFirstAdditionalMessage(
              MessageCard(cardTitle: cardTitle, cardMessage: cardMessage));
          break;

        case MessageCategory.SecondAdditional:
          print('Saving Message to Second Additional Category..');
          Provider.of<SecondAdditionalMessagesViewModel>(context, listen: false)
              .addSecondAdditionalMessage(
              MessageCard(cardTitle: cardTitle, cardMessage: cardMessage));
          break;

        default:
          print('Error in saving message');
          break;
      }

      Navigator.pop(context);
    }

  }

  @override
  void dispose() {
    cardMessageTitleTextController.dispose();
    cardMessageMessageTextController.dispose();
    super.dispose();
  }
}
