import 'package:flutter/cupertino.dart';
import 'package:reply_flutter/core/data/model/MessageCard.dart';

class PersonalMessagesViewModel with ChangeNotifier {

  List<MessageCard> _personalMessages = [MessageCard(cardTitle: 'Welcome!', cardMessage: 'Write your own message')];

  List<MessageCard> get personalMessages => _personalMessages;

  void addPersonalMessage(MessageCard messageCard) {
    _personalMessages.add(messageCard);
    notifyListeners();
  }

}