import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reply_flutter/core/services/AuthService.dart';
import 'package:reply_flutter/styles/colors.dart';
class Register extends StatefulWidget {

  static final String routeName = 'register';

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _formKey = GlobalKey<FormState>();

  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0), // <= NEW
              Text(
                'Registration Information',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20.0), // <= NEW
              TextFormField(
                style: Theme.of(context).textTheme.bodyText1,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "Email Address"),
                onSaved: (value) => _email = value,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0), // <= NEW
              TextFormField(
                style: Theme.of(context).textTheme.bodyText1,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
                obscureText: true,
                decoration: InputDecoration(labelText: "Password"),
                onSaved: (value) => _password = value,
              ),
              SizedBox(height: 20.0), // <= NEW
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Material(
                  borderRadius: BorderRadius.circular(30.0),
                  color: kPrimaryColor200,
                  child: MaterialButton(
                    minWidth: 400,
                    child: Text("SIGN UP"),
                    onPressed: _registerAndValidateUser,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _registerAndValidateUser() async {
    final form = _formKey.currentState;
    form.save();
    // Validate information was correctly entered
    if (form.validate()) {
      print('Registering user: Email: $_email Password: $_password');
      // Call the login method with the enter information
      try {
        FirebaseUser result = await Provider.of<AuthService>(context,
            listen: false)
            .createUser(email: _email, password: _password);
        print(result);
        print('Registered user: Email: ${result.email} Password: $_password}');
      } on AuthException catch (error) {
        print(error.message.toString());
        return _buildErrorDialog(context, error.toString());
      } on Exception catch (error) {
        print(error.toString());
        return _buildErrorDialog(context, error.toString());
      }
    }
  }

  Future _buildErrorDialog(BuildContext context, _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text('Error Message'),
          content: Text(_message),
          actions: [
            FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }
}
