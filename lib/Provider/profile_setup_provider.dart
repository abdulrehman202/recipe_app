import 'package:recipe_app/View/all_libs.dart';

class UserProfileSetupProvider extends ChangeNotifier {
  bool loading = false;
  bool success = false;
  UserProfile userProfile = UserProfile();
  String msg = '';
  File? profilePicture;

  Future<void> setUpUser(User user) async {
    toggleLoader();
    notifyListeners();

    if (profilePicture != null) {
      FileService fileService = FileService(PROFILE_IMAGE_DIR, user.id);
      String path = await fileService.uploadFile(profilePicture!) ?? '';
      user.profilePicURL = path;
    }
    Either<String, String> res = await userProfile.setupUser(user);
    res.fold(ifLeft: (s) {
      success = false;
      msg = s;
    }, ifRight: (s) {
      success = true;
    });
    toggleLoader();
    notifyListeners();
  }

  toggleLoader() {
    loading = !loading;
    notifyListeners();
  }

  updatePickProfilePicture(File? file) {
    profilePicture = file;
    notifyListeners();
  }
}
