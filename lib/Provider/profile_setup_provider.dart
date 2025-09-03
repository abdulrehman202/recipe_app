import 'package:recipe_app/View/all_libs.dart';

class UserProfileSetupProvider extends ChangeNotifier {
  bool loading = false;
  bool success = false;
  UserProfile userProfile = UserProfile();
  String msg = '';
  
  Future<void> setUpUser(String name, bio, uid)async
  {
   toggleLoader();
   notifyListeners();
   
   User user = User('0',name, bio,'',[],[],[],[]);

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