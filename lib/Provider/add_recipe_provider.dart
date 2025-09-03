import 'package:recipe_app/View/all_libs.dart';

class AddRecipeProvider extends ChangeNotifier 
{
  List<Ingredient> ingredientsList = [];
  List<Procedure> procedureList = [];
  int selectedPage = 0;
  ScrollController scrollController = ScrollController();
  RecipeRepository recipeRepository = RecipeRepository();
  bool loading = false;
  int catIndex = -1;
  
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

  changeCategory(int c)
  {
    catIndex = c;
    notifyListeners()
    ;
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