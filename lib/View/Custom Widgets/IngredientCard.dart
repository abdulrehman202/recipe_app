import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';

class IngredientCard extends StatelessWidget {
  const IngredientCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 75,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Constants.RECIPE_CARD_COLOR,
        borderRadius: const BorderRadius.all(Radius.circular(10.0))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width*0.7,
            child: Text('Tomato ', style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 20), overflow: TextOverflow.ellipsis, )),
          const Expanded(child: Align(
            alignment: Alignment.centerRight,
            child:  Text('500g'))),
        ],
      ),
    );
  }
}