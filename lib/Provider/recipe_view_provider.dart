import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Repository/UserProfile.dart';

import '../Model/User.dart';

class RecipeViewProvider extends ChangeNotifier {
  bool loading = false;
  bool success = false;
  UserProfile userProfile = UserProfile();
  String msg = '';
  int selectedPage = 0;
  ScrollController scrollController = ScrollController();
  double scrollPosition = 0.0;
  User? chef;
  User? me;
  String myId = '';
  List<String> mySavedRecipes = [];

  RecipeViewProvider() {
    scrollController.addListener(() {
      scrollPosition = scrollController.position.pixels;
    });
  }
  Future<void> fetchUser(String uid) async {
    Either<String, User> chefRes = await userProfile.fetchUser(uid);
    mySavedRecipes.clear();
    mySavedRecipes = await userProfile.getMySavedRecipe();

    myId = await Constants.getUserId();
    Either<String, User> meRes = await userProfile.fetchUser(myId);
    chefRes.fold(ifLeft: (value) {
      success = false;
      msg = value;
      throw value;
    }, ifRight: (value) {
      meRes.fold(ifLeft: (ifLeft) {}, ifRight: (myData) => me = myData);
      success = true;
      chef = value;
    });
    notifyListeners();
  }

  Future<void> updateSavedrecipes() async {
    try {
      await userProfile.updateSavedRecipeList(myId, mySavedRecipes);
    } catch (e) {}
  }

  followThisChef(String chefId) async {
    try {
      if (chef!.followers.contains(myId)) {
        chef!.followers.remove(myId);
        me!.following.remove(chefId);
      } else {
        chef!.followers.add(myId);
        me!.following.add(chefId);
      }
      notifyListeners();
      await userProfile.updateFollowersList(chefId, chef!.followers);
      await userProfile.updateFollowingsList(myId, me!.following);
    } catch (e) {}
  }

  addToSavedRecipeList(String id) {
    mySavedRecipes.add(id);
    notifyListeners();
  }

  removeFromSavedRecipeList(String id) {
    mySavedRecipes.remove(id);
    notifyListeners();
  }

  changePage(val) {
    selectedPage = val;
    notifyListeners();
  }

  toggleLoader() {
    loading = !loading;
    notifyListeners();
  }
}
