import 'package:recipe_app/View/all_libs.dart';

class LoginProvider extends ChangeNotifier {

  String msg = '';
  bool loading = false;
  UserAuth userAuth = UserAuth();

  toggleLoader()
  {
    loading = !loading;
  }

  bool checkValues(String email)
  {
    if( email.isValidEmail() )
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