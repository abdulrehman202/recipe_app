import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';

class DefaultProfileImageWidget extends StatelessWidget {
  const DefaultProfileImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(Constants.BASE_IMG_PATH+Constants.PROFILE_IMAGE_ICON, fit: BoxFit.fill,);
  }
}