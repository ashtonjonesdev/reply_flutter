import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:reply_flutter/core/data/model/MessageCard.dart';
import 'package:reply_flutter/core/data/repository/firebase_repository.dart';

class PersonalMessagesViewModel with ChangeNotifier {


  PersonalMessagesViewModel();

  List<MessageCard> _personalMessagesList = [];
  FirebaseRepository _firebaseRepository = FirebaseRepository();



  void loadPersonalMessagesList(FirebaseUser firebaseUser) async {

    _personalMessagesList = await _firebaseRepository.getPersonalMessages(firebaseUser);

    notifyListeners();

  }

  void addPersonalMessage(FirebaseUser firebaseUser, MessageCard messageCardToAdd) async {

    _firebaseRepository.addPersonalMessage(firebaseUser, messageCardToAdd);

    notifyListeners();
  }

  int getPersonalMessagesListLength() {

    return _personalMessagesList.length;

  }

  void deletePersonalMessage(FirebaseUser firebaseUser, MessageCard messageCardToDelete) async {

    _firebaseRepository.deletePersonalMessage(firebaseUser, messageCardToDelete);

    notifyListeners();

  }


  List<MessageCard> get personalMessagesList => _personalMessagesList;

}