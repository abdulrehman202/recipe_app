import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';

class NoRecipeWidget extends StatelessWidget {
  const NoRecipeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('No recipe to show'),);
  }
}