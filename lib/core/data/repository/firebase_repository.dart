import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:reply_flutter/core/data/model/MessageCard.dart';
import 'package:reply_flutter/core/data/repository/RepositoryInterface.dart';

class FirebaseRepository with ChangeNotifier implements RepositoryInterface {

  FirebaseRepository();


  final firestoreInstance = FirebaseFirestore.instance;

  static const String USERS_COLLECTION = 'users';

  static const String NAME_FIELD = 'name';
  static const String EMAIL_FIELD = 'email';
  static const String PERSONAL_MESSAGES_FIELD = 'personalMessages';
  static const String SOCIAL_MESSAGES_FIELD = 'socialMessages';
  static const String BUSINESS_MESSAGES_FIELD = 'businessMessages';
  static const String FIRST_ADDITIONAL_MESSAGES_FIELD = 'firstAdditionalMessages';
  static const String SECOND_ADDITIONAL_MESSAGES_FIELD = 'secondAdditionalMessages';
  static const String REPLY_LATER_MESSAGE_FIELD = 'replyLater';
  static const String CARD_MESSAGE_TITLE_FIELD = 'title';
  static const String CARD_MESSAGE_MESSAGE_FIELD = 'message';








  void createUserInDatabaseWithEmail(auth.User firebaseUser) async {

    await firestoreInstance.collection(USERS_COLLECTION).doc(firebaseUser.uid).set({
      NAME_FIELD : firebaseUser.displayName,
      EMAIL_FIELD: firebaseUser.email,
      PERSONAL_MESSAGES_FIELD : [MessageCard(title: 'Hi ${firebaseUser.displayName}! 👋🏼', message: 'Add your own message!').toJson(),MessageCard(title: 'Hello ${firebaseUser.displayName}! 👋🏼', message: 'Add your own message!').toJson()],
      SOCIAL_MESSAGES_FIELD : [MessageCard(title: 'Hi ${firebaseUser.displayName}! 👋🏼', message: 'Add your own message!').toJson(),MessageCard(title: 'Hello ${firebaseUser.displayName}! 👋🏼', message: 'Add your own message!').toJson()],
      BUSINESS_MESSAGES_FIELD : [MessageCard(title: 'Hi ${firebaseUser.displayName}! 👋🏼', message: 'Add your own message!').toJson(),MessageCard(title: 'Hello ${firebaseUser.displayName}! 👋🏼', message: 'Add your own message!').toJson()],
      FIRST_ADDITIONAL_MESSAGES_FIELD : [MessageCard(title: 'Hi ${firebaseUser.displayName}! 👋🏼', message: 'Add your own message!').toJson(),MessageCard(title: 'Hello ${firebaseUser.displayName}! 👋🏼', message: 'Add a new message!').toJson()],
      SECOND_ADDITIONAL_MESSAGES_FIELD : [MessageCard(title: 'Hi ${firebaseUser.displayName}! 👋🏼', message: 'Add your own message!').toJson(),MessageCard(title: 'Hello ${firebaseUser.displayName}! 👋🏼', message: 'Add a new message!').toJson()],
    }).whenComplete(() => print('Created user in database with email. Name: ${firebaseUser.displayName} | Email: ${firebaseUser.email}'));

  }

  void createUserInDatabaseWithGoogleProvider(auth.User firebaseUser) async {

    await firestoreInstance.collection(USERS_COLLECTION).doc(firebaseUser.uid).set({
      NAME_FIELD : firebaseUser.displayName,
      EMAIL_FIELD: firebaseUser.email,
      PERSONAL_MESSAGES_FIELD : [MessageCard(title: 'Hi ${firebaseUser.displayName}! 👋🏼', message: 'Add your own message!').toJson(),MessageCard(title: 'Hello ${firebaseUser.displayName}! 👋🏼', message: 'Add your own message!').toJson()],
      SOCIAL_MESSAGES_FIELD : [MessageCard(title: 'Hi ${firebaseUser.displayName}! 👋🏼', message: 'Add your own message!').toJson(),MessageCard(title: 'Hello ${firebaseUser.displayName}! 👋🏼', message: 'Add your own message!').toJson()],
      BUSINESS_MESSAGES_FIELD : [MessageCard(title: 'Hi ${firebaseUser.displayName}! 👋🏼', message: 'Add your own message!').toJson(),MessageCard(title: 'Hello ${firebaseUser.displayName}! 👋🏼', message: 'Add your own message!').toJson()],
      FIRST_ADDITIONAL_MESSAGES_FIELD : [MessageCard(title: 'Hi ${firebaseUser.displayName}! 👋🏼', message: 'Add your own message!').toJson(),MessageCard(title: 'Hello ${firebaseUser.displayName}! 👋🏼', message: 'Add a new message!').toJson()],
      SECOND_ADDITIONAL_MESSAGES_FIELD : [MessageCard(title: 'Hi ${firebaseUser.displayName}! 👋🏼', message: 'Add your own message!').toJson(),MessageCard(title: 'Hello ${firebaseUser.displayName}! 👋🏼', message: 'Add a new message!').toJson()],

    }).whenComplete(() => print('Created user in database with Google Provider. Name: ${firebaseUser.displayName} | Email: ${firebaseUser.email}')).catchError((error) {print(error.toString());});

  }

