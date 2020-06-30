class MessageCard  {

  String title;
  String message;

  MessageCard({this.title, this.message});



  MessageCard.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        message = json['message'];

  // Need toJson method to serialize the data for the MessageCard so it can be accepted to be stored in Cloud firestore
  Map<String, dynamic> toJson() =>
      {
        'title': title,
        'message': message,
      };

}