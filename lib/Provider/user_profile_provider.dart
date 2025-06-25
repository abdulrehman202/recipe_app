import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Repository/UserProfile.dart';

import '../Model/User.dart';

class UserProfileProvider extends ChangeNotifier {
  bool loading = false;
  bool success = false;
  UserProfile userProfile = UserProfile();
  String msg = '';
  int selectedPage = 0;
  ScrollController scrollController = ScrollController();
  double scrollPosition = 0.0;
  String name = '';
  String bio = '';

  UserProfileProvider(){

  scrollController.addListener((){scrollPosition = scrollController.position.pixels;});
}
  Future<void> fetchUser(String uid) async {
    toggleLoader();
    notifyListeners();
    Either<String, User> res = await userProfile.fetchUser(uid);
    res.fold(ifLeft: (value) 
    {
      success = false;
      msg = value;
      throw value;
    } , ifRight: (value)
    {
      success = true;
      name = value.name;
      bio = value.bio;
    });
    toggleLoader();
    notifyListeners();
    return;
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
