import 'package:reply_flutter/core/data/model/MessageCard.dart';

abstract class RepositoryInterface {

  /// CREATE

  void createUserInDatabaseWithEmail(var user);

  void createUserInDatabaseWithGoogleProvider(var user);

  /// GET

  Future<List<MessageCard>> getPersonalMessages(var user);

  Future<List<MessageCard>> getSocialMessages(var user);

  Future<List<MessageCard>> getBusinessMessages(var user);

  Future<List<MessageCard>> getFirstAdditionalMessages(var user);

  Future<List<MessageCard>> getSecondAdditionalMessages(var user);

  Future<MessageCard> getReplyLaterMessage(var user);

  /// ADD
  void addPersonalMessage(var user, MessageCard messageCardToAdd);

  void addSocialMessage(var user, MessageCard messageCardToAdd);

  void addBusinessMessage(var user, MessageCard messageCardToAdd);

  void addFirstAdditionalMessage(var user, MessageCard messageCardToAdd);

  void addSecondAdditionalMessage(var user, MessageCard messageCardToAdd);

  /// EDIT
  void editPersonalMessage(var user, MessageCard messageCardToEdit);

  void editSocialMessage(var user, MessageCard messageCardToEdit);

  void editBusinessMessage(var user, MessageCard messageCardToEdit);

  void editFirstAdditionalMessage(var user, MessageCard messageCardToEdit);

  void editSecondAdditionalMessage(var user, MessageCard messageCardToEdit);

  /// DELETE
  void deletePersonalMessage(var user, MessageCard messageCardToDelete);

  void deleteSocialMessage(var user, MessageCard messageCardToDelete);

  void deleteBusinessMessage(var user, MessageCard messageCardToDelete);

  void deleteFirstAdditionalMessage(var user, MessageCard messageCardToDelete);

  void deleteSecondAdditionalMessage(var user, MessageCard messageCardToDelete);











}