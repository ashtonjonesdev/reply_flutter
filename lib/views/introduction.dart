import 'package:flutter/material.dart';

class Introduction extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    final TestArguments args = ModalRoute.of(context).settings.arguments;

    String receivedArg = args.destinationMessage;

    print('Received argument: $receivedArg' );

    return Scaffold(
      appBar: AppBar(
        title: Text('Introduction'),
      ),
      body: Center(
        child: Text(receivedArg, style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}


// TODO: REMOVE
class TestArguments {

  String destinationMessage;

  TestArguments(this.destinationMessage);

}