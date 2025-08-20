import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Repository/UserAuth.dart';

class LoginProvider extends ChangeNotifier {

  String msg = '';
  bool loading = false;
  UserAuth userAuth = UserAuth();

  toggleLoader()
  {
    loading = !loading;
  }

  isEmailValid(String email)
  {
    return Constants.emailRegex.hasMatch(email);
  }

  bool checkValues(String email)
  {
    if(isEmailValid(email))
    {
      return true;
    }
    else{
      msg = 'Incorrect Email';
    }
    notifyListeners();
    return false;
  }
  
  Future<Either<String, String>> login(String email,String password)async
  {
    toggleLoader();
    notifyListeners();
        Either<String, String> res =  await userAuth.login(email, password);
    toggleLoader();
    notifyListeners();

    return res;
    
  }

  Future<Either<String, String>> resetPassword(String email,)async
  {
        Either<String, String> res =  await userAuth.resetPasswordEmail(email ,);

    return res;
    
  }

}