import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Model/Review.dart';
import 'package:recipe_app/Repository/ReviewRepo.dart';

class ReviewProvider extends ChangeNotifier 
{
  List<Review> reviewsList = [];
  bool loading = false;
  ReviewRepository reviewRepository = ReviewRepository();
  bool success = false;
  
  addReviewToList(Review review)
  {
    reviewsList.add(review);
    notifyListeners();
  }
  

  toggleLoader()
  {
    loading = !loading;
    notifyListeners();
  }

  Future<Either<bool, bool>> addReview(Review review) async
  {
    toggleLoader();
    Either<bool, bool> res = await reviewRepository.addReview(review);
    res.fold(ifLeft: (no)
    {
      success = false;
    }, ifRight: (ok)
    {
      addReviewToList(review);
      reviewsList.sort((a,b)=>b.time.compareTo(a.time));
      success = true;
      });
    toggleLoader();
    return  res;
  } 

  getReviews(String recipeId) async
  {
    Either<String, List<Review>> res = await reviewRepository.getReviews(recipeId);
    res.fold(ifLeft: (ifLeft){}, ifRight: (list)
    {
      reviewsList.clear();
      reviewsList.addAll(list);
      reviewsList.sort((a,b)=>b.time.compareTo(a.time));
    });
  }
}