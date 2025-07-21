import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Model/Recipe.dart';
import 'package:recipe_app/Repository/UserProfile.dart';
import 'package:recipe_app/Repository/RecipeRepo.dart';

import '../Model/User.dart';

class UserProfileProvider extends ChangeNotifier {
  bool loading = false;
  bool success = false;
  UserProfile userProfile = UserProfile();
  String msg = '';
  int selectedPage = 0;
  ScrollController scrollController = ScrollController();
  double scrollPosition = 0.0;
  String name = '';
  String bio = '';
  List<Recipe> listOfRecipes = [];
  RecipeRepository recipeRepository = RecipeRepository();

  UserProfileProvider(){
    listOfRecipes.clear();
  scrollController.addListener((){scrollPosition = scrollController.position.pixels;});
}
  Future<void> fetchUser(String uid) async {
    
    Either<String, User> res = await userProfile.fetchUser(uid);
    Either<String, List<Recipe>> resRecipe = await recipeRepository.getRecipes();
    res.fold(ifLeft: (value) 
    {
      success = false;
      msg = value;
      throw value;
    } , ifRight: (value){
    resRecipe.fold(ifLeft: (value) 
    {
      success = false;
      msg = value;
      throw value;
    }, ifRight: (list){
      listOfRecipes.clear();
      listOfRecipes.addAll(list);
      success = true;
      name = value.name;
      bio = value.bio;
      });
    });
    notifyListeners();
  }

  changePage(val)
  {
    selectedPage = val;
    notifyListeners();
  }

  toggleLoader() {
    loading = !loading;
    notifyListeners();
  }
}
