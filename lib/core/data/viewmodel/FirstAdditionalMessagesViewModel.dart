import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:reply_flutter/core/data/model/MessageCard.dart';
import 'package:reply_flutter/core/data/repository/firebase_repository.dart';

class FirstAdditionalMessagesViewModel with ChangeNotifier {


  FirstAdditionalMessagesViewModel();

  List<MessageCard> _firstAdditionalMessagesList = [];
  FirebaseRepository _firebaseRepository = FirebaseRepository();




  void loadFirstAdditionalMessagesList(FirebaseUser firebaseUser) async {

    _firstAdditionalMessagesList = await _firebaseRepository.getFirstAdditionalMessages(firebaseUser);

    notifyListeners();

  }

  void addFirstAdditionalMessage(FirebaseUser firebaseUser, MessageCard messageCardToAdd) async {

    _firebaseRepository.addFirstAdditionalMessage(firebaseUser, messageCardToAdd);

    notifyListeners();
  }

  int getFirstAdditionalMessagesListLength() {

    return _firstAdditionalMessagesList.length;

  }

  void deleteFirstAdditionalMessage(FirebaseUser firebaseUser, MessageCard messageCardToDelete) async {

    _firebaseRepository.deleteFirstAdditionalMessage(firebaseUser, messageCardToDelete);

    notifyListeners();

  }

  void editFirstAdditionalMessage(FirebaseUser firebaseUser, MessageCard oldMessageCard, MessageCard newMessageCard) async {

    _firebaseRepository.editFirstAdditionalMessage(firebaseUser, oldMessageCard, newMessageCard);

    notifyListeners();

  }

  List<MessageCard> get firstAdditionalMessagesList =>
      _firstAdditionalMessagesList;
}