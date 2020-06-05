class User {

  String name;
  int uID;
  List<String> personalMessages;
  List<String> socialMessages;
  List<String> businessMessages;
  List<String> plus1Messages;
  List<String> plus2Messages;

  User({this.name, this.uID, this.personalMessages, this.socialMessages,
    this.businessMessages, this.plus1Messages, this.plus2Messages});

  User.empty();

}