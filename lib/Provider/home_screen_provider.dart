import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Constants/utility.dart';
import 'package:recipe_app/Model/Recipe.dart';
import 'package:recipe_app/Model/User.dart';
import 'package:recipe_app/Repository/RecipeRepo.dart';
import 'package:recipe_app/Repository/UserProfile.dart';

class HomeScreenProvider extends ChangeNotifier {
  User? me;
  RecipeRepository recipeRepository = RecipeRepository();
  List<Recipe> newRecipes = [];
  List<Recipe> viewedRecipes = [];
  List<User> allChefsDetails = [];
  bool success = false;
  String msg = '';
  int selectedCAtegory = 0;
  UserProfile userProfileRepository = UserProfile();
  List<Recipe> listOfRecipes = [];
  List<Recipe> myChefsRecipe = [];

  updateView(Recipe recipe) {
    newRecipes.remove(recipe);
    viewedRecipes.add(recipe);
    me!.viewedRecipes.add(recipe.id);
    notifyListeners();
  }

  Future<void> addToViewRecipe() async {
    String myUid = await getUserId();
    await userProfileRepository.updateViewRecipeList(myUid, me!.viewedRecipes);
  }

  Future<void> fetchRecipes(String myUid) async {
    Either<String, List<Recipe>> resRecipe =
        await recipeRepository.getAllRecipes();

    allChefsDetails = await userProfileRepository.getAllUsers();
    
    int myIndex = allChefsDetails.indexWhere((c)=>c.id == myUid);
    me = allChefsDetails[myIndex];


    resRecipe.fold(ifLeft: (value) {
      success = false;
      msg = value;
      throw value;
    }, ifRight: (list) {
      listOfRecipes.clear();

      listOfRecipes.addAll(list.where((r) => r.chefId != myUid));
      updateRecipeBasedOnCategory();
      success = true;
    });
    notifyListeners();
  }

  updateRecipeBasedOnCategory() {
    viewedRecipes.clear();
    newRecipes.clear();
    myChefsRecipe.clear();
    if (selectedCAtegory == 0) {
      viewedRecipes
          .addAll(listOfRecipes.where((r) => me!.viewedRecipes.contains(r.id)));
      newRecipes.addAll(
          listOfRecipes.where((r) => !me!.viewedRecipes.contains(r.id)));
    } else {
      viewedRecipes.addAll(listOfRecipes.where((r) =>
          me!.viewedRecipes.contains(r.id) &&
          r.categoryId == selectedCAtegory - 1));
      newRecipes.addAll(listOfRecipes.where((r) =>
          !me!.viewedRecipes.contains(r.id) &&
          r.categoryId == selectedCAtegory - 1));
    }
          myChefsRecipe.addAll(viewedRecipes.where((recipe) {
            return me!.following.contains(recipe.chefId);
            }));
    notifyListeners();
  }

  changeCategory(int val) {
    selectedCAtegory = val;
    notifyListeners();
  }
}
