import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Repository/UserProfile.dart';
import 'package:recipe_app/Model/User.dart';

class UserProfileSetupProvider extends ChangeNotifier {
  bool loading = false;
  bool success = false;
  UserProfile userProfile = UserProfile();
  String msg = '';
  
  Future<void> setUpUser(String name, bio, uid)async
  {
   toggleLoader();
   notifyListeners();
   
   User user = User('0',name, bio,[],[],[],[]);

   Either<String, String> res = await userProfile.setupUser(uid, user);
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