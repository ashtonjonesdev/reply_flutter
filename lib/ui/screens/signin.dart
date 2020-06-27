import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reply_flutter/core/services/AuthService.dart';
import 'package:reply_flutter/styles/colors.dart';
import 'package:reply_flutter/ui/screens/home.dart';

class SignIn extends StatefulWidget {
  static final String routeName = 'signin';

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final _formKey = GlobalKey<FormState>();

  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Sign in Information',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 5.0), // <= NEW
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
              SizedBox(height: 5.0), // <= NEW
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
              SizedBox(height: 5.0), // <= NEW
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Material(
                  borderRadius: BorderRadius.circular(30.0),
                  color: kPrimaryColor200,
                  child: MaterialButton(
                    minWidth: 400,
                    child: Text("SIGN IN"),
                    onPressed: _validateAndSignIn,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _validateAndSignIn() async {
    final form = _formKey.currentState;
    form.save();
    // Validate information was correctly entered
    if (form.validate()) {
      print('Form was successfully validated');
      print('Signing in user: Email: $_email Password: $_password');
      // Call the login method with the enter information
      _signInUserWithEmailAndPassword();
    }
  }

  void _signInUserWithEmailAndPassword() async {
    try {
      FirebaseUser result = await Provider.of<AuthService>(context,
          listen: false)
          .signInUserWithEmailAndPassword(email: _email, password: _password);
      print(result);
      print('Signed in user: Email: ${result.email} Password: $_password}');
      Navigator.popAndPushNamed(context, Home.routeName);
    } on AuthException catch (error) {
      print('AuthException: ' + error.message.toString());
      return _buildErrorDialog(context, error.toString());
    } on Exception catch (error) {
      print('Exception: ' + error.toString());
      return _buildErrorDialog(context, error.toString());
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
