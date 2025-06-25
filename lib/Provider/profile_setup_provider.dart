import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Repository/UserAuth.dart';
import 'package:recipe_app/Repository/UserProfile.dart';

class UserProfileSetupProvider extends ChangeNotifier {
  bool loading = false;
  bool success = false;
  UserProfile userProfile = UserProfile();
  String msg = '';
  
  Future<void> setUpUser(String name, bio, uid)async
  {
   toggleLoader();
   notifyListeners();
   Either<String, String> res = await userProfile.setupUser(name, bio, uid);
   res.fold(ifLeft: (s){success=false;msg = s;}, ifRight: (s)=>success = true);
   toggleLoader();
   notifyListeners();
  }

  toggleLoader()
  {
    loading = !loading;
    notifyListeners();
      }

}