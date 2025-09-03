import 'package:recipe_app/View/all_libs.dart';

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
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Error!');
    }
  }

  Future<void> updateReview(Review review) async {
    try {
      await db
          .collection(collectionName)
          .doc(review.id)
          .update(review.toJson());

     
    } on FirebaseException catch (_) {
    }
  }
}
