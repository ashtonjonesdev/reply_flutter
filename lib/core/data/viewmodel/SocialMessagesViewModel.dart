import 'package:flutter/material.dart';
import 'package:reply_flutter/core/data/model/MessageCard.dart';

class SocialMessagesViewModel with ChangeNotifier {

  List<MessageCard> _socialMessages = [MessageCard(cardTitle: 'Welcome!', cardMessage: 'Write your own message')];

  List<MessageCard> get socialMessages => _socialMessages;

  void addSocialMessage(MessageCard messageCard) {
    _socialMessages.add(messageCard);
    notifyListeners();
  }

}