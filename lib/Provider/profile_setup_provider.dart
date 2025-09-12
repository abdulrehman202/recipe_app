import 'package:recipe_app/View/all_libs.dart';

class UserProfileSetupProvider extends ChangeNotifier {
  bool loading = false;
  bool success = false;
  UserProfile userProfile = UserProfile();
  String msg = '';
  
  Future<void> setUpUser(User user)async
  {
   toggleLoader();
   notifyListeners();

   Either<String, String> res = await userProfile.setupUser(user);
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