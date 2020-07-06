import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:reply_flutter/core/data/model/MessageCard.dart';
import 'package:reply_flutter/core/data/repository/firebase_repository.dart';

class BusinessMessagesViewModel with ChangeNotifier {


  BusinessMessagesViewModel();

  List<MessageCard> _businessMessagesList = [];
  FirebaseRepository _firebaseRepository = FirebaseRepository();




  void loadBusinessMessagesList(FirebaseUser firebaseUser) async {

    _businessMessagesList = await _firebaseRepository.getBusinessMessages(firebaseUser);

    notifyListeners();

  }

  void addBusinessMessage(FirebaseUser firebaseUser, MessageCard messageCardToAdd) async {

    _firebaseRepository.addBusinessMessage(firebaseUser, messageCardToAdd);

    notifyListeners();
  }

  int getBusinessMessagesListLength() {

    return _businessMessagesList.length;

  }

  void deleteBusinessMessage(FirebaseUser firebaseUser, MessageCard messageCardToDelete) async {

    _firebaseRepository.deleteBusinessMessage(firebaseUser, messageCardToDelete);

    notifyListeners();

  }

  void editBusinessMessage(FirebaseUser firebaseUser, MessageCard oldMessageCard, MessageCard newMessageCard) async {

    _firebaseRepository.editBusinessMessage(firebaseUser, oldMessageCard, newMessageCard);

    notifyListeners();

  }

  List<MessageCard> get businessMessagesList => _businessMessagesList;
}