import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Model/Ingredient.dart';
import 'package:recipe_app/Model/Procedure.dart';
import 'package:recipe_app/Model/Recipe.dart';
import 'package:recipe_app/Repository/RecipeRepo.dart';

class AddRecipeProvider extends ChangeNotifier 
{
  List<Ingredient> ingredientsList = [];
  List<Procedure> procedureList = [];
  int selectedPage = 0;
  ScrollController scrollController = ScrollController();
  RecipeRepository recipeRepository = RecipeRepository();
  bool loading = false;
  
  switchPage(int val){
    selectedPage = val;
    scrollController.jumpTo(0);
    notifyListeners();
  }

  toggleLoader()
  {
    loading = !loading;
    notifyListeners();
  }

  addIngredient(Ingredient ingredient) async
  {
    ingredientsList.add(ingredient);
    notifyListeners();
  }

  addProcedure(Procedure procedure)
  {
    procedureList.add(procedure);
    notifyListeners();
  }

  Future<Either<String, String>> addRecipe(Recipe recipe) async
  {
    toggleLoader();
    Either<String, String> res = await recipeRepository.addRecipe(recipe);
    toggleLoader();
    return  res;
  } 

  getRecipe() async
  { await recipeRepository.getRecipes();
  }
}