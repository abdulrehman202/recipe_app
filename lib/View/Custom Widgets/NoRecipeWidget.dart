import 'package:flutter/material.dart';
import 'package:recipe_app/Constants/app_constants.dart';

class NoRecipeWidget extends StatelessWidget {
  const NoRecipeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text(NO_RECIPE_MSG),); 
  }
}