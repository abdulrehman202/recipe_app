import 'package:flutter/material.dart';
import 'package:recipe_app/Model/Ingredient.dart';
import 'package:recipe_app/Model/Procedure.dart';

class AddRecipeProvider extends ChangeNotifier 
{
  List<Ingredient> ingredientsList = [];
  List<Procedure> procedureList = [];
  int selectedPage = 0;
  ScrollController scrollController = ScrollController();
  
  switchPage(int val){
    selectedPage = val;
    scrollController.jumpTo(0);
    notifyListeners();
  }

  addIngredient(Ingredient ingredient)
  {
    ingredientsList.add(ingredient);
    notifyListeners();
  }

  addProcedure(Procedure procedure)
  {
    procedureList.add(procedure);
    notifyListeners();
  }
}