class User {

  String name;
  int uID;
  List<String> personalMessages;
  List<String> socialMessages;
  List<String> businessMessages;
  List<String> firstAdditionalMessages;
  List<String> secondAdditionalMessages;


  User({this.name, this.uID, this.personalMessages, this.socialMessages,
    this.businessMessages, this.firstAdditionalMessages, this.secondAdditionalMessages});

  User.empty();

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        uID = json['uID'],
        personalMessages = json['personalMessages'],
        socialMessages = json['socialMessages'],
        businessMessages = json['businessMessages'],
        firstAdditionalMessages = json['plus1Messages'],
        secondAdditionalMessages = json['plus2Messages']
  ;

  // Need toJson method to serialize the data for the MessageCard so it can be accepted to be stored in Cloud firestore
  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'uID': uID,
        'personalMessages': personalMessages,
        'socialMessages': socialMessages,
        'businessMessages': businessMessages,
        'firstAdditionalMessages': firstAdditionalMessages,
        'secondAdditionalMessages': secondAdditionalMessages
      };
}