import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:reply_flutter/core/data/model/MessageCard.dart';
import 'package:reply_flutter/core/data/repository/firebase_repository.dart';

class BusinessMessagesViewModel with ChangeNotifier {


  BusinessMessagesViewModel();

  List<MessageCard> _businessMessagesList = [];
  FirebaseRepository _firebaseRepository = FirebaseRepository();




  void loadBusinessMessagesList(auth.User firebaseUser) async {

    _businessMessagesList = await _firebaseRepository.getBusinessMessages(firebaseUser);

    notifyListeners();

  }

  void addBusinessMessage(auth.User firebaseUser, MessageCard messageCardToAdd) async {

    _firebaseRepository.addBusinessMessage(firebaseUser, messageCardToAdd);

    notifyListeners();
  }

  int getBusinessMessagesListLength() {

    return _businessMessagesList.length;

  }

  void deleteBusinessMessage(auth.User firebaseUser, MessageCard messageCardToDelete) async {

    _firebaseRepository.deleteBusinessMessage(firebaseUser, messageCardToDelete);

    notifyListeners();

  }

  void editBusinessMessage(auth.User firebaseUser, MessageCard oldMessageCard, MessageCard newMessageCard) async {

    _firebaseRepository.editBusinessMessage(firebaseUser, oldMessageCard, newMessageCard);

    notifyListeners();

  }

  List<MessageCard> get businessMessagesList => _businessMessagesList;
}