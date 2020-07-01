import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reply_flutter/core/data/model/MessageCard.dart';
import 'package:reply_flutter/core/services/AuthService.dart';

class FirebaseRepository with ChangeNotifier {

  FirebaseRepository();


  final firestoreInstance = Firestore.instance;

  static const String USERS_COLLECTION = 'users';

  static const String NAME_FIELD = 'name';
  static const String EMAIL_FIELD = 'email';
  static const String PERSONAL_MESSAGES_FIELD = 'personalMessages';
  static const String SOCIAL_MESSAGES_FIELD = 'socialMessages';
  static const String BUSINESS_MESSAGES_FIELD = 'businessMessages';
  static const String FIRST_ADDITIONAL_MESSAGES_FIELD = 'firstAdditionalMessages';
  static const String SECOND_ADDITIONAL_MESSAGES_FIELD = 'secondAdditionalMessages';
  static const String CARD_MESSAGE_TITLE_FIELD = 'title';
  static const String CARD_MESSAGE_MESSAGE_FIELD = 'message';








  void createUserInDatabaseWithEmail(FirebaseUser firebaseUser) async {

    await firestoreInstance.collection(USERS_COLLECTION).document(firebaseUser.uid).setData({
      NAME_FIELD : firebaseUser.displayName,
      EMAIL_FIELD: firebaseUser.email,
      PERSONAL_MESSAGES_FIELD : [MessageCard(title: 'Hi ${firebaseUser.displayName}! 👋🏼', message: 'Add your own message!').toJson(),MessageCard(title: 'Hello ${firebaseUser.displayName}! 👋🏼', message: 'Add your own message!').toJson()]
    }).whenComplete(() => print('Created user in database with email. Name: ${firebaseUser.displayName} | Email: ${firebaseUser.email}'));

  }

  void createUserInDatabaseWithGoogleProvider(FirebaseUser firebaseUser) async {


    await firestoreInstance.collection(USERS_COLLECTION).document(firebaseUser.uid).setData({
      NAME_FIELD : firebaseUser.displayName,
      EMAIL_FIELD: firebaseUser.email,
      PERSONAL_MESSAGES_FIELD : [MessageCard(title: 'Hi ${firebaseUser.displayName}! 👋🏼', message: 'Add your own message!').toJson(),MessageCard(title: 'Hello ${firebaseUser.displayName}! 👋🏼', message: 'Add a new message!').toJson()]
    }).whenComplete(() => print('Created user in database with email. Name: ${firebaseUser.displayName} | Email: ${firebaseUser.email}')).catchError((error) {print(error.toString());});

  }

  Future<List<MessageCard>> getPersonalMessages(FirebaseUser firebaseUser) async {

    List<MessageCard> personalMessages = List();

    await firestoreInstance.collection(USERS_COLLECTION).document(firebaseUser.uid).get().then((document) {

      if(document.exists) {

        // Get the List of Maps
        List values = document.data[PERSONAL_MESSAGES_FIELD];
        print('List received: $values');


        // For each map (each message card) in the list, add a MessageCard to the MessageCard list (using the fromJson method)
        for(Map<String, dynamic> map in values ) {
          print('Map received in List: $map');

          /// Create the MessageCard from the map
          MessageCard messageCard = MessageCard.fromJson(map);
          print('Retrieved Message Card: ${messageCard.title} | ${messageCard.message}');

          /// Add the MessageCard to the list
          personalMessages.add(messageCard);
          print('Added MessageCard to list: ${personalMessages.last}');

        }
      }
    });


    return personalMessages;

  }


}