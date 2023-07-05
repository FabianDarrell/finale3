import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:finale3/constants/constants.dart';
import 'package:finale3/core/core.dart';
import 'package:finale3/core/provider.dart';
import 'package:finale3/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final userAPIProvider = Provider((ref) {
  return UserAPI(db : ref.watch(appwriteDatabaseProvider),);
});

abstract class IUserAPI {
  FutureEitherVoid saveUserData(UserModel userModel);
  Future<model.Document> getUserData(String uid);
}

class UserAPI implements IUserAPI {
  final Databases _db;
  UserAPI({required Databases db}) : _db = db;
  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
      await _db.createDocument(
        databaseId: AppwriteConstants.databaseId, 
        collectionId: AppwriteConstants.usersCollection, 
        documentId: userModel.uid, 
        data: userModel.toMap(),
        );
        return right(null);
    } on AppwriteException catch (e,stackTrace) {
      return left(Failure(e.message??'Some unexpected eerror occured',stackTrace),);
    }catch (e,stackTrace) {
        return left(Failure(e.toString(), stackTrace),);
    }
  }
  
  @override
  Future<model.Document> getUserData(String uid) {
    return _db.getDocument(databaseId: AppwriteConstants.databaseId, collectionId: AppwriteConstants.usersCollection, documentId: uid);
  }
}