import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:reply_flutter/core/data/model/MessageCard.dart';
import 'package:reply_flutter/core/data/repository/firebase_repository.dart';

class PersonalMessagesViewModel with ChangeNotifier {


  PersonalMessagesViewModel();

  List<MessageCard> _personalMessagesList = [];
  FirebaseRepository firebaseRepository = FirebaseRepository();



  void loadPersonalMessagesList(FirebaseUser firebaseUser) async {

    _personalMessagesList = await firebaseRepository.getPersonalMessages(firebaseUser);

    notifyListeners();

  }

  Future<void> addPersonalMessage(FirebaseUser firebaseUser, MessageCard messageCardToAdd) async {

    await firebaseRepository.addPersonalMessage(firebaseUser, messageCardToAdd);

    notifyListeners();
  }

  int getPersonalMessagesListLength() {

    return _personalMessagesList.length;

  }

  List<MessageCard> get personalMessagesList => _personalMessagesList;

}