import 'package:flutter/material.dart';
import 'package:recipe_app/Constants/app_constants.dart';

class DefaultProfileImageWidget extends StatelessWidget {
  const DefaultProfileImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(BASE_IMG_PATH+PROFILE_IMAGE_ICON, fit: BoxFit.fill,);
  }
}