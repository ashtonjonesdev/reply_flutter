import 'package:flutter/material.dart';
import 'package:reply_flutter/core/data/model/MessageCard.dart';

class BusinessMessagesViewModel with ChangeNotifier {

  List<MessageCard> _businessMessages = [MessageCard(title: 'Welcome!', message: 'Write your own message')];

  List<MessageCard> get businessMessages => _businessMessages;

  void addBusinessMessage(MessageCard messageCard) {
    _businessMessages.add(messageCard);
    notifyListeners();
  }

}