import 'package:flutter/material.dart';
import 'package:reply_flutter/styles/colors.dart';

enum MessageCategory {
  Personal,
  Social,
  Business,
  FirstAdditional,
  SecondAdditional
}

class AddNewMessage extends StatefulWidget {
  @override
  _AddNewMessageState createState() => _AddNewMessageState();
}

class _AddNewMessageState extends State<AddNewMessage> {

  MessageCategory selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        onPressed: () {Navigator.pop(context);},
        child: Icon(Icons.save),
      ),
    );
  }
}
