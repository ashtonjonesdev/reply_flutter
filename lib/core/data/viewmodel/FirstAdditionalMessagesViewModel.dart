import 'package:flutter/material.dart';
import 'package:reply_flutter/core/data/model/MessageCard.dart';

class FirstAdditionalMessagesViewModel with ChangeNotifier {

  List<MessageCard> _firstAdditionalMessages = [MessageCard(cardTitle: 'Welcome!', cardMessage: 'Write your own message')];

  List<MessageCard> get firstAdditionalMessages => _firstAdditionalMessages;

  void addFirstAdditionalMessage(MessageCard messageCard) {
    _firstAdditionalMessages.add(messageCard);
    notifyListeners();
  }

}