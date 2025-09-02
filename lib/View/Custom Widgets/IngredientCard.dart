import 'package:flutter/material.dart';
import 'package:recipe_app/Constants/color_palette.dart';
import 'package:recipe_app/Model/Ingredient.dart';

class IngredientCard extends StatelessWidget {
  Ingredient ingredient;
  IngredientCard({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10,),
      height: 75,
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        color: RECIPE_CARD_COLOR,
        borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width*0.7,
            child: Text(ingredient.name, style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 20), overflow: TextOverflow.ellipsis, )),
           Expanded(child: Align(
            alignment: Alignment.centerRight,
            child:  Text( '${ingredient.weight.toString()} g'))),
        ],
      ),
    );
  }
}