import 'package:recipe_app/View/all_libs.dart';

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

      listOfRecipes.addAll(list.where((r)=>me!.savedRecipes.contains(r.id) ));
      success = true;
      });
    notifyListeners();
  }
}