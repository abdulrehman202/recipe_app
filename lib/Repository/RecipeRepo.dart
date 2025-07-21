import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_either/dart_either.dart';
import 'package:recipe_app/Model/Recipe.dart';

class RecipeRepository{
  String collectionName= 'Recipe';
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<Either<String, String>> addRecipe(Recipe recipe) async {  
    try {
      var res = await db.collection(collectionName).add(recipe.toJson());
      String rId = res.id;
      await db.collection(collectionName).doc(rId).update({'id':rId});
      return const Right('Recipe added successfully');
    } on FirebaseException catch (_) {
      return Left(_.message ?? 'Error!');
    }
  }
}