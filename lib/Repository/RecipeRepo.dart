import 'package:recipe_app/View/all_libs.dart';

class RecipeRepository {
  String collectionName = 'Recipe';
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<Either<String, String>> addRecipe(Recipe recipe) async {
    try {
      var res = await db.collection(collectionName).add(recipe.toJson());
      String rId = res.id;
      await db.collection(collectionName).doc(rId).update({'id': rId});
      return Right(rId);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Error!');
    }
  }

  Future<Either<String, String>> updateRecipe(Recipe recipe) async {
    try {
      await db.collection(collectionName).doc(recipe.id).update(recipe.toJson());
      return const Right('OK');
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Error!');
    }
  }

  

  Future<Either<String, String>> rateRecipe(Recipe recipe) async {
    try {
      await db.collection(collectionName).doc(recipe.id).update(recipe.toJson());
      return const Right('Recipe rated successfully');
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Error!');
    }
  }

  Future<Either<String, List<Recipe>>> getRecipes() async {
    try {
      List<Recipe> recipesList = [];
      String uid = await getUserId();
      QuerySnapshot<Map<String, dynamic>> res = await db
          .collection(collectionName)
          .where('chefId', isEqualTo: uid)
          .get();

      for(int i = 0;i<res.docs.length;i++)
      {
        Recipe recipe =
            Recipe.fromJson(res.docs [i].data());
        recipesList.add(recipe); 
      }    
      return Right(recipesList);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Error!');
    }
  }

  Future<Either<String, List<Recipe>>> getAllRecipes() async {
    try {
      List<Recipe> recipesList = [];
      QuerySnapshot<Map<String, dynamic>> res = await db
          .collection(collectionName)
          .get();

      for(int i = 0;i<res.docs.length;i++)
      {
        Recipe recipe =
            Recipe.fromJson(res.docs [i].data());
        recipesList.add(recipe);
      }    
      return Right(recipesList);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Error!');
    }
  }
}
