import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:reply_flutter/core/data/model/MessageCard.dart';
import 'package:reply_flutter/core/data/repository/firebase_repository.dart';

class SecondAdditionalMessagesViewModel with ChangeNotifier {


  SecondAdditionalMessagesViewModel();

  List<MessageCard> _secondAdditionalMessagesList = [];
  FirebaseRepository _firebaseRepository = FirebaseRepository();




  void loadSecondAdditionalMessagesList(auth.User firebaseUser) async {

    _secondAdditionalMessagesList = await _firebaseRepository.getSecondAdditionalMessages(firebaseUser);

    notifyListeners();

  }

  void addSecondAdditionalMessage(auth.User firebaseUser, MessageCard messageCardToAdd) async {

    _firebaseRepository.addSecondAdditionalMessage(firebaseUser, messageCardToAdd);

    notifyListeners();
  }

  int getSecondAdditionalMessagesListLength() {

    return _secondAdditionalMessagesList.length;

  }

  void deleteSecondAdditionalMessage(auth.User firebaseUser, MessageCard messageCardToDelete) async {

    _firebaseRepository.deleteSecondAdditionalMessage(firebaseUser, messageCardToDelete);

    notifyListeners();

  }

  void editSecondAdditionalMessage(auth.User firebaseUser, MessageCard oldMessageCard, MessageCard newMessageCard) async {

    _firebaseRepository.editSecondAdditionalMessage(firebaseUser, oldMessageCard, newMessageCard);

    notifyListeners();

  }

  List<MessageCard> get secondAdditionalMessagesList =>
      _secondAdditionalMessagesList;
}