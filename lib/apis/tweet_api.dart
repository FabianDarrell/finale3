import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:finale3/constants/appwrite_constants.dart';
import 'package:finale3/core/core.dart';
import 'package:finale3/core/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../models/tweet_model.dart';

final tweetAPIProvider = Provider((ref) {
  return TweetAPI(
    db: ref.watch(
      appwriteDatabaseProvider,
    ),
  );
});

abstract class ITweetAPI {
  FutureEither<Document> shareTweet(Tweet tweet);
}

class TweetAPI implements ITweetAPI {
  final Databases _db;
  TweetAPI({required Databases db}) : _db = db;
  @override
  FutureEither<Document> shareTweet (Tweet tweet) async {
    try {
      final document = await _db.createDocument(
        databaseId: AppwriteConstants.databaseId, 
        collectionId: AppwriteConstants.usersCollection, 
        documentId: ID.unique(), 
        data: tweet.toMap(),
        );
        return right(document);
    } on AppwriteException catch (e,stackTrace) {
      return left(Failure(e.message??'Some unexpected eerror occured',stackTrace),);
    }catch (e,stackTrace) {
        return left(Failure(e.toString(), stackTrace),);
    }
  }
}