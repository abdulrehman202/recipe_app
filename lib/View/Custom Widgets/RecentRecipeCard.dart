import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Model/Recipe.dart';

class RecentRecipeCard extends StatelessWidget {
  Recipe recipe;
  String name;
  RecentRecipeCard({super.key, required this.recipe, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
        width: MediaQuery.of(context).size.width*0.7,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: Card(
              elevation: 10,
              child: Padding(
            padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: (MediaQuery.of(context).size.width*0.7) - 120,
                      child: Text(
                        recipe.name,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Wrap(
                      children: [
                        for (int i = 0; i < Constants.getNetRating(recipe.totalRating ,recipe.usersWhoRated.length).toInt() ; i++)  Icon(Icons.star, color: Constants.YELLOW_LABEL_COLOR,),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 20, bottom: 10, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 7,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipOval(
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Image.asset(Constants.BASE_IMG_PATH+Constants.DP_IMAGE, fit: BoxFit.fill,),
                                  ),
                                ),
                                   Expanded(child: Text(' By $name',overflow: TextOverflow.ellipsis, ))
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text('${recipe.duration} min', textAlign: TextAlign.end,))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.only(right: 10),
            child: ClipOval(
              child: SizedBox(
                width: 100,
                height: 100,
                child: Image.asset('${Constants.BASE_IMG_PATH}${Constants.listCategories[recipe.categoryId??0]}.jpeg',fit: BoxFit.fill,)),
            ),
          )
        ],
      ),
    );
  }
}