  void createUserInDatabaseWithAppleProvider(auth.User firebaseUser) async {

    await firestoreInstance.collection(USERS_COLLECTION).doc(firebaseUser.uid).set({
      NAME_FIELD : firebaseUser.displayName,
      PERSONAL_MESSAGES_FIELD : [MessageCard(title: 'Hi ${firebaseUser.displayName}! 👋🏼', message: 'Add your own message!').toJson(),MessageCard(title: 'Hello ${firebaseUser.displayName}! 👋🏼', message: 'Add your own message!').toJson()],
      SOCIAL_MESSAGES_FIELD : [MessageCard(title: 'Hi ${firebaseUser.displayName}! 👋🏼', message: 'Add your own message!').toJson(),MessageCard(title: 'Hello ${firebaseUser.displayName}! 👋🏼', message: 'Add your own message!').toJson()],
      BUSINESS_MESSAGES_FIELD : [MessageCard(title: 'Hi ${firebaseUser.displayName}! 👋🏼', message: 'Add your own message!').toJson(),MessageCard(title: 'Hello ${firebaseUser.displayName}! 👋🏼', message: 'Add your own message!').toJson()],
      FIRST_ADDITIONAL_MESSAGES_FIELD : [MessageCard(title: 'Hi ${firebaseUser.displayName}! 👋🏼', message: 'Add your own message!').toJson(),MessageCard(title: 'Hello ${firebaseUser.displayName}! 👋🏼', message: 'Add a new message!').toJson()],
      SECOND_ADDITIONAL_MESSAGES_FIELD : [MessageCard(title: 'Hi ${firebaseUser.displayName}! 👋🏼', message: 'Add your own message!').toJson(),MessageCard(title: 'Hello ${firebaseUser.displayName}! 👋🏼', message: 'Add a new message!').toJson()],

    }).whenComplete(() => print('Created user in database with Apple Provider. Name: ${firebaseUser.displayName} | Email: ${firebaseUser.email}')).catchError((error) {print(error.toString());});

  }

