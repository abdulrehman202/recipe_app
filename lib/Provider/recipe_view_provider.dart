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
  User? user;
  String myId = '';

  RecipeViewProvider(){
  scrollController.addListener((){scrollPosition = scrollController.position.pixels;});
}
  Future<void> fetchUser(String uid) async {
    myId = await Constants.getUserId();
    Either<String, User> res = await userProfile.fetchUser(uid);
    res.fold(ifLeft: (value) 
    {
      success = false;
      msg = value;
      throw value;
    } , ifRight: (value){
   success = true;
      user = value;
    });
    notifyListeners();
  }

  changePage(val)
  {
    selectedPage = val;
    notifyListeners();
  }

  toggleLoader() {
    loading = !loading;
    notifyListeners();
  }
}
