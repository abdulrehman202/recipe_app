import 'package:recipe_app/View/all_libs.dart';

class DefaultProfileImageWidget extends StatelessWidget {
  const DefaultProfileImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(BASE_IMG_PATH+PROFILE_IMAGE_ICON, fit: BoxFit.fill,);
  }
}