  Future<List<MessageCard>> getPersonalMessages(auth.User firebaseUser) async {

    List<MessageCard> personalMessages = List();

    await firestoreInstance.collection(USERS_COLLECTION).doc(firebaseUser.uid).get().then((document) {

      if(document.exists) {

        // Get the List of Maps
        List values = document.get(PERSONAL_MESSAGES_FIELD);
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

  @override
  Future<List<MessageCard>> getBusinessMessages(auth.User firebaseUser) async {

    List<MessageCard> businessMessages = List();

    await firestoreInstance.collection(USERS_COLLECTION).doc(firebaseUser.uid).get().then((document) {

      if(document.exists) {

        // Get the List of Maps
        List values = document.get(BUSINESS_MESSAGES_FIELD);
        print('List received: $values');


        // For each map (each message card) in the list, add a MessageCard to the MessageCard list (using the fromJson method)
        for(Map<String, dynamic> map in values ) {
          print('Map received in List: $map');

          /// Create the MessageCard from the map
          MessageCard messageCard = MessageCard.fromJson(map);
          print('Retrieved Message Card: ${messageCard.title} | ${messageCard.message}');

          /// Add the MessageCard to the list
          businessMessages.add(messageCard);
          print('Added MessageCard to list: ${businessMessages.last}');

        }
      }
    });


    return businessMessages;
  }

  @override
  Future<List<MessageCard>> getFirstAdditionalMessages(auth.User firebaseUser) async {

    List<MessageCard> firstAdditionalMessages = List();

    await firestoreInstance.collection(USERS_COLLECTION).doc(firebaseUser.uid).get().then((document) {

      if(document.exists) {

        // Get the List of Maps
        List values = document.get(FIRST_ADDITIONAL_MESSAGES_FIELD);
        print('List received: $values');


        // For each map (each message card) in the list, add a MessageCard to the MessageCard list (using the fromJson method)
        for(Map<String, dynamic> map in values ) {
          print('Map received in List: $map');

          /// Create the MessageCard from the map
          MessageCard messageCard = MessageCard.fromJson(map);
          print('Retrieved Message Card: ${messageCard.title} | ${messageCard.message}');

          /// Add the MessageCard to the list
          firstAdditionalMessages.add(messageCard);
          print('Added MessageCard to list: ${firstAdditionalMessages.last}');

        }
      }
    });


    return firstAdditionalMessages;
  }

  @override
  Future<List<MessageCard>> getSecondAdditionalMessages(auth.User firebaseUser) async {

    List<MessageCard> secondAdditionalMessages = List();

    await firestoreInstance.collection(USERS_COLLECTION).doc(firebaseUser.uid).get().then((document) {

      if(document.exists) {

        // Get the List of Maps
        List values = document.get(SECOND_ADDITIONAL_MESSAGES_FIELD);
        print('List received: $values');


        // For each map (each message card) in the list, add a MessageCard to the MessageCard list (using the fromJson method)
        for(Map<String, dynamic> map in values ) {
          print('Map received in List: $map');

          /// Create the MessageCard from the map
          MessageCard messageCard = MessageCard.fromJson(map);
          print('Retrieved Message Card: ${messageCard.title} | ${messageCard.message}');

          /// Add the MessageCard to the list
          secondAdditionalMessages.add(messageCard);
          print('Added MessageCard to list: ${secondAdditionalMessages.last}');

        }
      }
    });


    return secondAdditionalMessages;
  }

  @override
  Future<List<MessageCard>> getSocialMessages(auth.User firebaseUser) async {

    List<MessageCard> socialMessages = List();

    await firestoreInstance.collection(USERS_COLLECTION).doc(firebaseUser.uid).get().then((document) {

      if(document.exists) {

        // Get the List of Maps
        List values = document.get(SOCIAL_MESSAGES_FIELD);
        print('List received: $values');


        // For each map (each message card) in the list, add a MessageCard to the MessageCard list (using the fromJson method)
        for(Map<String, dynamic> map in values ) {
          print('Map received in List: $map');

          /// Create the MessageCard from the map
          MessageCard messageCard = MessageCard.fromJson(map);
          print('Retrieved Message Card: ${messageCard.title} | ${messageCard.message}');

          /// Add the MessageCard to the list
          socialMessages.add(messageCard);
          print('Added MessageCard to list: ${socialMessages.last}');

        }
      }
    });


    return socialMessages;
  }

  @override
  Future<MessageCard> getReplyLaterMessage(auth.User firebaseUser) async {

    List<MessageCard> replyLaterMessageList = List();

    await firestoreInstance.collection(USERS_COLLECTION).doc(firebaseUser.uid).get().then((document) {

      if(document.exists) {

        // Get the List of Maps
        List values = document.get(REPLY_LATER_MESSAGE_FIELD);
        print('List received: $values');


        // For each map (each message card) in the list, add a MessageCard to the MessageCard list (using the fromJson method)
        for(Map<String, dynamic> map in values ) {
          print('Map received in List: $map');

          /// Create the MessageCard from the map
          MessageCard messageCard = MessageCard.fromJson(map);
          print('Retrieved Message Card: ${messageCard.title} | ${messageCard.message}');

          /// Add the MessageCard to the list
          replyLaterMessageList.add(messageCard);
          print('Added MessageCard to list: ${replyLaterMessageList.last}');

        }
      }
    });


    return replyLaterMessageList[0];
  }

  void addPersonalMessage(auth.User firebaseUser, MessageCard messageCardToAdd) async {

    Map messageCardData = messageCardToAdd.toJson();

    List messageCardList = [messageCardData];

    await firestoreInstance.collection(USERS_COLLECTION).doc(firebaseUser.uid).update({

      PERSONAL_MESSAGES_FIELD : FieldValue.arrayUnion(messageCardList)

    });
  }

  @override
  void addBusinessMessage(auth.User firebaseUser, MessageCard messageCardToAdd) async {

    Map messageCardData = messageCardToAdd.toJson();

    List messageCardList = [messageCardData];

    await firestoreInstance.collection(USERS_COLLECTION).doc(firebaseUser.uid).update({

      BUSINESS_MESSAGES_FIELD : FieldValue.arrayUnion(messageCardList)

    });
  }

  @override
  void addFirstAdditionalMessage(auth.User firebaseUser, MessageCard messageCardToAdd) async {

    Map messageCardData = messageCardToAdd.toJson();

    List messageCardList = [messageCardData];

    await firestoreInstance.collection(USERS_COLLECTION).doc(firebaseUser.uid).update({

      FIRST_ADDITIONAL_MESSAGES_FIELD : FieldValue.arrayUnion(messageCardList)

    });
  }

  @override
  void addSecondAdditionalMessage(auth.User firebaseUser, MessageCard messageCardToAdd) async {

    Map messageCardData = messageCardToAdd.toJson();

    List messageCardList = [messageCardData];

    await firestoreInstance.collection(USERS_COLLECTION).doc(firebaseUser.uid).update({

      SECOND_ADDITIONAL_MESSAGES_FIELD : FieldValue.arrayUnion(messageCardList)

    });
  }

  @override
  void addSocialMessage(auth.User firebaseUser, MessageCard messageCardToAdd) async {

    Map messageCardData = messageCardToAdd.toJson();

    List messageCardList = [messageCardData];

    await firestoreInstance.collection(USERS_COLLECTION).doc(firebaseUser.uid).update({

      SOCIAL_MESSAGES_FIELD : FieldValue.arrayUnion(messageCardList)

    });
  }

  @override
  void addReplyLaterMessage(auth.User firebaseUser, MessageCard replyLaterMessageCard) async {

    Map messageCardData = replyLaterMessageCard.toJson();

    List messageCardList = [messageCardData];

    await firestoreInstance.collection(USERS_COLLECTION).doc(firebaseUser.uid).update({

      REPLY_LATER_MESSAGE_FIELD : messageCardList

    });

  }

  @override
  void deleteBusinessMessage(auth.User firebaseUser, MessageCard messageCardToDelete) async {

    Map messageCardData = messageCardToDelete.toJson();

    List messageCardList = [messageCardData];

    await firestoreInstance.collection(USERS_COLLECTION).doc(firebaseUser.uid).update({

      BUSINESS_MESSAGES_FIELD : FieldValue.arrayRemove(messageCardList)

    });
  }

  @override
  void deleteFirstAdditionalMessage(auth.User firebaseUser, MessageCard messageCardToDelete) async {

    Map messageCardData = messageCardToDelete.toJson();

    List messageCardList = [messageCardData];

    await firestoreInstance.collection(USERS_COLLECTION).doc(firebaseUser.uid).update({

      FIRST_ADDITIONAL_MESSAGES_FIELD : FieldValue.arrayRemove(messageCardList)

    });
  }

  @override
  void deletePersonalMessage(auth.User firebaseUser, MessageCard messageCardToDelete) async {

    Map messageCardData = messageCardToDelete.toJson();

    List messageCardList = [messageCardData];

    await firestoreInstance.collection(USERS_COLLECTION).doc(firebaseUser.uid).update({

      PERSONAL_MESSAGES_FIELD : FieldValue.arrayRemove(messageCardList)

    });
  }

  @override
  void deleteSecondAdditionalMessage(auth.User firebaseUser, MessageCard messageCardToDelete) async {

    Map messageCardData = messageCardToDelete.toJson();

    List messageCardList = [messageCardData];

    await firestoreInstance.collection(USERS_COLLECTION).doc(firebaseUser.uid).update({

      SECOND_ADDITIONAL_MESSAGES_FIELD : FieldValue.arrayRemove(messageCardList)

    });
  }

  @override
  void deleteSocialMessage(auth.User firebaseUser, MessageCard messageCardToDelete) async {

    Map messageCardData = messageCardToDelete.toJson();

    List messageCardList = [messageCardData];

    await firestoreInstance.collection(USERS_COLLECTION).doc(firebaseUser.uid).update({

      SOCIAL_MESSAGES_FIELD : FieldValue.arrayRemove(messageCardList)

    });
  }

  @override
  void editBusinessMessage(auth.User firebaseUser, MessageCard oldMessageCard, MessageCard newMessageCard) async {

    /// Delete the oldMessageCard first
    Map oldMessageCardData = oldMessageCard.toJson();

    List oldMessageCardList = [oldMessageCardData];

    await firestoreInstance.collection(USERS_COLLECTION).doc(firebaseUser.uid).update({

      BUSINESS_MESSAGES_FIELD : FieldValue.arrayRemove(oldMessageCardList)

    });

    /// Then add the newMessageCard
    Map newMessageCardData = newMessageCard.toJson();

    List newMessageCardList = [newMessageCardData];

    await firestoreInstance.collection(USERS_COLLECTION).doc(firebaseUser.uid).update({

      BUSINESS_MESSAGES_FIELD : FieldValue.arrayUnion(newMessageCardList)

    });
  }

  @override
  void editFirstAdditionalMessage(auth.User firebaseUser, MessageCard oldMessageCard, MessageCard newMessageCard) async {

    /// Delete the oldMessageCard first
    Map oldMessageCardData = oldMessageCard.toJson();

    List oldMessageCardList = [oldMessageCardData];

    await firestoreInstance.collection(USERS_COLLECTION).doc(firebaseUser.uid).update({

      FIRST_ADDITIONAL_MESSAGES_FIELD : FieldValue.arrayRemove(oldMessageCardList)

    });

    /// Then add the newMessageCard
    Map newMessageCardData = newMessageCard.toJson();

    List newMessageCardList = [newMessageCardData];

    await firestoreInstance.collection(USERS_COLLECTION).doc(firebaseUser.uid).update({

      FIRST_ADDITIONAL_MESSAGES_FIELD : FieldValue.arrayUnion(newMessageCardList)

    });
  }

  @override
  void editPersonalMessage(auth.User firebaseUser, MessageCard oldMessageCard, MessageCard newMessageCard) async {

    /// Delete the oldMessageCard first
    Map oldMessageCardData = oldMessageCard.toJson();

    List oldMessageCardList = [oldMessageCardData];

    await firestoreInstance.collection(USERS_COLLECTION).doc(firebaseUser.uid).update({

      PERSONAL_MESSAGES_FIELD : FieldValue.arrayRemove(oldMessageCardList)

    });

    /// Then add the newMessageCard
    Map newMessageCardData = newMessageCard.toJson();

    List newMessageCardList = [newMessageCardData];

    await firestoreInstance.collection(USERS_COLLECTION).doc(firebaseUser.uid).update({

      PERSONAL_MESSAGES_FIELD : FieldValue.arrayUnion(newMessageCardList)

    });

  }

  @override
  void editSecondAdditionalMessage(auth.User firebaseUser, MessageCard oldMessageCard, MessageCard newMessageCard) async {

    /// Delete the oldMessageCard first
    Map oldMessageCardData = oldMessageCard.toJson();

    List oldMessageCardList = [oldMessageCardData];

    await firestoreInstance.collection(USERS_COLLECTION).doc(firebaseUser.uid).update({

      SECOND_ADDITIONAL_MESSAGES_FIELD : FieldValue.arrayRemove(oldMessageCardList)

    });

    /// Then add the newMessageCard
    Map newMessageCardData = newMessageCard.toJson();

    List newMessageCardList = [newMessageCardData];

    await firestoreInstance.collection(USERS_COLLECTION).doc(firebaseUser.uid).update({

      SECOND_ADDITIONAL_MESSAGES_FIELD : FieldValue.arrayUnion(newMessageCardList)

    });
  }

  @override
  void editSocialMessage(auth.User firebaseUser, MessageCard oldMessageCard, MessageCard newMessageCard) async {
    /// Delete the oldMessageCard first
    Map oldMessageCardData = oldMessageCard.toJson();

    List oldMessageCardList = [oldMessageCardData];

    await firestoreInstance.collection(USERS_COLLECTION).doc(firebaseUser.uid).update({

      SOCIAL_MESSAGES_FIELD : FieldValue.arrayRemove(oldMessageCardList)

    });

    /// Then add the newMessageCard
    Map newMessageCardData = newMessageCard.toJson();

    List newMessageCardList = [newMessageCardData];

    await firestoreInstance.collection(USERS_COLLECTION).doc(firebaseUser.uid).update({

      SOCIAL_MESSAGES_FIELD : FieldValue.arrayUnion(newMessageCardList)

    });
  }










}