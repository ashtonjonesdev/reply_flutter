import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:reply_flutter/core/data/model/MessageCard.dart';
import 'package:reply_flutter/core/data/repository/firebase_repository.dart';

class PersonalMessagesViewModel with ChangeNotifier {


  PersonalMessagesViewModel();

  List<MessageCard> _personalMessagesList = [];
  FirebaseRepository _firebaseRepository = FirebaseRepository();




  void loadPersonalMessagesList(auth.User firebaseUser) async {

    _personalMessagesList = await _firebaseRepository.getPersonalMessages(firebaseUser);

    notifyListeners();

  }

  void addPersonalMessage(auth.User firebaseUser, MessageCard messageCardToAdd) async {

    _firebaseRepository.addPersonalMessage(firebaseUser, messageCardToAdd);

    notifyListeners();
  }

  int getPersonalMessagesListLength() {

    return _personalMessagesList.length;

  }

  void deletePersonalMessage(auth.User firebaseUser, MessageCard messageCardToDelete) async {

    _firebaseRepository.deletePersonalMessage(firebaseUser, messageCardToDelete);

    notifyListeners();

  }

  void editPersonalMessage(auth.User firebaseUser, MessageCard oldMessageCard, MessageCard newMessageCard) async {

    _firebaseRepository.editPersonalMessage(firebaseUser, oldMessageCard, newMessageCard);

    notifyListeners();

  }

  void addReplyLaterMessage(auth.User firebaseUser, MessageCard replyLaterMessageCard) async {

    _firebaseRepository.addReplyLaterMessage(firebaseUser, replyLaterMessageCard);

  }

  Future<MessageCard> getReplyLaterMessage(auth.User firebaseUser) async {

    MessageCard replyLaterMessage = await _firebaseRepository.getReplyLaterMessage(firebaseUser);

    return replyLaterMessage;

  }


    List<MessageCard> get personalMessagesList => _personalMessagesList;

}