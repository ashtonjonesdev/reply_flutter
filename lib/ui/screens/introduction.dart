import 'package:flutter/material.dart';
import 'package:reply_flutter/styles/colors.dart';

class Introduction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              'Welcome to Reply!',
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: kPrimaryColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Easily send your own custom messages through any platform',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: kPrimaryColorLight),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            'Create your own message templates',
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          Image.asset('images/icons8_comments_48.png'),
          Text(
            'Tap your message to preview, edit, or send your message',
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          Image.asset('images/icons8_copy_48.png'),
          Text(
            'Send your message through any platform',
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          Image.asset('images/icons8_send_48.png'),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 32),
            child: MaterialButton(
              minWidth: double.infinity,
              color: kPrimaryColorDark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'Get Started'.toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(color: kBackgroundColor),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
