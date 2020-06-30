import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reply_flutter/core/data/model/MessageCard.dart';
import 'package:reply_flutter/core/services/AuthService.dart';

class FirebaseRepository with ChangeNotifier {

  FirebaseRepository();


  final firestoreInstance = Firestore.instance;

  void createUserInDatabaseWithEmail(FirebaseUser firebaseUser) async {

    await firestoreInstance.collection('users').document(firebaseUser.uid).setData({
      "name" : firebaseUser.displayName,
      "email": firebaseUser.email
    }).whenComplete(() => print('Created user in database with email. Name: ${firebaseUser.displayName} | Email: ${firebaseUser.email}'));

  }

  void createUserInDatabaseWithGoogleProvider(FirebaseUser firebaseUser) async {


    await firestoreInstance.collection('users').document(firebaseUser.uid).setData({
      "name" : firebaseUser.displayName,
      "email": firebaseUser.email,
      "personalMessages" : [MessageCard(cardTitle: 'Hi ${firebaseUser.displayName}! 👋🏼', cardMessage: 'Add your own message!'),]
    }).whenComplete(() => print('Created user in database with email. Name: ${firebaseUser.displayName} | Email: ${firebaseUser.email}'));

  }

}