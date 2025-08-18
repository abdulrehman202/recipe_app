import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_either/dart_either.dart';
import 'package:recipe_app/Model/Review.dart';

class ReviewRepository {
  String collectionName = 'Reviews';
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<Either<bool, bool>> addReview(Review review) async {
    try {
      var res = await db.collection(collectionName).add(review.toJson());
      String rId = res.id;
      await db.collection(collectionName).doc(rId).update({'id': rId});
      return const Right(true);
    } on FirebaseException catch (_) {
      return const Left(false);
    }
  }

  Future<Either<String, List<Review>>> getReviews(String recipeId) async {
    try {
      List<Review> reviewsList = [];
      QuerySnapshot<Map<String, dynamic>> res = await db
          .collection(collectionName)
          .where('recipeId', isEqualTo: recipeId)
          .get();

      for(int i = 0;i<res.docs.length;i++)
      {
        Review review =
            Review.fromJson(res.docs [i].data());
        reviewsList.add(review);
      }    
      return Right(reviewsList);
    } on FirebaseException catch (_) {
      return Left(_.message ?? 'Error!');
    }
  }
}
