import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Model/Recipe.dart';
import 'package:recipe_app/Model/User.dart';
import 'package:recipe_app/Repository/RecipeRepo.dart';
import 'package:recipe_app/Repository/UserProfile.dart';

class HomeScreenProvider extends ChangeNotifier{

  User? me;
  RecipeRepository recipeRepository = RecipeRepository();
  List<Recipe> newRecipes = [];
  List<Recipe> viewedRecipes = [];
  bool success = false;
  String msg = '';
  int selectedCAtegory = 0; 
  UserProfile userProfileRepository = UserProfile();
  
  Future<void> fetchRecipes() async {
    
    Either<String, List<Recipe>> resRecipe = await recipeRepository.getAllRecipes();
    String myUid = await Constants.getUserId();
    Either<String, User> getMyDetails = await userProfileRepository.fetchUser(myUid);

    resRecipe.fold(ifLeft: (value) 
    {
      success = false;
      msg = value;
      throw value;
    }, ifRight: (list){
      
      getMyDetails.fold(ifLeft: (ifLeft){}, ifRight: (user) => me = user);

      List<Recipe> listOfRecipes = [];
      listOfRecipes.addAll(list);
      viewedRecipes.addAll(listOfRecipes);
      newRecipes.addAll(listOfRecipes);//.where((r)=>r.chefId != myUid));
      success = true;
      });
    notifyListeners();
  }

  changeCategory(int val)
  {
    selectedCAtegory = val;
    notifyListeners();
  }
}