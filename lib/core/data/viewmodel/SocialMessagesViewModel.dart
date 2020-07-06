import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:reply_flutter/core/data/model/MessageCard.dart';
import 'package:reply_flutter/core/data/repository/firebase_repository.dart';

class SocialMessagesViewModel with ChangeNotifier {


  SocialMessagesViewModel();

  List<MessageCard> _socialMessagesList = [];
  FirebaseRepository _firebaseRepository = FirebaseRepository();




  void loadSocialMessagesList(FirebaseUser firebaseUser) async {

    _socialMessagesList = await _firebaseRepository.getSocialMessages(firebaseUser);

    notifyListeners();

  }

  void addSocialMessage(FirebaseUser firebaseUser, MessageCard messageCardToAdd) async {

    _firebaseRepository.addSocialMessage(firebaseUser, messageCardToAdd);

    notifyListeners();
  }

  int getSocialMessagesListLength() {

    return _socialMessagesList.length;

  }

  void deleteSocialMessage(FirebaseUser firebaseUser, MessageCard messageCardToDelete) async {

    _firebaseRepository.deleteSocialMessage(firebaseUser, messageCardToDelete);

    notifyListeners();

  }

  void editSocialMessage(FirebaseUser firebaseUser, MessageCard oldMessageCard, MessageCard newMessageCard) async {

    _firebaseRepository.editSocialMessage(firebaseUser, oldMessageCard, newMessageCard);

    notifyListeners();

  }

  List<MessageCard> get socialMessagesList => _socialMessagesList;
}