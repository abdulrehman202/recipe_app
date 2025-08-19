import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Model/Recipe.dart';

class RecipeCard extends StatelessWidget {
  Recipe recipe;
  bool saved;
  late double netRating;
  RecipeCard({super.key, required this.recipe, this.saved = false});

  @override
  Widget build(BuildContext context) {
    netRating = (recipe.totalRating??0)/(recipe.totalUsersWhoRated??1);
    return Container(
      margin: const EdgeInsets.only(right: 20),
      width: 150,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 50),
              decoration: BoxDecoration(
                  color: Constants.RECIPE_CARD_COLOR,
                  borderRadius: BorderRadius.circular(20)),
              height: 175,
              width: double.infinity,
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                      recipe.name,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(fontSize: 16),
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                    )),
                    SizedBox(
                      height: 50,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              direction: Axis.vertical,
                              children: [
                                Text('Time',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(color: Colors.black)),
                                SizedBox(
                                    width: 70,
                                    child: Text(
                                      '${recipe.duration} min',
                                      overflow: TextOverflow.ellipsis,
                                    ))
                              ],
                            ),
                            ClipOval(
                                child: Container(
                                    padding: const EdgeInsets.all(7.0),
                                    color: Colors.white70,
                                    child: GestureDetector(
                                        onTap: () {},
                                        child:
                                           saved? Icon(Icons.bookmark, color: Constants.YELLOW_LABEL_COLOR,): const  Icon(Icons.bookmark_border))))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ClipOval(
              child: Container(
                height: 100,
                width: 100,
                child: Image.asset(
                  Constants.BASE_IMG_PATH + Constants.DISH_IMAGE,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: const EdgeInsets.only(top: 65, right: 10),
              width: 60,
              decoration: BoxDecoration(
                  color: Constants.BITMOJI_COLOR,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Row(
                children: [
                  const Icon(Icons.star),
                  Text(netRating.toString().padRight(2,'.0')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
