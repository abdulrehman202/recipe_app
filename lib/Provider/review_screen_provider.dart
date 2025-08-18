import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Model/Review.dart';
import 'package:recipe_app/Model/User.dart';
import 'package:recipe_app/Repository/ReviewRepo.dart';
import 'package:recipe_app/Repository/UserProfile.dart';

class ReviewProvider extends ChangeNotifier 
{
  List<Review> reviewsList = [];
  bool loading = false;
  ReviewRepository reviewRepository = ReviewRepository();
  bool success = false;
  UserProfile userProfile = UserProfile();
  
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

  Future<String> getMyName()async
  {
    try{
      String uid = await Constants.getUserId();
      String name = '';
    Either<String, User> res = await userProfile.fetchUser(uid);

    res.fold(ifLeft: (ifLeft){name = 'Unknown';}, ifRight: (u) =>name=u.name);


    return name;
    }
    catch (e)
    {
      return 'Unknown';
    }
  }
}