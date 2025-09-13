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

  Future<Either<String, String>> addRecipe(Recipe recipe, File recipeImg) async
  {
    File imgToUpload = recipeImg;
    toggleLoader();

    
    Either<String, String> res = await recipeRepository.addRecipe(recipe);
    res.fold(ifLeft: (value){},ifRight: (recipeId)async{
      recipe.id = recipeId;
    await uploadRecipePic(recipe, imgToUpload);
    });
    toggleLoader();
    return  res;
  } 

  uploadRecipePic(Recipe recipe, File file)async
  {
    FileService fileService = FileService(RECIPE_IMAGE_DIR, recipe.id); 
    String publicUrl = await fileService.uploadFile(file)??'';
    recipe.imgUrl = publicUrl;
    await recipeRepository.updateRecipe(recipe);
  }

  getRecipe() async
  { await recipeRepository.getRecipes();
  }
}