import 'package:recipe_app/View/all_libs.dart';

class UserProfileProvider extends ChangeNotifier {
  bool loading = false;
  bool success = false;
  UserProfile userProfile = UserProfile();
  String msg = '';
  int selectedPage = 0;
  ScrollController scrollController = ScrollController();
  double scrollPosition = 0.0;
  User? user;
  List<Recipe> listOfRecipes = [];
  RecipeRepository recipeRepository = RecipeRepository();

  UserProfileProvider() {
    listOfRecipes.clear();
    scrollController.addListener(() {
      scrollPosition = scrollController.position.pixels;
    });
  }
  Future<void> fetchUser(String uid) async {
    Either<String, User> res = await userProfile.fetchUser(uid);
    Either<String, List<Recipe>> resRecipe =
        await recipeRepository.getRecipes();
    res.fold(ifLeft: (value) {
      success = false;
      msg = value;
      throw value;
    }, ifRight: (value) {
      resRecipe.fold(ifLeft: (value) {
        success = false;
        msg = value;
        throw value;
      }, ifRight: (list) {
        listOfRecipes.clear();
        listOfRecipes.addAll(list);
        success = true;
        user = value;
      });
    });
    notifyListeners();
  }

  changePage(val) {
    selectedPage = val;
    notifyListeners();
  }

  toggleLoader() {
    loading = !loading;
    notifyListeners();
  }

  uploadPic(File image) async {
    try {
      FileService fileServiceUser = FileService(PROFILE_IMAGE_DIR, user!.id);
      String url = await fileServiceUser.uploadFile(image) ?? '';
      if (url != '') {
        user!.profilePicURL = url;
        await userProfile.updateUserDetails(user!);
      }

      notifyListeners();
    } catch (e) {
      print(e.toString());
      //
    }
  }
}
