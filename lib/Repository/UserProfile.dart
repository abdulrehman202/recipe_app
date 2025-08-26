import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_either/dart_either.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Model/User.dart';

class UserProfile {

  String collectionName= 'Users';
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<Either<String, String>> setupUser(String uid, User user) async { 
    try {
      user.id = uid;
      await db.collection(collectionName).doc(uid).set(user.toJson()); 
      return Right('ok');
    } on FirebaseException catch (_) {
      return Left(_.message ?? 'Error!');
    }
  }

  Future<Either<String, User>> fetchUser(String uid) async { 
    try {
      DocumentSnapshot documentSnapshot = await db.collection(collectionName).doc(uid).get();
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      User user = User.fromJson(data);
      return Right(user);
    } on FirebaseException catch (_) {
      return Left(_.message ?? 'Error!');
    }
  }

  Future<List<User>> getAllUsers() async { 
    try {
      List<User> usersList = [];
      QuerySnapshot<Map<String, dynamic>> res = await db
          .collection(collectionName)
          .get();

      for(int i = 0;i<res.docs.length;i++)
      {
        User user =
            User.fromJson(res.docs [i].data());
        usersList.add(user);
      }    
      return usersList;
    } on FirebaseException catch (_) {
      return [];
    }
  }
  
  Future<Either<String, String>> updateViewRecipeList(String uid, List<String> ids) async { 
    try {
      await db.collection(collectionName).doc(uid).update({'viewedRecipes':ids});
      return Right('ok');
    } on FirebaseException catch (_) {
      return Left(_.message ?? 'Error!');
    }


  }

  Future<List< String>> getMySavedRecipe() async { 
    try {
      List<String> list = [];
      String myId = await Constants.getUserId();
      DocumentSnapshot documentSnapshot =  await db.collection(collectionName).doc(myId).get();
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      User user = User.fromJson(data);
      list.addAll(user.savedRecipes);
      return list;
    } on FirebaseException catch (_) {
      return [];
    }

    
  }

  Future<void> updateSavedRecipeList(String uid, List<String>ids)
  async {
    try{
    await db.collection(collectionName).doc(uid).update({'savedRecipes':ids});
    }
    catch(e) {
    }
  }

  Future<void> updateFollowersList(String uid, List<String>ids)
  async {
    try{
    await db.collection(collectionName).doc(uid).update({'followers':ids});
    }
    catch(e) {
    }
  }

  Future<void> updateFollowingsList(String uid, List<String>ids)
  async {
    try{
    await db.collection(collectionName).doc(uid).update({'following':ids});
    }
    catch(e) {
    }
  }
}
