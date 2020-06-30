import 'package:flutter/material.dart';
import 'package:reply_flutter/core/data/model/MessageCard.dart';

class SecondAdditionalMessagesViewModel with ChangeNotifier {

  List<MessageCard> _secondAdditionalMessages = [MessageCard(title: 'Welcome!', message: 'Write your own message')];

  List<MessageCard> get secondAdditionalMessages => _secondAdditionalMessages;

  void addSecondAdditionalMessage(MessageCard messageCard) {
    _secondAdditionalMessages.add(messageCard);
    notifyListeners();
  }

}