import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reply_flutter/core/services/AuthService.dart';
import 'package:reply_flutter/styles/colors.dart';
import 'package:reply_flutter/ui/screens/home.dart';
import 'package:reply_flutter/ui/screens/welcome.dart';

class Register extends StatefulWidget {
  static final String routeName = 'register';

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  String _firstName;
  String _lastName;
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Registration Information',
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(
                style: Theme.of(context).textTheme.bodyText1,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter a first name';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: "First Name"),
                onSaved: (value) => _firstName = value,
              ),
              SizedBox(height: 5.0),
              TextFormField(
                style: Theme.of(context).textTheme.bodyText1,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter a last name';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: "Last Name"),
                onSaved: (value) => _lastName = value,
              ),
              SizedBox(height: 5.0), // <= NEW// <= NEW
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
                  if(value.length < 6) {
                    return 'Password should be at least 6 characters';
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
                    child: Text("SIGN UP"),
                    onPressed: validateAndRegisterUser,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  validateAndRegisterUser() async {
    final form = _formKey.currentState;
    form.save();
    // Validate information was correctly entered
    if (form.validate()) {
      print('Form was successfully validated');
      print('Registering user: Email: $_email Password: $_password');
      // Call the login method with the enter information
      createUserWithEmailAndPassword();
    }
  }

  void createUserWithEmailAndPassword() async {
    try {
      FirebaseUser newUser =
          await Provider.of<AuthService>(context, listen: false)
              .createUserWithEmailAndPassword(
                  firstName: _firstName,
                  lastName: _lastName,
                  email: _email,
                  password: _password);
      print(newUser);
      print('Registered user: Email: ${newUser.email} Password: $_password}');
      if(newUser != null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => Home()),
                (Route<dynamic> route) => false);
      }
    } on AuthException catch (error) {
      print('AuthException: ' + error.message.toString());
      return _buildErrorDialog(context, error.toString());
    } on Exception catch (error) {
      print('Exception: ' + error.toString());
      return _buildErrorDialog(context, error.toString());
    }
  }

  Future _buildErrorDialog(BuildContext context, _message) {

    String errorMessage = 'error';
    bool returnToWelcomeScreen = false;

    return showDialog(
      builder: (context) {
        switch(_message) {
          case 'PlatformException(ERROR_EMAIL_ALREADY_IN_USE, The email address is already in use by another account., null)':
            errorMessage = 'This account is already registered. Please return to sign in';
            returnToWelcomeScreen = true;
            break;
          case 'PlatformException(ERROR_NETWORK_REQUEST_FAILED, A network error (such as timeout, interrupted connection or unreachable host) has occurred., null)':
            errorMessage = 'A network error has occurred. Please try again when the connection is stable';
            returnToWelcomeScreen = true;
            break;
          case 'PlatformException(ERROR_INVALID_EMAIL, The email address is badly formatted., null)':
            errorMessage = 'Invalid email. Please enter a valid email';
            returnToWelcomeScreen = false;
            break;
          default:
            errorMessage = 'Unknown error occurred';
            returnToWelcomeScreen = true;
            break;
        }
        return AlertDialog(
          title: Text('Error Message'),
          content: Text(errorMessage, style: Theme.of(context).textTheme.bodyText1,),
          actions: [
            FlatButton(
                child: Text('OK'),
                onPressed: () {
                  returnToWelcomeScreen ? Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (BuildContext context) => Welcome()),
                          (Route<dynamic> route) => false) : Navigator.of(context).pop();
                })

          ],
        );
      },
      context: context,
    );
  }
}
