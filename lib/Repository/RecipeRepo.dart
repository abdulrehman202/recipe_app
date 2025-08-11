import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_either/dart_either.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Model/Recipe.dart';

class RecipeRepository {
  String collectionName = 'Recipe';
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<Either<String, String>> addRecipe(Recipe recipe) async {
    try {
      var res = await db.collection(collectionName).add(recipe.toJson());
      String rId = res.id;
      await db.collection(collectionName).doc(rId).update({'id': rId});
      return const Right('Recipe added successfully');
    } on FirebaseException catch (_) {
      return Left(_.message ?? 'Error!');
    }
  }

  Future<Either<String, List<Recipe>>> getRecipes() async {
    try {
      List<Recipe> recipesList = [];
      String uid = await Constants.getUserId();
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
    } on FirebaseException catch (_) {
      return Left(_.message ?? 'Error!');
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
    } on FirebaseException catch (_) {
      return Left(_.message ?? 'Error!');
    }
  }
}
