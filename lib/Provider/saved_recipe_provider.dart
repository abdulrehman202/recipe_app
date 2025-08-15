import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Model/Recipe.dart';
import 'package:recipe_app/Model/User.dart';
import 'package:recipe_app/Repository/RecipeRepo.dart';
import 'package:recipe_app/Repository/UserProfile.dart';

class SavedRecipeProvider extends ChangeNotifier{

  User? me;
  RecipeRepository recipeRepository = RecipeRepository();
  bool success = false;
  String msg = '';
  UserProfile userProfileRepository = UserProfile();
  List<Recipe> listOfRecipes = [];

  Future<void> fetchRecipes(String myUid) async {
    
    Either<String, List<Recipe>> resRecipe = await recipeRepository.getAllRecipes();
    Either<String, User> getMyDetails = await userProfileRepository.fetchUser(myUid);

    resRecipe.fold(ifLeft: (value) 
    {
      success = false;
      msg = value;
      throw value;
    }, ifRight: (list){
      
      getMyDetails.fold(ifLeft: (ifLeft){}, ifRight: (user) => me = user);
      listOfRecipes.clear();

      listOfRecipes.addAll(list.where((r)=>r.chefId!=myUid && me!.savedRecipes.contains(r.id) ));
      success = true;
      });
    notifyListeners();
  }
}