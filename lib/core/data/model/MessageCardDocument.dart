import 'package:reply_flutter/core/data/model/MessageCard.dart';

///
/// Was unable to use this approach because Flutter DocumentSnapshot class does not have the toObject method
///
/// A class to more easily get a list of MessageCards back from the DocumentSnapshot retrieved from Firebase call
/// Followed this article: https://medium.com/firebase-tips-tricks/how-to-map-an-array-of-objects-from-cloud-firestore-to-a-list-of-objects-122e579eae10


class MessageCardDocument {


  MessageCardDocument();

  List<MessageCard> messageCards;

}