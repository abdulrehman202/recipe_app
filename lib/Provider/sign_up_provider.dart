import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Constants/utility.dart';
import 'package:recipe_app/Repository/UserAuth.dart';
class SignUpProvider extends ChangeNotifier {

  String msg = '';
  bool loading = false;
  bool termsAndConditionAccepted = false;
  UserAuth userAuth = UserAuth();

  toggleLoader()
  {
    loading = !loading;
  }
  toggleTermsAndCondition(bool value)
  {
    termsAndConditionAccepted = value;
    notifyListeners();
  }

  passwordConfirmed(String pwd1, String pwd2)
  {
    return pwd1 == pwd2;
  }

  bool checkValues(String email,String password, String confirmPassword)
  {
    if(email.isValidEmail())
    {
      if(passwordConfirmed(password, confirmPassword))
      {
        if(termsAndConditionAccepted)
        {
          return true;
        }
        else {
          msg = 'Please accept terms & condition';
        }
      }
      else {
        msg = 'Passwords do not match';
      }
    }
    else{
      msg = 'Incorrect Email';
    }
    notifyListeners();
    return false;
  }
  
  Future<Either<String, String>> registerUser(String email,String password, String confirmPassword)async
  {
    toggleLoader();
    notifyListeners();
        Either<String, String> res =  await userAuth.registerUser(email, password);
    toggleLoader();
    notifyListeners();

    return res;
    
  }

}