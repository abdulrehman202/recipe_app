import 'package:flutter/material.dart';
import 'package:recipe_app/Repository/UserProfile.dart';

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
    await userProfile.fetchUser(uid);
    toggleLoader();
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
