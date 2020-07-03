import 'package:firebase_auth/firebase_auth.dart';
import 'package:reply_flutter/core/data/model/MessageCard.dart';

abstract class RepositoryInterface {

  /// CREATE

  void createUserInDatabaseWithEmail(FirebaseUser user);

  void createUserInDatabaseWithGoogleProvider(FirebaseUser user);

  /// GET

  Future<List<MessageCard>> getPersonalMessages(FirebaseUser user);

  Future<List<MessageCard>> getSocialMessages(FirebaseUser user);

  Future<List<MessageCard>> getBusinessMessages(FirebaseUser user);

  Future<List<MessageCard>> getFirstAdditionalMessages(FirebaseUser user);

  Future<List<MessageCard>> getSecondAdditionalMessages(FirebaseUser user);

  Future<MessageCard> getReplyLaterMessage(FirebaseUser user);

  /// ADD
  void addPersonalMessage(FirebaseUser user, MessageCard messageCardToAdd);

  void addSocialMessage(FirebaseUser user, MessageCard messageCardToAdd);

  void addBusinessMessage(FirebaseUser user, MessageCard messageCardToAdd);

  void addFirstAdditionalMessage(FirebaseUser user, MessageCard messageCardToAdd);

  void addSecondAdditionalMessage(FirebaseUser user, MessageCard messageCardToAdd);

  /// EDIT
  void editPersonalMessage(FirebaseUser user, MessageCard oldMessageCard, MessageCard newMessageCard);

  void editSocialMessage(FirebaseUser user, MessageCard oldMessageCard, MessageCard newMessageCard);

  void editBusinessMessage(FirebaseUser user, MessageCard oldMessageCard, MessageCard newMessageCard);

  void editFirstAdditionalMessage(FirebaseUser user, MessageCard oldMessageCard, MessageCard newMessageCard);

  void editSecondAdditionalMessage(FirebaseUser user, MessageCard oldMessageCard, MessageCard newMessageCard);

  /// DELETE
  void deletePersonalMessage(FirebaseUser user, MessageCard messageCardToDelete);

  void deleteSocialMessage(FirebaseUser user, MessageCard messageCardToDelete);

  void deleteBusinessMessage(FirebaseUser user, MessageCard messageCardToDelete);

  void deleteFirstAdditionalMessage(FirebaseUser user, MessageCard messageCardToDelete);

  void deleteSecondAdditionalMessage(FirebaseUser user, MessageCard messageCardToDelete);











}