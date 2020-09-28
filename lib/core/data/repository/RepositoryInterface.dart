import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:reply_flutter/core/data/model/MessageCard.dart';

abstract class RepositoryInterface {

  /// CREATE

  void createUserInDatabaseWithEmail(auth.User user);

  void createUserInDatabaseWithGoogleProvider(auth.User user);

  void createUserInDatabaseWithAppleProvider(auth.User user);


  /// GET

  Future<List<MessageCard>> getPersonalMessages(auth.User user);

  Future<List<MessageCard>> getSocialMessages(auth.User user);

  Future<List<MessageCard>> getBusinessMessages(auth.User user);

  Future<List<MessageCard>> getFirstAdditionalMessages(auth.User user);

  Future<List<MessageCard>> getSecondAdditionalMessages(auth.User user);

  Future<MessageCard> getReplyLaterMessage(auth.User user);

  /// ADD
  void addPersonalMessage(auth.User user, MessageCard messageCardToAdd);

  void addSocialMessage(auth.User user, MessageCard messageCardToAdd);

  void addBusinessMessage(auth.User user, MessageCard messageCardToAdd);

  void addFirstAdditionalMessage(auth.User user, MessageCard messageCardToAdd);

  void addSecondAdditionalMessage(auth.User user, MessageCard messageCardToAdd);

  void addReplyLaterMessage(auth.User user, MessageCard replyLaterMessageCard);

  /// EDIT
  void editPersonalMessage(auth.User user, MessageCard oldMessageCard, MessageCard newMessageCard);

  void editSocialMessage(auth.User user, MessageCard oldMessageCard, MessageCard newMessageCard);

  void editBusinessMessage(auth.User user, MessageCard oldMessageCard, MessageCard newMessageCard);

  void editFirstAdditionalMessage(auth.User user, MessageCard oldMessageCard, MessageCard newMessageCard);

  void editSecondAdditionalMessage(auth.User user, MessageCard oldMessageCard, MessageCard newMessageCard);

  /// DELETE
  void deletePersonalMessage(auth.User user, MessageCard messageCardToDelete);

  void deleteSocialMessage(auth.User user, MessageCard messageCardToDelete);

  void deleteBusinessMessage(auth.User user, MessageCard messageCardToDelete);

  void deleteFirstAdditionalMessage(auth.User user, MessageCard messageCardToDelete);

  void deleteSecondAdditionalMessage(auth.User user, MessageCard messageCardToDelete);











}